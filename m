From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] Move test-*.c to test/ subdirectory
Date: Wed, 9 Feb 2011 22:23:09 +0700
Message-ID: <AANLkTimxT3kcQBaBWagQ8Eg5CS5rf1fgaQVX1TVDQHdn@mail.gmail.com>
References: <1297264469-13675-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 09 16:23:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnBtZ-0004uT-Ap
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 16:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419Ab1BIPXs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Feb 2011 10:23:48 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35644 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab1BIPXr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Feb 2011 10:23:47 -0500
Received: by ewy5 with SMTP id 5so150954ewy.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 07:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=LMBLKwchbEaOZoIY0wo85Xy/9sNgRuDMpDOV/S2KCXY=;
        b=cV6HLMT3bNhy19ggRyApa5xq2X4WhMLSd13zcJhOD89t6crn/BYhxW6ewNebKt4d3T
         zlF7o+6ygCStGFqZ6970i5IE/iSF2q/G6Kn9ZgILc0Z48/7AZHydF5SixRC87V0pbMK0
         hiYba2fpNugE9SAFoMLjHpxQ9vMxwRjY7BGwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=sfKgU5yWHqq7TEyEG6q+VfYoCEfPtg452bMR1g6v6FCy87TGaSWSysnPY1jJe/f3xy
         JhHdBbmNZWOEQWIQM+EhXSV2+xP3nocaYqBx1t7l9yE024p716/Ebi3OM9zzyvAP+49E
         Htmu97vnNne+V5TTDdk+S5HwtPa3CnUJXyMbU=
Received: by 10.216.186.144 with SMTP id w16mr17317681wem.13.1297265026469;
 Wed, 09 Feb 2011 07:23:46 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Wed, 9 Feb 2011 07:23:09 -0800 (PST)
In-Reply-To: <1297264469-13675-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166425>

2011/2/9 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0This makes topdir 19 files less and does not seem to break test=
s.

except this because test-sha1.sh wasn't moved.

> -check-sha1:: test-sha1$X
> - =C2=A0 =C2=A0 =C2=A0 ./test-sha1.sh
> +check-sha1:: test/sha1$X
> + =C2=A0 =C2=A0 =C2=A0 ./test/sha1.sh
--=20
Duy
