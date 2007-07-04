From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-repack: generational repacking (and example hook script)
Date: Wed, 4 Jul 2007 09:02:13 +0200
Message-ID: <81b0412b0707040002k5afb1851kdc6581192a7a4191@mail.gmail.com>
References: <1183193781941-git-send-email-sam.vilain@catalyst.net.nz>
	 <11831937822950-git-send-email-sam.vilain@catalyst.net.nz>
	 <11831937823588-git-send-email-sam.vilain@catalyst.net.nz>
	 <1183193782608-git-send-email-sam.vilain@catalyst.net.nz>
	 <alpine.LFD.0.999.0707022331080.26459@xanadu.home>
	 <4689D77D.20601@vilain.net>
	 <alpine.LFD.0.999.0707031020300.26459@xanadu.home>
	 <468AE462.1040202@vilain.net>
	 <Pine.LNX.4.64.0707040155240.4071@racer.site>
	 <468B3B42.2040103@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Sam Vilain" <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:02:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5ysV-0008DB-R1
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 09:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbXGDHCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 03:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753429AbXGDHCQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 03:02:16 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:10550 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbXGDHCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 03:02:15 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1560816ika
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 00:02:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UE0HIvuZAUlQubAxGQbCtWl/br7O21NA9bGX5ISFBJd14W7PF5hHR2NkyYzKPZF2gEGlnQ2PPaxLH8q3cc/2oRZbYUN/AXXugT3J2A2EBzEXTJQwHlwYWXJKYhlu3HpyGXCd2PvkOM2ghgVNpZ0FjesrW8fIXrXuaMj/ow+8hyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DrNZKjwOwx9O0lEysjPM6dsWpeZyUThCGeGy1JaAD1dgpCu8RWjLsro0GVOwulkycV8wv36XYs7aKQKf5Vqw6pNawZjUG6m5HVzQ9uXc5LBQS39MeQqXNfNxiVlzoRdAOwpghj0TUhuC1CNaset4SCYygnBvayb5F5it/Dm1usg=
Received: by 10.78.147.6 with SMTP id u6mr3908594hud.1183532533390;
        Wed, 04 Jul 2007 00:02:13 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 4 Jul 2007 00:02:13 -0700 (PDT)
In-Reply-To: <468B3B42.2040103@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51573>

On 7/4/07, Sam Vilain <sam@vilain.net> wrote:
> Johannes Schindelin wrote:
> >>>> 1. Do you agree that some users would want their git repositories to be
> >>>> "maintenance free"?
> >>> I'm not so sure.
> >> Well, no offence, but I think you should withhold from voicing a
> >> fundamental concern as this, because you're not one of its target users.
> > Let's put it this way. A lot of car drivers would probably agree that it
> > is a Good Thing (tm) if their car automatically went to get gas, before it
> > ran out of it. Less hassle, right?
> >
> > Yes, except if your car decides to get gas when you are already late,
> > speeding, trying to catch your plane.
>
> Ok, but if you're only packing a few hundred objects it usually won't
> matter because it is fast enough that you hardly notice.

Unless you are on Windows, MacOSX, a notebook with P233, or unless
it is your home server in cellar built out of decommissioned desktop
(trusty old P133 with reasonable (for such a thing) 256Mb).
