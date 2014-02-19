From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] tag: support --sort=version
Date: Wed, 19 Feb 2014 13:43:55 -0500
Message-ID: <CAPig+cSXt4LKFfj6VqH=xfmbMvmT2o2ozDaH-+_435GeuKLa=g@mail.gmail.com>
References: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 19:52:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGCFe-0006MR-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 19:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbaBSSv4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 13:51:56 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:63306 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653AbaBSSvz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 13:51:55 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so1276592qcy.25
        for <git@vger.kernel.org>; Wed, 19 Feb 2014 10:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Iz5q3Fpdw1DQYPCXox/6Q71/b9YA8bQLZAvJ4HhIXXw=;
        b=l5e5q2GjVwKVMdaUJOx+ZGaZBq/jtaAxosZudwGJWY8EkbnViSH1gJQdnKNrwYg0gH
         hmLuK7sJIuOwxbBU0cvG/mRAgL+3PcM1s9UTAi5bJg0exHRdBRv1drD9Gc1VuQn8gnN5
         vrW02ktwUeUKJCbtnH5fmKluuZ1WXrUEgDBZZhJk99Wdt2fTZvIps+tH2YkSqOMJlN8h
         bu4w7NIIzLlLrC5p/C69RKkKnaajISGVqZzo19qdgQVXLu8f9xEZfSWqxIwWIDHZG2yC
         FNGiyBxPAUbxUMu6j+/R7jqpmhbRbG1R3pfjUxj/4X7aZjmtn+kvtIMUobqI3/vpc4MT
         K7Sw==
X-Received: by 10.236.87.6 with SMTP id x6mr3146217yhe.149.1392835435605; Wed,
 19 Feb 2014 10:43:55 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Wed, 19 Feb 2014 10:43:55 -0800 (PST)
In-Reply-To: <1392817167-29802-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: tFvtERGVwkUvJp2mxVlNsBtdqcE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242396>

On Wed, Feb 19, 2014 at 8:39 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> --sort=3Dversion sorts tags as versions. GNU extension's strverscmp i=
s
> used and no real compat implementation is provided so this is Linux o=
nly.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 404257d..fc23dc0 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -95,6 +95,10 @@ OPTIONS
>         using fnmatch(3)).  Multiple patterns may be given; if any of
>         them matches, the tag is shown.
>
> +--sort=3D<type>::
> +       Sort in a specific order. Supported type is "version". Prepen=
d
> +       "-" to revert sort order.

s/revert/reverse/

> +
>  --column[=3D<options>]::
>  --no-column::
>         Display tag listing in columns. See configuration variable
