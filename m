From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Inconsistencies with git log
Date: Fri, 9 Nov 2007 13:04:16 -0500
Message-ID: <9e4733910711091004p6b5dd0c3x2c92148a51dd9927@mail.gmail.com>
References: <9e4733910711071415i1729e277u6be19b72cd682a85@mail.gmail.com>
	 <9e4733910711071503va92a653s25fd978989d5917d@mail.gmail.com>
	 <Pine.LNX.4.64.0711072309380.4362@racer.site>
	 <9e4733910711071529m604f3b12v29b3a040074ea4e@mail.gmail.com>
	 <Pine.LNX.4.64.0711080003080.4362@racer.site>
	 <9e4733910711071609t3e5412f1mf02e501b2d820bb3@mail.gmail.com>
	 <alpine.LFD.0.999.0711090747210.15101@woody.linux-foundation.org>
	 <9e4733910711090920m6b0b7704x7c5a3849215f385c@mail.gmail.com>
	 <alpine.LFD.0.999.0711090929130.15101@woody.linux-foundation.org>
	 <alpine.LFD.0.999.0711090943120.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqYDg-0005EY-Jk
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 19:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbXKISEX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 13:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbXKISEX
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 13:04:23 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:28665 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbXKISEW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 13:04:22 -0500
Received: by nz-out-0506.google.com with SMTP id s18so580741nze
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 10:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4J7tkS5FAK+pWschbsOFFV1jx6J7ZA+iwAoJIdTtTPM=;
        b=QkpVXbMvcQllhJVLk1ZGBxMM0OeB7XbUM6pQaK9+wFTK6/Jo7UnckeKBn0Y97h+LUkx6hGdDGolgfihavsRtgx4mYhgkU/rE/3Vc6gRf13ce1111aau9VC08P2IdUCUVZTo0cQQv0tz/G71hI//ts6ZtSi/u/XP45+RWYLky9BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d2aCUlxhJfaVdpzXczEpOa0ZV63RyZ1f65X+6CfNQh/Hta7MXonAA+9sRFjIFOYeyRMnY6BXs34Pge3zxRbYapLowp46NwrNcktES3gTz56kcAqu/QAvWuhVPCrGrgKoj/00ru6PPR+iT1NpAU0EvYa3Yixnipehh24gv7qtjb8=
Received: by 10.115.108.1 with SMTP id k1mr191736wam.1194631456784;
        Fri, 09 Nov 2007 10:04:16 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 10:04:16 -0800 (PST)
In-Reply-To: <alpine.LFD.0.999.0711090943120.15101@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64236>

On 11/9/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Fri, 9 Nov 2007, Linus Torvalds wrote:
> >
> > In fact, even at the top-of-tree, "git log" and "git log ." are two
> > totally different things [...]
>
> Btw, the reason (and really the *only* reason) this is interesting at all
> is just to show that the notion of "full history" and "relative pathnames"
> really have nothing to do with each other. They really are in totally
> different and orthogonal dimensions.

Should "git log" and "git log path"  have two different command names?

> "Full history" is something that exist *independently* of the pathnames.
>
> So the fact is, "git log" on its own is really about the *project*. It is
> totally pathname-independent, and I'd argue that many people are often
> just interested in the explanations (even though you obviously can also
> see the patches and the files changed too!) so I seriously doubt that this
> is just an implementation issue or my personal hang-up.
>
> In other words "git log" simply is something *global*. It doesn't matter
> where in the tree you are, the end result is the same - it's about the
> project as a whole.
>
> In contrast, "git log <filename>" is fundamentally different. Now you're
> explicitly stating that it's not something global any more, and that it's
> about the *files*. That's also why "git log" and "git log ." are acually
> different even at the top level.
>
> Because when you're interested in the files, by implication you're not
> interested in commits that don't change the files - and there can be such
> commits even when you give the *total* file list.
>
>                         Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
