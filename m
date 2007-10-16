From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: How to Import a bitkeeper repo into git
Date: Tue, 16 Oct 2007 11:11:17 +0200
Message-ID: <e5bfff550710160211g5dbfa7fai95386b173edc45c3@mail.gmail.com>
References: <598689.78740.qm@web56015.mail.re3.yahoo.com>
	 <20070709173720.GS29994@genesis.frugalware.org>
	 <alpine.LFD.0.999.0707091049080.31544@woody.linux-foundation.org>
	 <4713FA4A.5090501@bluelane.com>
	 <alpine.LFD.0.999.0710151711280.6887@woody.linux-foundation.org>
	 <471433F3.40606@bluelane.com>
	 <e5bfff550710152156t33ba10dam6171e3210c18d3ac@mail.gmail.com>
	 <471454B5.7040802@bluelane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	VMiklos <vmiklos@frugalware.org>,
	"free cycle" <freecycler23@yahoo.com>, git@vger.kernel.org
To: pete@bluelane.com
X-From: git-owner@vger.kernel.org Tue Oct 16 11:12:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhiT2-0003cc-Th
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 11:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918AbXJPJLU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 05:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756345AbXJPJLU
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 05:11:20 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:55016 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330AbXJPJLS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 05:11:18 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1162686nze
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 02:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LVKlbUt9jX9v8zrRuVe4iry3NqLdAFZtBKpyj9zfwCM=;
        b=Cdtzih+5VULPWuG4GlyXbDbSSpKmkUamFg1IVc6oI5HctFdetEk+Co2s1TvA8w3BvZiYQmlBegmEAOkiSkaSZxu4gyDjwt/tS7tBg/Zf5xlaN1mwNaP9cGOh6rI8MO1J6LNz3rMTTYahaBMnOQ3me3DnB064CtKjyAr7v2G0Nl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IHjE8SPd2kmQ4YpICYGPYhbQgMaVgC5S6LrmxigBTee5ycm0DF6UjnQMvdEG+3zq44l1zcw4WXeaYpG1UxBV7FS0UiiONwq3cIG0UVKZKN1NImDxi1CiMq/wXDtZIeqRCZc1Z4HHEXrpPZ7NFOXy+77c3USwfZNebiiU51fJLS4=
Received: by 10.141.41.12 with SMTP id t12mr3327670rvj.1192525877318;
        Tue, 16 Oct 2007 02:11:17 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Tue, 16 Oct 2007 02:11:17 -0700 (PDT)
In-Reply-To: <471454B5.7040802@bluelane.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61125>

On 10/16/07, Pete/Piet Delaney <pete@bluelane.com> wrote:
>
> It's not quite a intuitive/familiar as with bitkeeper. I suspect I just
> need some practice. I selected a huge list if files that we use to
> filter the release with and double clicked on the file I thought showing
> to focus on that file. The I pulled down External Diff and it took for
> ever; like it's confused.
>

You shoudl select only _one_ additional revision.

The currenlty selected revision is the base + select another one
(only) with CTRL + *RIGHT* click (the file list change background
color) , then call external diff tool.

> Often we/I want to see the rev history for a particular file.
> How would you do that with Qgit?
>

Select the file from the file list (right bottom pane) or from the
tree view (use key 't' to toggle treev view) double click on it or use
context menu (right click on the file name) and that's all.

>
> Can I see just the revs for a particular file?
>

See above.


I know I'm going to tell you a very _unpopular_ thing, but, in case
you have 5 minutes of spare time (yes, it doesn't take longer), open
qgit then please press a nice key called 'F1', a nice handbook will
appear...

I really suggest to look at it. To keep UI 'clean' a lot of features
are not immediatly visible, so reading the handbook (at least the
chapter's titiles) would give you a better idea of what qgit could do
for you.

>
> I'll get the latest and greatest. Thinks. Often the problem is
> having the current version of Qt3. My workstation is Mandrake
> 1005 Limited Edition (X11 Xinerama works on this release).
> Looks like I have Qt3 on my workstation. Would it be worthwhile
> to install Qt4 from src and try to use qgit-2.0?
>

Yes it is. There are a lot of new featrures, is almost as stable as
the previous and if you are interested in file history (annotations)
in qgit-2.0 this feature has been greatly speeded up.


Have fun
Marco
