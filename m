From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t4151 missing quotes
Date: Mon, 9 May 2016 16:16:03 -0400
Message-ID: <CAPig+cS4Bj4N8d1a29z8=f30owOec1pB=yF32ZUPmDH2Tu2kXA@mail.gmail.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
	<CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
	<CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
	<xmqq37pruklb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 22:16:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azrbE-0001JB-1e
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 22:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbcEIUQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 16:16:06 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35838 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbcEIUQE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 16:16:04 -0400
Received: by mail-ig0-f193.google.com with SMTP id jn6so12242266igb.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 13:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=QwFB0P/0t1P0YTehWfMGFr1nIyEXR399jDC6HTEJNog=;
        b=cCf5+/Q7nVuDAKFbeoTQJ23pgFheU03gRqkCOEf6uVJdpvMxBHjXetZNGDk6yLETgq
         JRFeenkik4l9M7+7q/kg5NzfG6dXYgZdwAb7F9Kf1s1+oD5ZMOhPagqkO8gYTdKEt2mi
         7Nea4GOb4heFAlINCf+sVsq5y+sDsIIc3OiLQENpC209PMmNWw+UoFCWSnF+tDgdDGav
         r8FeqCLAAnK3+YvYx8VpaW3LkKiRlrw2hGQI3q6Voq7/+lfhXAzrQ8jbTwUyVKrqeDYm
         qli4mjBpwvkzvjhXeAQfVGnZx8jP1BmeL2lWOKMVTTGo71XzgPDpNrxzMBk7T8xqRVmX
         dtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=QwFB0P/0t1P0YTehWfMGFr1nIyEXR399jDC6HTEJNog=;
        b=WQq+PS6HKRE97tprWqDIMoR41MPwO2mmUjMhiuDbMT/zONICBNhL5wXTFCAnLyOhTQ
         VvK5lEVpHSTz9/UBH0xTqsv3iDeIwV3a2dJjqrObO6LnQp3iNXkCqblS1iE5KVS3z/1w
         vWQ0gLM+o7Abocqmp07BGV8K5muvd2NCQgqJ7Hy8i9su6+zg6/KF9PM4KETHoRBk/6Lv
         1R+b3NAzOhawgc7rBqcTwdku+BzyBiWCEQMwmPev7o8torS0nvZOvs7fPuKAqpfX0Emx
         aiFzCExOImRaiPgZ7bsPczopQ8g7t7ZoN8KxcwzkwdYMLnO3csXGzQmojBWasxZPWNkN
         huWw==
X-Gm-Message-State: AOPr4FWdXeKIokThOAuLgnZ21R4A+mJf3Us07HbM2cloCldYyzCflq2oXe/RmCzYZk2JvQADEnve6CtS5HE73w==
X-Received: by 10.50.205.42 with SMTP id ld10mr13238716igc.17.1462824963591;
 Mon, 09 May 2016 13:16:03 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 9 May 2016 13:16:03 -0700 (PDT)
In-Reply-To: <xmqq37pruklb.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: BfwVU_JaRVY6Qn5s_pujq9YMH84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294047>

On Mon, May 9, 2016 at 2:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Something like this follows Documentation/SubmittingPatches [...]
>
> -- >8 --
> From: Armin Kunaschik <megabreit@googlemail.com>
> Subject: t4151: make sure argument to 'test -z' is given
>
> 88d50724 (am --skip: revert changes introduced by failed 3way merge,
> 2015-06-06), unlike all the other patches in the series, forgot to
> quote the output from "$(git ls-files -u)" when using it as the
> argument to "test -z", leading to a syntax error.

To make it clear that this was not a syntax error in the typical case,
it might make sense to say:

    ...potentially leading to a syntax error if some earlier tests failed.

> Note that $(git ls-files -u | wc -l) are deliberately left unquoted,
> as some implementations of "wc -l" includes extra blank characters
> in its output and cannot be compared as string, i.e. "test 0 = $(...)".

Aside from the above nit, this all looks good and (for what it's worth) is:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

> Signed-off-by:
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t4151-am-abort.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
> index 833e7b2..b878c21 100755
> --- a/t/t4151-am-abort.sh
> +++ b/t/t4151-am-abort.sh
> @@ -82,7 +82,7 @@ test_expect_success 'am -3 --abort removes otherfile-4' '
>         test 4 = "$(cat otherfile-4)" &&
>         git am --abort &&
>         test_cmp_rev initial HEAD &&
> -       test -z $(git ls-files -u) &&
> +       test -z "$(git ls-files -u)" &&
>         test_path_is_missing otherfile-4
>  '
