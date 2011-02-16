From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 09:58:52 +0000
Message-ID: <AANLkTimj9NCR2Kkiz82WW1qx1NY-ptS4Qn2yzPqoLGP0@mail.gmail.com>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
 <20110216023645.GA7085@sigill.intra.peff.net> <20110216032047.GA2858@elie>
 <AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
 <20110216085114.GA9413@sigill.intra.peff.net> <AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
 <20110216095415.GA12578@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 10:59:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpeAd-0005EF-VB
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 10:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758871Ab1BPJ7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 04:59:34 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51410 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab1BPJ7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 04:59:33 -0500
Received: by gyb11 with SMTP id 11so512326gyb.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 01:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=GmnLMAn4mB0PAwbK+7tyLsasQeV8PQuwOVd77iNXAx4=;
        b=RaDy9mKtfSDhkdQFD6IyHl7944LNHsh2J5GXdMpRfAn2Kp3uklELZ4NMg1AhdS1NTV
         zW8nwH78cusqNMId0XzuuxEvYoaYuGT6Pbh/SMU11zDf184srAUl2pH5yXDMDtc25mW0
         nOH4indbV02z8aXiHPYcnZmRQLCT7EKGmazls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tXHbxPy4TurbakvFfmP/itmBRT49vOAiJtPvW9dksptQ/1x5LMVuD8MsOKGgrMVL6N
         S6si4lQH96mYwvgaerMiC+OzT0F0bZWQAnAeNYpTo9crq2OqtNFGc3BXL1kDTw75nrBv
         GVCKhQHewKEnuFfdhKi+s7ciUtbuSdNDhPxp0=
Received: by 10.150.133.10 with SMTP id g10mr493181ybd.222.1297850372427; Wed,
 16 Feb 2011 01:59:32 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Wed, 16 Feb 2011 01:58:52 -0800 (PST)
In-Reply-To: <20110216095415.GA12578@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166942>

Heya,

On Wed, Feb 16, 2011 at 09:54, Jeff King <peff@peff.net> wrote:
> So? Your question was whether index state is precious. If it's precious,
> shouldn't we be keeping a history of it?

I don't think it's quite _that_ precious, but the only operation that
I regularly use that can blow away my carefully constructed index as
side effect of doing something else is `git commit -a`.

-- 
Cheers,

Sverre Rabbelier
