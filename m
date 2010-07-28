From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Sparse clones (Was: Re: [PATCH 1/2] upload-pack: support subtree 
	packing)
Date: Wed, 28 Jul 2010 17:59:20 +1000
Message-ID: <AANLkTi=zgbT=uw=t18mBUHMxg050pMx_YD835Gbontph@mail.gmail.com>
References: <AANLkTikJhSVJw2hXkp0j6XA+k-J-AtSYzKWumjnqqsgz@mail.gmail.com>
	<AANLkTikMLOFet-VMT7MntPgoSkvqGAXPd8Z1aaDpY1xs@mail.gmail.com>
	<AANLkTin3OB6mw6rih208ybCL2+QQ8LpuCP5y=DywMuyw@mail.gmail.com>
	<AANLkTinpGO=TU3+1wZw68tUmPL8yQatPUEJ6uTGynbHq@mail.gmail.com>
	<AANLkTi=WjBHYngSDgowD2+0FT3hG+oDYefp2aUostV3U@mail.gmail.com>
	<AANLkTiktuQV+jEOy+Shm13-LVc0W-d8qsGS6XuxyTW44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 09:59:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oe1Xy-0007Wo-HB
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 09:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726Ab0G1H7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 03:59:21 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55375 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab0G1H7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 03:59:21 -0400
Received: by qyk7 with SMTP id 7so3369482qyk.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 00:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0D4rSVh597X1wCnl0fxV1MJaJeimYp2ppuLWo2Zr85M=;
        b=LHKQ+tIcZmPuXh5AoZREEcYPlI8mbSqIWZF2539mxf9FRaqwFJ1jdXc2FtuYUDH26y
         GkgY+a8Zb29Ym6tf43c0/xFsLrV4ze4eneuLfojWf1bLHArdXtpJeRcn4spiFTaT5++5
         KCruW3VGjgXUc4ebYnaBOjamMWno4FWVLxh7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=aNGWxG3kjVm8CqOkAm/y8Mv+7mB83x5lgbWvJd6FU+lZJmzFWuWUSGn2vDnRtcde6F
         /7TBV2hlX7qC/FpOTwoWyxCSW51MjRn0VdyboqbdPJbNnr+BCriVAAvQaaanhgw1nuGD
         Q2YNnk7FuvqWXP5Pl9m4+hkWmwKtoDsg2ctj8=
Received: by 10.224.66.23 with SMTP id l23mr8215766qai.152.1280303960246; Wed, 
	28 Jul 2010 00:59:20 -0700 (PDT)
Received: by 10.220.101.201 with HTTP; Wed, 28 Jul 2010 00:59:20 -0700 (PDT)
In-Reply-To: <AANLkTiktuQV+jEOy+Shm13-LVc0W-d8qsGS6XuxyTW44@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152055>

On Wed, Jul 28, 2010 at 4:12 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> OTOH, I'm not only concerned about bandwidth, just
> being able to run 'git status' without it taking half a minute would
> be sweet.

Doesn't assume-unchanged bit or sparse checkout help?
-- 
Duy
