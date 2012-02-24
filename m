From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] index-pack: remove real_type from struct object_entry
Date: Fri, 24 Feb 2012 13:08:46 +0700
Message-ID: <CACsJy8DT7QyLHbUQft2zbOm9Nv94b9trakk+nEfu4zT_xdf1AA@mail.gmail.com>
References: <1330051320-19043-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 07:09:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0oLM-0000Lh-96
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 07:09:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab2BXGJS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Feb 2012 01:09:18 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:43152 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600Ab2BXGJR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Feb 2012 01:09:17 -0500
Received: by werb13 with SMTP id b13so1213764wer.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 22:09:16 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.180.92.227 as permitted sender) client-ip=10.180.92.227;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.180.92.227 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.180.92.227])
        by 10.180.92.227 with SMTP id cp3mr1813366wib.13.1330063756314 (num_hops = 1);
        Thu, 23 Feb 2012 22:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=aRBr6u/iTiSt3oMrTQ3jza2PqRwEe4JsFrPWc4ulEjk=;
        b=sAcJ/9DsOO+DG8hn0mlBEYLAgndnvqL30qzAnVdjAT0xwB8k1ywr4i3gkniZsyKchq
         74ZQT7jN4Vxf97E3gl29qIzqxyY3rNSFpVAZVLSnUPJmQNH8JMqEGfGbWLzN46rMq1Gb
         PP2M3zf4k3btZEHnGsImBQy6OkcfZVGNkU6JM=
Received: by 10.180.92.227 with SMTP id cp3mr1476027wib.13.1330063756242; Thu,
 23 Feb 2012 22:09:16 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Thu, 23 Feb 2012 22:08:46 -0800 (PST)
In-Reply-To: <1330051320-19043-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191414>

2012/2/24 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> @@ -581,7 +580,6 @@ static void resolve_delta(struct object_entry *de=
lta_obj,
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void *base_data, *delta_data;
>
> - =C2=A0 =C2=A0 =C2=A0 delta_obj->real_type =3D base->obj->real_type;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0delta_obj->delta_depth =3D base->obj->delt=
a_depth + 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (deepest_delta < delta_obj->delta_depth=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0deepest_delta =
=3D delta_obj->delta_depth;

This is wrong. Sorry for the noise.
--=20
Duy
