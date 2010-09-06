From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 00/17] Narrow clone v3 (was subtree clone)
Date: Mon, 6 Sep 2010 15:29:54 -0500
Message-ID: <AANLkTin3VykgwJyMaVNmDnjAU3_pkA0+cKn-GO0OSnBN@mail.gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com> <AANLkTinNnm=Z=e_=P_auuNgSrDynt_P+FLiZgWeNNgps@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsiKb-0000xk-B5
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab0IFUaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 16:30:16 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62532 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0IFUaP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 16:30:15 -0400
Received: by ywh1 with SMTP id 1so1715812ywh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=4wA0c0yOrkPvzesIsO4Y0DHo6+l7h0uYpzJWJasex6g=;
        b=bptq/Fgdz99FDLt7QmSAxC4qY88xzZtNtseAza57Z88Fn6BJarBN7MVyl8z2vAvUsi
         rR9NO7PitiXH0CBS4jnNLYh0a/B/EdsEk6sMAZrxkepmko3LTD6m/GMJM2D5tCMPPp+3
         eqs+yDzg8x12JnJ3vsE1l/9O0dZQxksBwQM0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=m37pL8odKWHcmMjwEXzADjYSTU6UsNaRJtdh8xAZUb4rWRk4/BSz41FWhd7amE96Ev
         lOc1boPVUwPCY3UWKYUd/XTDCbbxM4SUw8KHTMuTVtG4O2WXDLLxn6xi8uw55RlZBT6c
         Hvquq+J8+9wRkvmFx6d/51WDpOr9r0Umc1+CU=
Received: by 10.151.77.8 with SMTP id e8mr145370ybl.224.1283805014138; Mon, 06
 Sep 2010 13:30:14 -0700 (PDT)
Received: by 10.150.204.21 with HTTP; Mon, 6 Sep 2010 13:29:54 -0700 (PDT)
In-Reply-To: <AANLkTinNnm=Z=e_=P_auuNgSrDynt_P+FLiZgWeNNgps@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155612>

Heya,

2010/9/6 Elijah Newren <newren@gmail.com>:
> So, I downloaded your patches and even made sure to sort them
> appropriately to fix the order, but I'm getting conflicts trying to
> apply them (on top of current pu). =C2=A0What version did you base th=
em on?

It's considered best practice to base your patches on master if
possible. You should only base them on next if you rely on a
particular series that has already landed there. You should never base
your patches on pu itself, on a topic in pu perhaps, but never on pu.

--=20
Cheers,

Sverre Rabbelier
