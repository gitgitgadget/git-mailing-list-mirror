From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: git-filter-branch exits early
Date: Wed, 11 Jul 2007 08:02:54 +0200
Message-ID: <81b0412b0707102302i34a51baax464f8c7c69087b7d@mail.gmail.com>
References: <20070710205202.GA3212@steel.home>
	 <Pine.LNX.4.64.0707102222430.4047@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Sven Verdoolaege" <skimo@kotnet.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 11 08:28:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8VgL-0007xE-ES
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 08:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756294AbXGKG2K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 02:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755093AbXGKG2I
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 02:28:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:29683 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbXGKG2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 02:28:07 -0400
Received: by ug-out-1314.google.com with SMTP id j3so48612ugf
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 23:28:06 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LQbbTb5SXKv+9+AfhLJ31OrQMA5skIWTuB9eCdykZbowubnvkS5kcirsIXWJOafyG6vMZo8bHBl7ZvuXy3KVt04R8NzfcKxY6c95ZSOTssH0kzVDNOa7xkzPQFAa+OtMEjvqJ40yPZQSj5y8xZwnX8ljcym6UGeZkiFzfo0ye04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YRokReDR9iy9PCAQT0Vpt8f2WHi7QSnvoy8AMljUJ8MmdSHvlE3w8jTnPElSmDnC/b4mPegu3fjRTH9Lb32k2KlJMU/At0WDCn5ALpz4vJBifBCCxmDc0hhAWyzySpYEsRoNb6jek0BOpj8AtHtoXQk2jghtNOuQl0l6q9JsvdE=
Received: by 10.78.149.13 with SMTP id w13mr2313356hud.1184133775827;
        Tue, 10 Jul 2007 23:02:55 -0700 (PDT)
Received: by 10.78.118.19 with HTTP; Tue, 10 Jul 2007 23:02:54 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707102222430.4047@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52134>

On 7/10/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 10 Jul 2007, Alex Riesen wrote:
>
> > I have a Debian system where git-filter-branch exits immediately after
> > "unset CDPATH" in git-sh-setup (the command exits with 1, as CDPATH is
> > not defined). The system still has bash-2.05a.
> >
> > git-filter-branch has "set -e", which is why the script finishes
> > prematurely. If this is not really needed, maybe it can be removed?
> >
> > I'll see if the system can be upgraded, but I suspect someone can get
> > a similar problem.
>
> I do not really understand why "unset CDPATH" should trigger an error.  I
> guess that this is one of the nice braindamages in dash, right?

in bash. Bash-2.05.a

> Anyway, "set -e" was one thing I wanted to fix. ...

BTW, what can break if I just go on and remove it?

> - since it is a C program, it should be more stable, eventually, than a
>   shell script, where you have to work around limitations all the time,

right :)
