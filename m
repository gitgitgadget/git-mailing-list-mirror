From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 00:02:01 -0700
Message-ID: <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
	 <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
	 <7vps2fc196.fsf@assigned-by-dhcp.cox.net>
	 <20070726031838.GO32566@spearce.org>
	 <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0707260614500.14781@racer.site>
	 <46A8378A.6050201@xs4all.nl>
	 <Pine.LNX.4.64.0707260737170.14781@racer.site>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 09:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDxMQ-000279-AY
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 09:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760091AbXGZHCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 03:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760029AbXGZHCG
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 03:02:06 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:15942 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759530AbXGZHCD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 03:02:03 -0400
Received: by py-out-1112.google.com with SMTP id d32so820110pye
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 00:02:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IdhCdmoBXRZIkVmVP5U1Hbq+QMISdmIuPOumAPdM5+IUZuS981NmGYZS9egWiPrV3TbmlQlT5TmjRH7MelNI6UpzaxJuqJQR432kPJI2DzW6si/FRbRDPGy+coZeerLnTaAkUMCVV9iUVoJVndht5Nf+b95iV9u3YuawRhI7i6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=atCL28DIUcuUHzZO34TKvzSzn92mc75ZghFqdm7crUtUtS5ZLmPvVeWm+wz7RmeOtuzI5dyG9Jbgl0LsenBKiK0zB+zBtiVgucxze1Phl4956uab65nYvT/YyYcCxc/u3aKv8tODS8kCPsBNl7K15H5ZjExIQp6RvoHRFzlF1iY=
Received: by 10.65.51.4 with SMTP id d4mr2495927qbk.1185433321842;
        Thu, 26 Jul 2007 00:02:01 -0700 (PDT)
Received: by 10.65.157.11 with HTTP; Thu, 26 Jul 2007 00:02:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707260737170.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53793>

2007/7/25, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> [Funny, you quoted me, but culled _me_ from the Cc: list]

It's because gmane does not do SMTP

> > If you supply me with a shell script that will x-compile bash, I'll
> > hapily code the python spec. IMO the real problem is that bash is a unix
> > shell (tied to unix internals) and therefore, compiling it for something
> > as horrid as windows is far from trivial.
>
> Will do.
>
> Did you succeed in adding perl?

God forbid no. Perl is enormous, and I shudder at the thought of
making all those modules compile, or even worse, writing actual perl
code.

> It is not that important, because I plan
> to make git-gui the main user interface with this installer.  But Junio
> keeps adding Perl scripts (ATM add -i and remote) that I have to convert
> later...

I don't see what this is good for.  I would suggest to making a clear
decision of what are recommended languages, and move everything else
to contrib/ .. Currently, C and bash seem the most reasonable choice,
but you could decide for perl, but then the consequence should be that
the bash scripts are translated into perl. Having both bash and perl
serves no purpose, and will lead to duplication of library code to
interact with the git binary.

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
