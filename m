From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Wed, 24 Sep 2008 17:09:22 +0200
Message-ID: <81b0412b0809240809y4daa990cl5494d7b7398353f0@mail.gmail.com>
References: <20080923140144.GN21650@dpotapov.dyndns.org>
	 <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com>
	 <20080923165247.GO21650@dpotapov.dyndns.org>
	 <81b0412b0809240425t63a2a28cw1cc0c0d95b3290f7@mail.gmail.com>
	 <20080924140358.GX21650@dpotapov.dyndns.org>
	 <81b0412b0809240742g2918b300h9114579c4ebf05b4@mail.gmail.com>
	 <20080924150231.GO3669@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>, git@vger.kernel.org,
	"Johannes Sixt" <johannes.sixt@telecom.at>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Steffen Prohaska" <prohaska@zib.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:14:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiW0j-00088Q-8G
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbYIXPJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbYIXPJY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:09:24 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51589 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbYIXPJX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:09:23 -0400
Received: by gxk9 with SMTP id 9so5724021gxk.13
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 08:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EgyA6o/Jxd6ChrXXB/6X5R0P2WGUE5M1oKkoUsREZiw=;
        b=cWQuVyjA2Kq6dz/H54htgvrwNTp0XB1gCZPDLyJ+RmiYqGDi+9lfTJ3nXLclZAOd8z
         WfAUeyvzws1cPTdgcsIBL8yZXr7/7ATVuCOtZJQ57AScpxrzjFqHOQiOH+sTAN+rTgbS
         5M3QBMiqx8nYD3eurOz5JI2aZDRhkgWSf9ohA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=s0/vtLbE+vEqQ4kHIL9FlRs9Tek72ttxb3rvGY2yjJTPpvoRNZluKlYj9H3HJwR6ZH
         9S3mgmkib2xgYk3b8HwZKUFbQPsOP2EJDUQt063eCNqaqrhHCqk788CAbH4xwXiv9fdI
         0/JCKIzbNvAy4wHJ/lRcCBVOTylWWIdPKxbv0=
Received: by 10.151.107.8 with SMTP id j8mr11187691ybm.163.1222268962334;
        Wed, 24 Sep 2008 08:09:22 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Wed, 24 Sep 2008 08:09:22 -0700 (PDT)
In-Reply-To: <20080924150231.GO3669@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96645>

2008/9/24 Shawn O. Pearce <spearce@spearce.org>:
> Alex Riesen <raa.lkml@gmail.com> wrote:
>> 2008/9/24 Dmitry Potapov <dpotapov@gmail.com>:
>>
>> > Frankly, I don't have strong preference here neither for making this
>> > fast version always work nor leave it conditional (perhaps, with the
>> > default setting use-fast-version). So, whatever the majority decides
>> > is fine with me.
>>
>> I'm voting for compile-time configuration then.
>
> To be consistent with everything else, compile-time sounds like
> what we should do, its how just about every other part of Git
> is configured.
>
> However Dmitry pointed out that he has cases where this faster
> function doesn't work correctly, and it was path specific. Some
> areas of the filesystem work, others don't, on the same system.

Huh?! What are they? What paths require cygwin's handling
which aren't handled already? (the absolute paths are handled).
