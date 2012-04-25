From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/10] i18n: remote: mark strings for translation
Date: Wed, 25 Apr 2012 15:54:34 -0700
Message-ID: <xmqqaa1zbexh.fsf@junio.mtv.corp.google.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
	<1335184230-8870-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 00:54:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNB6e-00074q-M0
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 00:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388Ab2DYWyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 18:54:36 -0400
Received: from mail-yx0-f202.google.com ([209.85.213.202]:35029 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932352Ab2DYWyf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 18:54:35 -0400
Received: by yenq2 with SMTP id q2so85378yen.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 15:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=s9Esca1BMZhwWLIUE0IN88Od70htAkqhFu5mNzWG2Ck=;
        b=YaZTAVANS6gEsT69bD3cAFsfXOnoNh7Ise6xza+I8YuY4KCFF3cykbHPqcl+MBVzz5
         WE/V9mm22ABr9zk0o+N8whROGo+0J5wNppVSSfxRl4z6aZMl48A2wcnBzOcq/RFWMSBE
         8oKpSmh2A32WtZv0OvG0pgWoww4J2SoueVtrbM1/otiyvrmlNXXHDuSiTBPIoMHehhpm
         ymJ/HTckRUYa9Opb8lFL3vltneW2L/C7BRAoOspz1U7ZJ9VgjLYTsv4usWG4QnM1o6NP
         HW027xhj81B9YANla5GaHtW+ubb2M8jxxakol0huo8XC24LHRlh7xLK2IZGRYTk2Gm+k
         YueQ==
Received: by 10.100.245.28 with SMTP id s28mr1743419anh.6.1335394475265;
        Wed, 25 Apr 2012 15:54:35 -0700 (PDT)
Received: by 10.100.245.28 with SMTP id s28mr1743394anh.6.1335394475064;
        Wed, 25 Apr 2012 15:54:35 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id d47si1075934yhl.6.2012.04.25.15.54.35
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 25 Apr 2012 15:54:35 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id EEA101004A4;
	Wed, 25 Apr 2012 15:54:34 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 9DA78E125C; Wed, 25 Apr 2012 15:54:34 -0700 (PDT)
In-Reply-To: <1335184230-8870-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 23
 Apr 2012 19:30:26 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQn8fUt9A5HCeY4Wb8wNYnhB/+SnqXl3Gita6WnuYrtf0OjmdTdzWwKl/t3aK2btEteJv41cc/BxZwH3iLujlcZRXrG6L0K7+Xp6a87r6LdXJoJkmuzepVML2zGRyv6x8uoKUlePoAAuDzcNbcH1N3yp2KtgCVgpXWRyPwqL5F7M540lLRk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196345>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -761,7 +761,7 @@ static int remove_branches(struct string_list *br=
anches)
>  		unsigned char *sha1 =3D item->util;
> =20
>  		if (delete_ref(refname, sha1, 0))
> -			result |=3D error("Could not remove branch %s", refname);
> +			result |=3D error(_("Could not remove branch %s"), refname);
>  	}

This is an issue in the original, but almost all messages in this
utility use sq around names of 'stuff' that can be specified by the end
user when it appears as part of a sentence, but not here.
