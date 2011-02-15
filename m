From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH 2/2] Teach commit to handle CHERRY_HEAD automatically
Date: Tue, 15 Feb 2011 17:16:28 -0500
Message-ID: <AANLkTim63v+jh1KROgVwwEyBDjVdge7MOq+DUnpw0c-e@mail.gmail.com>
References: <1297805034-3512-1-git-send-email-jaysoffian@gmail.com> <1297805034-3512-3-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 15 23:17:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpTCj-0008Vu-JL
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 23:17:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756229Ab1BOWRA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 17:17:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42300 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206Ab1BOWQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 17:16:59 -0500
Received: by iyj8 with SMTP id 8so556344iyj.19
        for <git@vger.kernel.org>; Tue, 15 Feb 2011 14:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=rgCs120KHsQRZe4H0l9jHEFPRBJza8JJEvXVPJ7ct3c=;
        b=VkzXC9HPFA1EIYg8/HI5xaFf0Y4ppjqzUInnTxUcyM1EsP3F0mfOMSJ6+2DFZe98QB
         biN3jZp0omRaRjQINZhTrlSJCFMj9dHWupRSlGv6ByAjCsO+Nlk3EvEQQ8VpZPm4617r
         I2dKCUvquF9/lbkSAqsWhXyvb7YC1axTrpNCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=u6AFU8Go57Ov8HlRkzxRr15Mxyj4Xp7h27MoxTlJDSayM7KGUoutcCiKkI1/FdgFXk
         JVwg3uf6yrZ9bKPOW7URLMWvFJ1cuDggXutSU8qzRjooPrvBINEZNTef74nSJaM36bXO
         SQPfygICJcJ2rU+GLdDsSGueWZypKdhlsOIvw=
Received: by 10.42.218.66 with SMTP id hp2mr7481200icb.244.1297808218867; Tue,
 15 Feb 2011 14:16:58 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Tue, 15 Feb 2011 14:16:28 -0800 (PST)
In-Reply-To: <1297805034-3512-3-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166887>

On Tue, Feb 15, 2011 at 4:23 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -284,11 +284,10 @@ static void print_advice(void)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0advise("after resolving the conflicts, mar=
k the corrected paths");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0advise("with 'git add <paths>' or 'git rm =
<paths>'");
> + =C2=A0 =C2=A0 =C2=A0 advice("and commit the result with 'git commit=
'");

Obvious typo, I amended it but apparently ran format-patch before the
amend. Assuming the series is otherwise okay it'll be fixed in the
re-roll with tests and SoB.

j.
