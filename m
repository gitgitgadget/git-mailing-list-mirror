From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [minor BUG] cherry-pick -x doesn't work if a conflict occurs
Date: Wed, 5 Jan 2011 11:37:39 -0500
Message-ID: <AANLkTi==nMhcN538ekww3FEYFxhOqDqj4_Z7xg0a0B0Z@mail.gmail.com>
References: <20101229141638.GA14865@pengutronix.de> <24C35180-AED6-4848-9F05-908831F911F9@dewire.com>
 <20110105065047.GJ25121@pengutronix.de> <AANLkTimi8s7QRYuEgr2x=bqwEuFPqUUQF4E=f=_PsoV0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Jan 05 17:38:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaWNN-0006rh-OF
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 17:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534Ab1AEQiL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 11:38:11 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34312 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1AEQiK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 11:38:10 -0500
Received: by iyi12 with SMTP id 12so14070996iyi.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 08:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RThoBpcfxLPV0GDp9B634b5z7tsUfQC6gpe64mPbHAQ=;
        b=EwqXxRsLA1qd+ZeNQY1e+2DfjJTj/P9kIF+Ce/sS/UjaM95SqvDreFSj++4uQIvs2Q
         KsiTACPIqmntLJnGI0nIoPWoBpA3CUxPTxO5dNr9apS8M6GcDbKGMINXigIFZEg699rO
         9kxoWjHHYze+Reebc+QfFWDVD+5cYMcH6ZhlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GtZikYcE9A+xtdyVj6/mSf4wDoxY3/L/Lm96zbKWabIBOTeH+BN0IORGuJznV3wg1O
         b1HYRX9LP+tRIrJQp9GW4KQZVNObKKOarLA5EVexT/EerRthv8JuS+pQVCVIrvuKljzu
         eBA14Ax07HdsJSXRFTVfMEPuZtYWblLLCrvK4=
Received: by 10.231.200.138 with SMTP id ew10mr7245669ibb.59.1294245489481;
 Wed, 05 Jan 2011 08:38:09 -0800 (PST)
Received: by 10.231.167.78 with HTTP; Wed, 5 Jan 2011 08:37:39 -0800 (PST)
In-Reply-To: <AANLkTimi8s7QRYuEgr2x=bqwEuFPqUUQF4E=f=_PsoV0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164571>

2011/1/5 Jay Soffian <jaysoffian@gmail.com>:
> 2011/1/5 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
>> ah, I wonder if this is intended or just documenting a short-coming =
:-)
>
> I think it's intended as it's no longer the original commit, but

Ah, seems to be a documented short-coming after-all:

  http://thread.gmane.org/gmane.comp.version-control.git/61737/focus=3D=
61933

j.
