From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: "./t0001-init.sh --valgrind" is broken
Date: Thu, 3 Mar 2016 19:09:12 +0700
Message-ID: <CACsJy8CVfJdCmwWo50wHsc6DP6ft71d5bfBaFSJpv9XcNRwdSQ@mail.gmail.com>
References: <CAP8UFD0-FxoPe5-35NAKSkegFBoRPy1+BOsqN-y+QJUoXAqR3g@mail.gmail.com>
 <CACsJy8AL_RGEb2z44-yoL+3yF7n1+FMLqZkmWwUDFJnEPYS_nw@mail.gmail.com> <56D7DFD5.8010108@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 13:09:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abS4j-0005uq-7T
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 13:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbcCCMJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 07:09:45 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34322 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbcCCMJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 07:09:44 -0500
Received: by mail-lb0-f182.google.com with SMTP id cf7so4524561lbb.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 04:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+PX4ZphJxeTKJl6Bd8dReGY2tDmhh+OfKQRJd3roiQc=;
        b=BQUaP9RUAFVJfXEOuPZdiJJ6AYkq339Mwns+OEEq+pInXAecN9+vc1rId81Mn7sSni
         fKOO7gfguoRqs4Q3N0zxAnfZ3I7b+I8xSQ2t3qeJNH0IsPdQS3T0qyn3L3nJ00l98GMP
         oiahBDMtNsM6jxVQrbx5AX27lr2vzB05LqiqsZjn2H69y12Q2Cl2nlCNKf5eXYcwyfSQ
         NiZtnTZ/5NVFmxG3XrPLvar+byaw+hEzjYMjPBqFticS6I5ijGE2K8JydEOuMtwBqDqp
         pPVCU/frKfYp4peci4R0t4vUX2DiRDwFzLxkCmpz73Jdp+AwSjZmCRCP1dGHJFp2pvyc
         a25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+PX4ZphJxeTKJl6Bd8dReGY2tDmhh+OfKQRJd3roiQc=;
        b=X91+njWNzs17oQFpkb1XS0xgf1yUciP27TYH6Q5tk/KJcWMJRge8fSr5xdKdOMKHV+
         T/8bztotGs3kUAPCQHRGzvmCvpukdxPOm4oG0ToZbTWHph0o2wIP3eoi+TYH0EEvWUIQ
         RnCknnSvLOHsZ4fuyV8tHlLpnbu+o+LmgUJhXU6/ZPR44ChF3mjCXPabInYqryZPo7Lb
         JTtuax2oT3dAtNdVRQkBpTcsWXr38RIHCeklTCvNedXw8Y4pMv400fJQ+M/fhMmVljOt
         rH7F+k4WOZPHdQNlYwXyiIORrY4fSTO8jO/+wgqmZkP1vYpvAf/Mx8WPT6NmVHmzWZDN
         wXVg==
X-Gm-Message-State: AD7BkJJtDbf/diB+X2oGNIbwsFpPv3mPmbTPYCFl7ttgSjIghJrgShZ2YqWCI52xlLL4lKNSG5Z9k+qIGBIDxA==
X-Received: by 10.112.130.41 with SMTP id ob9mr852418lbb.81.1457006982274;
 Thu, 03 Mar 2016 04:09:42 -0800 (PST)
Received: by 10.112.34.162 with HTTP; Thu, 3 Mar 2016 04:09:12 -0800 (PST)
In-Reply-To: <56D7DFD5.8010108@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288171>

+the-other-Johannes who added valgrind support.

On Thu, Mar 3, 2016 at 1:55 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> ---- 8< ----
> Subject: [PATCH] t0001: fix GIT_* environment variable check under --valgrind
>
> When a test case is run without --valgrind, the wrap-for-bin.sh
> helper script inserts the environment variable GIT_TEXTDOMAINDIR, but
> when run with --valgrind, the variable is missing. A recently
> introduced test case expects the presence of the variable, though, and
> fails under --valgrind.

Yep.

It's interesting though that valgrind sets up some variables without
going through bin-wrappers. That's understandable because valgrind
support is added (in 4e1be63) 10 months before bin-wrappers (in
ea92519).  But it's probably better that we inject valgrind command
from inside bin-wrappers script, the same way we inject gdb, I think.

> Rewrite the test case to strip conditially defined environment variables
> from both expected and actual output.

Or we could set GIT_TEXTDOMAINDIR in the "if test -n $valgrind" code
in test-lib.sh, which makes the two more consistent. Also simpler
patch.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t0001-init.sh | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 295aa59..a5b9e7a 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -88,19 +88,17 @@ test_expect_success 'plain nested in bare through aliased command' '
>  '
>
>  test_expect_success 'No extra GIT_* on alias scripts' '
> -       (
> -               env | sed -ne "/^GIT_/s/=.*//p" &&
> -               echo GIT_PREFIX &&        # setup.c
> -               echo GIT_TEXTDOMAINDIR    # wrapper-for-bin.sh
> -       ) | sort | uniq >expected &&
> -       cat <<-\EOF >script &&
> -       #!/bin/sh
> -       env | sed -ne "/^GIT_/s/=.*//p" | sort >actual
> -       exit 0
> +       write_script script <<-\EOF &&
> +       env |
> +               sed -n \
> +                       -e "/^GIT_PREFIX=/d" \
> +                       -e "/^GIT_TEXTDOMAINDIR=/d" \
> +                       -e "/^GIT_/s/=.*//p" |
> +               sort
>         EOF
> -       chmod 755 script &&
> +       ./script >expected &&
>         git config alias.script \!./script &&
> -       ( mkdir sub && cd sub && git script ) &&
> +       ( mkdir sub && cd sub && git script >../actual ) &&
>         test_cmp expected actual
>  '
>
> --
> 2.7.0.118.g90056ae
>



-- 
Duy
