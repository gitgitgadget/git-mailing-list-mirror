From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] {fetch,receive}-pack: skip sha-1 integrity test on
 objects from new pack
Date: Fri, 16 Mar 2012 09:28:19 +0700
Message-ID: <CACsJy8D5UNd5b=Dpt75Qrc96u6wRLffB7eGSsKqM3qQ37p4cOw@mail.gmail.com>
References: <7vfwdq8914.fsf@alter.siamese.dyndns.org> <1331736055-21019-1-git-send-email-pclouds@gmail.com>
 <7vy5r1inax.fsf@alter.siamese.dyndns.org> <7vsjh9il3l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 03:28:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8MuV-0002ZE-O2
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 03:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab2CPC2v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 22:28:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33965 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193Ab2CPC2u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 22:28:50 -0400
Received: by wibhq7 with SMTP id hq7so159750wib.1
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 19:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BLafzc0CwiMdxEdEIUucGmBubvPMZ6C+cANwp1xBOOM=;
        b=Te2zpVJ7S/DFLsxEcqDQU/6lzMBq0UoX+ZQETL8/0kNPHPNSoyvp9SqV5WAxAWYT92
         kxynKNMxToyvzGQyu6YD+HeTX8UzdxCV59qwnBfCLnJToEw56Oob/AtHGWefuNCukefT
         jKa/WiCBLT7iIsZd1/S2mN4DGjcDa7LAYdpR1c2AXrx0szXoOMepMIXVImItlkIz5hws
         vWNAoBfi2bRJRyB5fWeb9iqfQmpQD+sTwrq0WQd7zydqIbMu3pLQqSrAiJCIdXU1Tj6O
         bnyYPJSyjBktFDIclLnA473XkHd/odSKygrNaiSUJ4aZ3lzplLIRLOVDO/lnwG15I14p
         nlFg==
Received: by 10.216.134.200 with SMTP id s50mr455427wei.116.1331864929569;
 Thu, 15 Mar 2012 19:28:49 -0700 (PDT)
Received: by 10.223.13.5 with HTTP; Thu, 15 Mar 2012 19:28:19 -0700 (PDT)
In-Reply-To: <7vsjh9il3l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193239>

2012/3/16 Junio C Hamano <gitster@pobox.com>:
> Following the above train of thought, the patch to revert what 6d4bb3=
8
> (fetch: verify we have everything we need before updating our ref,
> 2011-09-01) did which caused this performance regression should look =
like
> this. =C2=A0"tag --contains 6d4bb38" tells me that this affects every=
thing
> since v1.7.8-rc0 so we may want to issue maintenance updates once thi=
s
> proves good in 1.7.10.
>
> Nguy=E1=BB=85n, sorry for being dense. =C2=A0I think this ended up be=
ing very close to
> your initial patch.

I have cheaper "git fetch" any way. That's all that counts from my
user point of view :)

What about push/receive-pack? I think the same thing happens there.
--=20
Duy
