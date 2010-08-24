From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/3] fetch-pack: use args.shallow to detect shallow
 clone instead of args.depth
Date: Wed, 25 Aug 2010 08:14:20 +1000
Message-ID: <AANLkTinWWweV43NP34iFXKVcyyu7uiovsDQxNKmdD0wL@mail.gmail.com>
References: <1282565304-3122-1-git-send-email-pclouds@gmail.com>
	<1282565304-3122-2-git-send-email-pclouds@gmail.com>
	<7vlj7wx99v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 00:14:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1lF-0003iT-SJ
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224Ab0HXWOX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:14:23 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:40559 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166Ab0HXWOW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Aug 2010 18:14:22 -0400
Received: by wwb31 with SMTP id 31so202688wwb.1
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q9M7KS/robrU5PRz/uYi6z3cDJpmmjD9zDXxl78QHss=;
        b=Ygnr6FFtVfl/QrKw+i6x/1YPOjyg7+JkqQGj2CgyjpTZlRo/I8Mf1fLvmMdHEevOFN
         GOD7L/W0k9xBOOrfYUkJkahjzSVflVTYCxBpf58J1bZ7/SJPP4gtCDkEcf0fU2VUO9w1
         9wuzBDROHfAOL4pHUlKtpRemddBDnlOw1pF68=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IrRa8o7ZQBSV4DtK36peYc0fZmHFyX6AGdwf8omCpghS3YeQlc5FQQDXpBN1wE80si
         oN4UaeVTaa19oK4QTRVOPUuwHatGWEcXpCaHgmFmljSoZ57Oh+8/ZrYhCBA8n7WLGZM8
         8hIev4ygI914gXsvsv1Wk7ChOJOoPDKu01q5s=
Received: by 10.227.133.81 with SMTP id e17mr6362033wbt.186.1282688060462;
 Tue, 24 Aug 2010 15:14:20 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Tue, 24 Aug 2010 15:14:20 -0700 (PDT)
In-Reply-To: <7vlj7wx99v.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154342>

On Wed, Aug 25, 2010 at 2:31 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> Isn't there any rationale for this change? =C2=A0"args.depth > 0 does=
 not
> necessarily mean we are in a shallow clone situation, because ..." or
> "using args.depth > 0 to check if we are in a shallow clone breaks un=
der
> such and such conditions and here is a test case to reproduce the bug=
"?

=2E. because args.depth=3D0 is now also a shallow clone situation, i.e.=
 a
valid depth too.
--=20
Duy
