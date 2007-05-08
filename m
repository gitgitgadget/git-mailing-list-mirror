From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Tue, 8 May 2007 17:35:32 +1200
Message-ID: <46a038f90705072235n16fbb130q9660df38cb9f3e66@mail.gmail.com>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org>
	 <vpqbqgxak1i.fsf@bauges.imag.fr>
	 <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
	 <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 08 07:35:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlIMM-0008Cj-Hd
	for gcvg-git@gmane.org; Tue, 08 May 2007 07:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967923AbXEHFfd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 01:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967927AbXEHFfd
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 01:35:33 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:9655 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967923AbXEHFfd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 01:35:33 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1626238wxd
        for <git@vger.kernel.org>; Mon, 07 May 2007 22:35:32 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pfJUs8mg7OG5x9jC6u3uvrwfebv4LyrOAkwXReAbbrUtBNWSVZxOWfx06QGSAgg9E3fm2di2WEJb2gNJ/m71SlMfntbvGLtgDEewWdaAQRcTlcr+uTq9H+QMrYP6BPddKZdL7o5j2jrQo+OdLSptz/3zbCYmmEcOALGhk3+OB6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D+bAVNzckEaI4eOyzcHrIFANr1+W5jkqvyMaYVmnj5kaMPYfq03GECXujWE8H6d2nE5ckANHvY7srzCqtshSvVC4rWeZ2gVGv0Hr3VXvFkAChmiilMVILzNqgMtnvQYFT699LIoETZyXBqyW+yoy5+rBOhduxemW5rYFA30zDvI=
Received: by 10.90.80.8 with SMTP id d8mr5893505agb.1178602532245;
        Mon, 07 May 2007 22:35:32 -0700 (PDT)
Received: by 10.90.75.15 with HTTP; Mon, 7 May 2007 22:35:32 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46544>

On 5/8/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 8 May 2007, Martin Langhoff wrote:
> > Heh. Making the index very visible makes sense when you are merging,
> > Linus and Junio are both integrators and spend a lot of time merging.
> > Hence the default is for git-commit to observe the index.
>
> It is definitely true that some of the advantages of the way git does the
> index really start shinign when merging and you have content conflicts.
> What we've done to "git diff" really makes things a lot easier (and
> anybody who hasn't used "gitk --merge" after a content conflict really
> hasn't realized how *helpful* git is when merging content conflicts).

Totally, when merging git's approach is incredibly useful. gitk
--merge and the resolved conflicts not appearing in the default git
diff is great stuff.

For for small, simpleminded and mostly-linear development it's not
that important. Of course, I use git on projects large and small, so I
can understand it. For someone using it with a small mostly-linear
project, the whole index thing is overkill, and the explanations
pointless. I can understand people wondering WTF.

> So the whole "update stuff to be committed explicitly" ends up _really_
> shining during a merge, but it actually is how I do non-merge development
> too.

On a large project it's always a good idea to commit with explicit
paths -- regardless of your SCM. As it happens, I have to use explicit
paths with CVS, or it'll punish me by taking solid minutes to do a 2
file commit. I am sure that the mozilla and OpenOffice developers
using CVS also commit with explicit paths. Life's too short to waste
an hour.

(The times are from working on Moodle, hosted on SF.net with ~4K
files, 700 directories.).

cheers,


m
