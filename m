From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] add GIT_FAST_STAT mode for Cygwin
Date: Wed, 24 Sep 2008 16:42:03 +0200
Message-ID: <81b0412b0809240742g2918b300h9114579c4ebf05b4@mail.gmail.com>
References: <20080923140144.GN21650@dpotapov.dyndns.org>
	 <81b0412b0809230737s7498e214w4c58991e79f76507@mail.gmail.com>
	 <20080923165247.GO21650@dpotapov.dyndns.org>
	 <81b0412b0809240425t63a2a28cw1cc0c0d95b3290f7@mail.gmail.com>
	 <20080924140358.GX21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Johannes Sixt" <johannes.sixt@telecom.at>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 16:43:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiVaH-0005ND-Ft
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 16:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbYIXOmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 10:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYIXOmH
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 10:42:07 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:49200 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbYIXOmG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 10:42:06 -0400
Received: by gxk9 with SMTP id 9so5677673gxk.13
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=HL/UjsAZibotUnwZlCf2oTzu25qym4mhXyKxt9RSc9k=;
        b=fgRgMohenLutJkP8Dybd/cnv1G++5VWBagekqNwJKLoBlXXLZ4aVpXUnnryZOML+66
         mTsef0qPjZlG0fHHuPGrSBqzfX+Ll+hK4cY9Ax9JOJ/Jvcy6STYFRIGodh8w8y2r51iS
         QhlKRKpITppR2MmYUjsh5IjUR6viOxv/PbWcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ge+WfQ+oA+uSoSokq6tuK7M9RB1GwDe9SfKsPIxo9a/zcLw6gEKm2CeQpA8bMP3t8T
         5qaxpSHWIE3Xtv4JAqrs5b4vdav32QBolpbfT8VzR4DxFh1ZKCArRUVpEXVNVGH3ZOF3
         U80GhcoUEZaZmnZn7BnH2IsYUY9wEYKYF76BM=
Received: by 10.150.155.13 with SMTP id c13mr11131671ybe.164.1222267323908;
        Wed, 24 Sep 2008 07:42:03 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Wed, 24 Sep 2008 07:42:03 -0700 (PDT)
In-Reply-To: <20080924140358.GX21650@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96637>

2008/9/24 Dmitry Potapov <dpotapov@gmail.com>:
> it works fine in almost all practical cases I aware of, but I cannot
> guarantee identical behavior in _all_ cases.

Well, make it as good as MSys/Cygwin's and no one asks for your guarantee.

> Frankly, I don't have strong preference here neither for making this
> fast version always work nor leave it conditional (perhaps, with the
> default setting use-fast-version). So, whatever the majority decides
> is fine with me.

I'm voting for compile-time configuration then.

>> Besides it will remove your setup code, which looks bigger and provoked
>> more discussion than the real subject itself.
>
> I believe Shawn wanted it to be configurable on per-repository basis.

which, I believe, is pointless.
