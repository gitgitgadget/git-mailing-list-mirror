From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 00:18:45 -0700
Message-ID: <f329bf540707260018u21ad8e16h75cc9c3351fe0fc2@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
	 <7vps2fc196.fsf@assigned-by-dhcp.cox.net>
	 <20070726031838.GO32566@spearce.org>
	 <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0707260614500.14781@racer.site>
	 <46A8378A.6050201@xs4all.nl>
	 <Pine.LNX.4.64.0707260737170.14781@racer.site>
	 <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
	 <20070726071316.GE18114@spearce.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 26 09:18:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxcY-0006PC-6u
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758343AbXGZHSr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759605AbXGZHSr
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:18:47 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:33663 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758343AbXGZHSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 03:18:46 -0400
Received: by py-out-1112.google.com with SMTP id d32so826879pye
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 00:18:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ck6dLUA/CgUN0wlnJaXBtursrt3JgPJeW7FwNgfn8cHpA73OAR0SYc1k/AfpchUM3gGB0F2Bif3mjFpYy+ki/OPcwUeYG40qPq1RcZJznIDsS6Ste55p+frdc2GZKn3tmZvxgDGEn2tCCi0nVpTJz7Yj+EKZHouDRCVn6P8EO1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sVURw0Uw3g5QET8wESEFj2I5/1Hui5WxOVgPRqsR5IMN1GamZyEjluXmjynK3wMHPKwo1gKJ4uAhHW+iAEEcVR+L6mW/+YfSdrUACQf1rgxr3fbaMJZ4xQ2k4IijKVbTHBZEt6TOy4yrilYg1TE1Ia7Veb1h6inXXZtqnPo+2qU=
Received: by 10.65.116.10 with SMTP id t10mr2525865qbm.1185434325266;
        Thu, 26 Jul 2007 00:18:45 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Thu, 26 Jul 2007 00:18:45 -0700 (PDT)
In-Reply-To: <20070726071316.GE18114@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53799>

2007/7/26, Shawn O. Pearce <spearce@spearce.org>:
> Han-Wen Nienhuys <hanwenn@gmail.com> wrote:
> > 2007/7/25, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > >Did you succeed in adding perl?
> >
> > >It is not that important, because I plan
> > >to make git-gui the main user interface with this installer.  But Junio
> > >keeps adding Perl scripts (ATM add -i and remote) that I have to convert
> > >later...
> >
> > I don't see what this is good for.
>
> What git-gui is good for?  Its a GUI.  For people who perfer to use
> mice and push buttons over keys and a command prompt.  A large number
> of people in this world (many of them on Windows) like these things.
> Me, I'm more command line than I am GUI, yet I develop git-gui.
> So I find myself using it a lot, just so I can eat my own dogfood.
>
> Or do you mean Dscho's other point about rewriting tools into C?

The last one. The windows installers actually includes a copy of
tcl/tk so you can run gitk on windows. .

> > I would suggest to making a clear
> > decision of what are recommended languages, and move everything else
> > to contrib/ .. Currently, C and bash seem the most reasonable choice,
> > but you could decide for perl, but then the consequence should be that
> > the bash scripts are translated into perl. Having both bash and perl
> > serves no purpose, and will lead to duplication of library code to
> > interact with the git binary.
>
> Sure, but there's some stuff that shell is good at, and other stuff
> that Perl is good at.  Forcing everything into one mold while we
> prototype new features is really limiting.

I'm not contradicting that, but merely suggesting that they go into
contrib/ and are not recommended as standard git commands, and don't
need to be packaged for windows.

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
