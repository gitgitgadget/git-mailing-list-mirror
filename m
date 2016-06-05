From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 18/26] t5500, t5539: tests for shallow depth since a
 specific date
Date: Sun, 5 Jun 2016 00:43:31 -0400
Message-ID: <CAPig+cS8CrnF8N8SfPRtnug8r6O70M1qhnjaZTQtbgGNxwN4Ag@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com> <1460552110-5554-19-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 06:43:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9Puc-0004J5-Ll
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 06:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbcFEEnd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Jun 2016 00:43:33 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:36746 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcFEEnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2016 00:43:33 -0400
Received: by mail-io0-f178.google.com with SMTP id k19so101041285ioi.3
        for <git@vger.kernel.org>; Sat, 04 Jun 2016 21:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=75A5Hsz6Sd6pY5T4Ns2PmQyQVneMp9vTnHS71sZRsyM=;
        b=vkn9XA5E/gFn39saqZB8lGTZXvbi/qNdZa00Wulx7K7d5uiU5o/JypZBj5lejeZ5r5
         VeTeMF/X6+OECw5MaCDpqlLOY6vCnX2mRHRpPKjTLGADKms5bioIBhJZmAB9rJwc7qFW
         +6/3n63c4sHo9yWxYhysLw475t69Zisq586h4SgSM/lIdOSrOPuHj6dn7HQI/muCaWPk
         tgTiysDcRQTxLN5FHShvJs/S5YkoAUtVdZeMHaqJpt4tvmtYNsoK83gALZuCNK6falGe
         G60+VF9DJpetSmvO3PGatUXkuZJzKG9xJATt52DbVw+EFyc1yQFMAYZmPLHXbwRz3802
         vmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=75A5Hsz6Sd6pY5T4Ns2PmQyQVneMp9vTnHS71sZRsyM=;
        b=Zcs5Hgs5a8rpFA6OeD1AXm3d5tlc7n5QB/sjPgM19ul8HoZsn4nHHbs5hpz0ll3Ly4
         ++GfHCvo1W+srB+Y/FM8rHEIoq2vby7EsX/gfV5DhCNl5yrmXjlxp516mlu9DXvLDDc/
         TE9xwFqGSZPwQxHYmEXzHG/IgwvlYU2Vdlj0Lr1+9YOObgqE7dIThZDAyQK3TLJtA6Gw
         d1rbHC/WH33fh9Ui+dKlH6dxYa4okmKXjVimu1qHKUr6vr4GNiFS6wQK7xG3t70UsGQo
         MBq2XY2UuZ7souVE+pTcIU9UThh3Ds14/f2O28VVFXPwJS8NODnGGunuBcF2sfNX+qUB
         fSYg==
X-Gm-Message-State: ALyK8tL3lvbqQGE4LfXgGdv+kMlX6GGyTYhU0gjix7PFo/r3uKJnhkFsqs+cXWTRu59gymCs4CyAMaSMSZUypw==
X-Received: by 10.107.47.41 with SMTP id j41mr11220389ioo.168.1465101812228;
 Sat, 04 Jun 2016 21:43:32 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Sat, 4 Jun 2016 21:43:31 -0700 (PDT)
In-Reply-To: <1460552110-5554-19-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: 6INX6ESvxW4AFyZKH9NC4wo48HQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296460>

On Wed, Apr 13, 2016 at 8:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/t/t5539-fetch-http-shallow.sh b/t/t5539-fetch-http-shall=
ow.sh
> @@ -73,5 +73,31 @@ test_expect_success 'no shallow lines after receiv=
ing ACK ready' '
>         )
>  '
>
> +test_expect_success 'clone shallow since ...' '
> +       test_create_repo shallow-since &&
> +       (
> +       cd shallow-since &&
> +       GIT_COMMITTER_DATE=3D"100000000 +0700" git commit --allow-emp=
ty -m one &&
> +       GIT_COMMITTER_DATE=3D"200000000 +0700" git commit --allow-emp=
ty -m two &&
> +       GIT_COMMITTER_DATE=3D"300000000 +0700" git commit --allow-emp=
ty -m three &&
> +       mv .git "$HTTPD_DOCUMENT_ROOT_PATH/shallow-since.git" &&
> +       git clone --shallow-since "300000000 +0700" $HTTPD_URL/smart/=
shallow-since.git ../shallow11 &&
> +       git -C ../shallow11 log --pretty=3Dtformat:%s HEAD >actual &&
> +       echo three >expected &&
> +       test_cmp expected actual
> +       )
> +'
> +
> +test_expect_success 'fetch shallow since ...' '
> +       git -C shallow11 fetch --shallow-since "200000000 +0700" orig=
in &&
> +       git -C shallow11 log --pretty=3Dtformat:%s origin/master >act=
ual &&
> +       cat >expected <<-\EOF &&
> +       three
> +       two
> +       EOF
> +       test_cmp expected actual
> +'
> +
> +

Style: extra blank line (not worth a re-roll, of course)

>  stop_httpd
>  test_done
> --
> 2.8.0.rc0.210.gd302cd2
