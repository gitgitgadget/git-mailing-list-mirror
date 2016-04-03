From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v12 1/5] t0040-test-parse-options.sh: fix style issues
Date: Sun, 3 Apr 2016 17:00:22 -0400
Message-ID: <CAPig+cQ+89MZSyHJhCrZsGMc7mM_uorE5j9GXk7kCTT1OTXV6Q@mail.gmail.com>
References: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	<01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 23:11:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ampJ0-0005q8-4r
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 23:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbcDCVAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 17:00:24 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34387 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbcDCVAX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 17:00:23 -0400
Received: by mail-ig0-f194.google.com with SMTP id qu10so3085701igc.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=zNHftyyj1p+U9n5K8g5wb6Zyt0Y7g6uQHbBCQGVD7ck=;
        b=n2zhxYI82DAk28P03RRKSczG3p8tZWUvajPYvpmNs862n8P2xF+nFqD7/O5R8H+9Yn
         WOgKI1VLvFmIRJWLnRzxjVoGVOkqZesixe2hd9KEBREwcvJpv327Ssc+EkfA+X6NDQHe
         Qw5dNNInvCE6HOFhuHwsUx3kuNpWA5ZAo5q4OG8JZ7XgH8WsE7/3NSss6XpqYZIZo/pe
         OQlxQg1G3cf/Dd9iIRWsMDxoq8FUvrFN4Nj4lAYGesZiHzk5Fxrwn9mXFcJID942kZ/f
         EwjdHRJChMl42UCU8r9f36SoxnaRYv44oERnQlIeylQxGJfJHS5sA8Ohq3fzHW94esI7
         K77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zNHftyyj1p+U9n5K8g5wb6Zyt0Y7g6uQHbBCQGVD7ck=;
        b=dFgCBhMKUI4gRQbLuaLwjIwp/9gUWE6tFAP5J5jghsCo4g6y0F/TkOR4VXmz3xem1U
         CdQP3RaltEmeuDnDxV35ZY4MyWUtXy3UTk8MbLZ6pAO9PPQ6JQ+OEwZQJ2nfc6NjY3rH
         OJHkymjrtiONwopFTUJDBl2fdFhk9BjaM3j7AMCx4/VotNxvvOrrUeyYnFaEx2FeigIx
         ov8nqKSvKqApER98gfELQU2f4yWntytBZbyoMx2qUDFmJx6F4qV8R1gAx6a8PQW9uR/a
         0LLnHL3nNjBRbeZ+p49P1LkX79zCRXAnWxNOaDE4j4YmbSiV03dcxB8hUyzGdN6WnSoM
         XuhQ==
X-Gm-Message-State: AD7BkJISFEvETCWCabQo1TnDoGIVQ0IWlugMzjQ6u5amplCjslFWECOBZgW1T3RUGlUdAuBotsfz6sp46PvEjQ==
X-Received: by 10.50.143.102 with SMTP id sd6mr3130903igb.73.1459717222576;
 Sun, 03 Apr 2016 14:00:22 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Sun, 3 Apr 2016 14:00:22 -0700 (PDT)
In-Reply-To: <01020153d952bd99-d3812bd6-d189-4780-ab48-f015696e9cf0-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: gLlQg81w5w4EUcsmerE8dQLfMSg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290654>

On Sat, Apr 2, 2016 at 7:33 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
> @@ -7,7 +7,7 @@ test_description='our own option parser'
>
>  . ./test-lib.sh
>
> -cat > expect << EOF
> +cat >expect <<EOF
>  usage: test-parse-options <options>
>      --yes                 get a boolean

It would be better to use <<\EOF for this one to make it clear that no
interpolation is desired in the heredoc.

> @@ -156,7 +156,7 @@ test_expect_success 'OPT_MAGNITUDE() 3giga' '
>         check magnitude: 3221225472 -m 3g
>  '
>
> -cat > expect << EOF
> +cat >expect <<EOF

Ditto: <<\EOF

Same applies to all similar heredocs in subsequent tests where
interpolation is not desired.

>  boolean: 2
>  integer: 1729
>  magnitude: 16384
> @@ -310,12 +310,12 @@ arg 00: --quux
>  EOF
>
>  test_expect_success 'keep some options as arguments' '
> -       test-parse-options --quux > output 2> output.err &&
> +       test-parse-options --quux >output 2>output.err &&
>         test_must_be_empty output.err &&
> -        test_cmp expect output
> +       test_cmp expect output

Okay, this is a whitespace change (spaces -> tab).

>  '
> @@ -460,7 +460,7 @@ test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
> -cat >>expect <<'EOF'
> +cat >>expect <<EOF

This is not a desirable change. This heredoc does not require
interpolation, so you don't want to turn it into a form which does
interpolate. For style consistency, therefore, you should change 'EOF'
to \EOF.

>  list: foo
>  list: bar
>  list: baz
