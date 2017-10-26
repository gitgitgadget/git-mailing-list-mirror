Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F145B202A0
	for <e@80x24.org>; Thu, 26 Oct 2017 17:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932333AbdJZRbY (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 13:31:24 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:56029 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbdJZRbX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 13:31:23 -0400
Received: by mail-qt0-f193.google.com with SMTP id v41so5252356qtv.12
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 10:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TZXYaPrNfnmo+tb7Zh3Zv9bTFqlaaA4ZuusnDlA6AMw=;
        b=Ll466tbhEFua2giyYNzNdERA8VXQoDM3sxl2N1k0LCKhg7fHBTSwZ6S8f5tV4hfWhA
         GzSiKKLVcy6GxFhiv8x2SGs9bzsBtEdHWrpDbm21GJv4deZz4FW5dXVsmWXM65sUBYIB
         3PkasQyET8lW+LBj/N2h/fwcMWAVfY90n6dNFPpONhpqZo2H1pJpP/UWPWpnY/Wep9AA
         7d1Fh+fSoTrPRp0J7pYolwyLBZ4wxvu8F3JDeMaPWcAE5qsjHxCxXIlufFLoPDxtXS8x
         DtnEa8dZmdUbOI9k147zNThfPFOgVzdXB+YLRZflISuCYPkDgdeLSrnrx2ZEQ5AmiOfS
         w4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TZXYaPrNfnmo+tb7Zh3Zv9bTFqlaaA4ZuusnDlA6AMw=;
        b=gNcrtI0TUaxcKnpz8s9bDtoZEvLXP0CEgmxE3mkhvGUAWJauhTrPHiPzQAYyFaPYRZ
         gHe3rtvhV8aCM/97pAVGT+I7sD/5mfloLf21UrM2VNKVvOToWtivKhY1yNul0v3Umkdk
         RS50w89G6XxaOKY+APL/+HS+bQk2VDXrhRwcr1LOMUFTo0mgRt0wJP6by+iNwcjEyIzV
         t5OM3aPEBgk5dgujbJ1cb5PzWc2sZ0TQjHnYdbpWiSpLg4qV9RiwMGMFeXlHtHUjDcGh
         GNcpOfFjxqyjrzJyfy9pLCeGSpZ3KKfPY2TigSuUOrWIjFIOO5Tlu1z/aKBKPtkOnJAL
         IHKA==
X-Gm-Message-State: AMCzsaXrm8wMgIJsRV1Pl90N5M4CNZbcdnjDAwldWaGr24tAaJZWL0bL
        QWWhUG0zdoG8IjXEjGXvvNWfj4tzqkwOiodQ9C6W7w==
X-Google-Smtp-Source: ABhQp+QI8r/8NxmG9REjq260vuPa/sTNAD9UHV0/hTD3rs4KP4SaliHdYBv2gf+E6AyI74ogMxlnzV499e5oNKKK9Oo=
X-Received: by 10.237.37.71 with SMTP id w7mr11898562qtc.299.1509039082955;
 Thu, 26 Oct 2017 10:31:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 26 Oct 2017 10:31:22 -0700 (PDT)
In-Reply-To: <0102015f5887d349-1fd2949b-700b-4f16-81a5-4e6aad6bd695-000000@eu-west-1.amazonses.com>
References: <0102015f5887d349-1fd2949b-700b-4f16-81a5-4e6aad6bd695-000000@eu-west-1.amazonses.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Oct 2017 10:31:22 -0700
Message-ID: <CAGZ79kZMFLOUivMaGiXCg_AYkDZCdCrPcpf6iWDZ+9KHn0C6pA@mail.gmail.com>
Subject: Re: [PATCH] docs: fix formatting of rev-parse's --show-superproject-working-tree
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 4:53 AM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  Documentation/git-rev-parse.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 0917b8207b9d6..95326b85ff68e 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -264,7 +264,7 @@ print a message to stderr and exit with nonzero status.
>  --show-toplevel::
>         Show the absolute path of the top-level directory.
>
> ---show-superproject-working-tree
> +--show-superproject-working-tree::

Thanks for this fix!
Stefan
