From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: FFmpeg considering GIT
Date: Wed, 9 May 2007 08:38:48 +0200
Message-ID: <e5bfff550705082338p1a0c003lef230f96a3219ab8@mail.gmail.com>
References: <loom.20070502T111026-882@post.gmane.org>
	 <87y7k4lahq.wl%cworth@cworth.org>
	 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
	 <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
	 <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
	 <17983.6136.147062.346626@cargo.ozlabs.ibm.com>
	 <81b0412b0705070556o25289676i2df60ad84a2a4e13@mail.gmail.com>
	 <e5bfff550705072330h3b59f4a5off5f9e341ccf3e7e@mail.gmail.com>
	 <17985.19926.347089.878721@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Karl Hasselstr?m" <kha@treskal.com>,
	"Junio C Hamano" <junkio@cox.net>,
	"Carl Worth" <cworth@cworth.org>,
	"Michael Niedermayer" <michaelni@gmx.at>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed May 09 08:39:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlfp9-0007Yp-Fl
	for gcvg-git@gmane.org; Wed, 09 May 2007 08:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934912AbXEIGiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 02:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934936AbXEIGiu
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 02:38:50 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:22547 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934912AbXEIGit (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 02:38:49 -0400
Received: by nz-out-0506.google.com with SMTP id o1so89593nzf
        for <git@vger.kernel.org>; Tue, 08 May 2007 23:38:49 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lwx3c1DX1XpBbQuh9OXXrOhg2hVN8o9ZhN0eFHYeiFw50R35wyCJjTNV76nEEmsNUrTb2KBXHRKjlSo0nucn+HNoA0egFLJjzUyf7mBlAflYEZZ5ttohoNCNZa7XDAjI6xMd7nRspOanbIgAJJnPpXO9R7AHTGDoMhHxPVW03II=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j8YseQ8j4j1QJJ48P3CZUcoeDTn2mQGIwjdAqQZwuhvNUzu+tpXnHsIde0c/4jYIO0ccM2UlTLuH+ghIJABY68uijdyWMg0nGYbL49U6bxUtY65hRyUjEBoeTstpx2q/6j2FNZ0R4bCJNyhi4HzJbX8FkuwjgkSh8Wfwep2EFiM=
Received: by 10.114.199.1 with SMTP id w1mr85345waf.1178692728793;
        Tue, 08 May 2007 23:38:48 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Tue, 8 May 2007 23:38:48 -0700 (PDT)
In-Reply-To: <17985.19926.347089.878721@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46668>

On 5/9/07, Paul Mackerras <paulus@samba.org> wrote:
> Marco Costalba writes:
>
> > Language to use is C++, not C (much more powerful IMHO)
>
> Sorry, C++ is not an option because I dislike it so much.

Well, speaking about GUI applications, the 90% is in the graphic
library and only in small part in the language. With Qt we are at 95%

Anyhow does exist also python bindings for Qt.


>  The main
> reason for changing languages would be to enable people like Linus to
> hack on it more easily, and I don't think C++ would achieve that.
>

Poor Linus ;-)

I think the design of the application states the easiness of changes,
spaghetti code and bad designed functions are much worst then any ugly
language you can think about.

That's for substantial changes,  for one liners or for adding little
features encapsulation and modularity of the code are the magical
words here, and an object oriented language *could* help achieving
that.


> > P.S: If you choose Qt/C++ (the best technically speaking ;-)  please
> > you could consider starting from an already laid out code base instead
> > of starting from scratch.
> > As example, hmmmm, I think there is one called 'qgit', if I remember
> > correctly. It's nice and very very very fast.
>
> Yes, but isn't there already a talented hacker working on that? :)
>

Two is better then one :-)


  Marco
