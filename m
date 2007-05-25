From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: Problem using git svn clone
Date: Fri, 25 May 2007 08:39:23 -0700
Message-ID: <m23b1kkj4k.fsf@ziti.local>
References: <bf7b2dda0705241435t1563008o3c47607343a34a56@mail.gmail.com>
	<m2wsyxnbd9.fsf@ziti.local>
	<bf7b2dda0705241539i56f1b5b3kcd001e871e8688ef@mail.gmail.com>
	<m21wh5kn3b.fsf@ziti.local>
	<bf7b2dda0705250746p33cb198exe1fe5daa6b18d801@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Gustaf Hendeby" <hendeby@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 17:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrbt9-0005i1-5C
	for gcvg-git@gmane.org; Fri, 25 May 2007 17:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbXEYPjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 11:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXEYPjb
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 11:39:31 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:50505 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbXEYPja (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 11:39:30 -0400
Received: by nz-out-0506.google.com with SMTP id n1so363709nzf
        for <git@vger.kernel.org>; Fri, 25 May 2007 08:39:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=Ukn0gMOJo1oQEaOhAnAEci6aVqXzvoUXtNDtS5lMOWM67LvxYff3qNbgyBH3mRX5JaXUmg6aDjfMWw4UzjhcApaKQKegycK/a7jptVRozFrvdsLTzUncHVon4UGBZ8p3u96lsWkTQg/hNIurqjWKwt/LyFVRMwIztURIMuJ5yBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:to:cc:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=s/zUIz/AtTAxizbAfe9KQrl5EC8BncZNgJ2wS27A4lHXiY3EHkIhGtRtQwqajGFhrfMD7QrmwmFmgyy9v4HOWxbibZseAdHR9DY9J6q02GrXcBHMBT6pgczx6PbOAwXQotrtkrzt1oDOltGlEWKUZcOb4a6cbBoV4QZRA/UW++Q=
Received: by 10.114.46.1 with SMTP id t1mr1539290wat.1180107569116;
        Fri, 25 May 2007 08:39:29 -0700 (PDT)
Received: from ziti.local ( [24.19.38.22])
        by mx.google.com with ESMTP id n20sm3060376pof.2007.05.25.08.39.27;
        Fri, 25 May 2007 08:39:28 -0700 (PDT)
In-Reply-To: <bf7b2dda0705250746p33cb198exe1fe5daa6b18d801@mail.gmail.com> (Gustaf Hendeby's message of "Fri, 25 May 2007 16:46:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48390>

"Gustaf Hendeby" <hendeby@gmail.com> writes:

> On 5/25/07, Seth Falcon <sethfalcon@gmail.com> wrote:
>> "Gustaf Hendeby" <hendeby@gmail.com> writes:
>> > Let me clarify. When trying to check out the module with tags, the first
>> > example I only get the revisions, no content at all!  I have added some more
>> > info on this below.
>>
>> If you see the output of the revisions being pulled from svn this
>> seems very odd.  Does a 'du -sh' in the created directory confirm no
>> data is there?  Are you sure it isn't just a matter of nothing getting
>> checked out for you?
>
> The following result is the same directly after the clone attempt and
> after a git checkout -f master:
>
> $ du -hs
> 357K    .
> $ ls -a
> .  ..  .git
>
> If it is just not checked out I don't know what I'm doing wrong trying
> to check it out.

That does seem like either something is broken or not doing what you
expect (how's that for non-informative?).

I'm not sure I have enough expertise to help further.  If you care
about getting to the bottom of this, then I suspect you need to help
specify something that can be reproduced by others (which can be
difficult).

In the meantime, if I understood your comments, you did find a way to
clone the repos as you wanted just with a different command line...

+ seth

-- 
Seth Falcon | Computational Biology | Fred Hutchinson Cancer Research Center
http://bioconductor.org
