From: Stefan Beller <sbeller@google.com>
Subject: Re: t4151 missing quotes
Date: Mon, 9 May 2016 12:19:24 -0700
Message-ID: <CAGZ79ka6SXUqQNZJJGMsYYnjbX1qRqmYToxrDE0Zc8YOmss1OA@mail.gmail.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
	<CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
	<CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
	<xmqq37pruklb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 21:22:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azqiR-0002mI-TB
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 21:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbcEITT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 15:19:27 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35486 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbcEITT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 15:19:26 -0400
Received: by mail-io0-f179.google.com with SMTP id d62so182557147iof.2
        for <git@vger.kernel.org>; Mon, 09 May 2016 12:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=4ZPDuDTOT4Hj9oLjVyUIqUCT5gdgKpxCunpJ5F/4lKg=;
        b=QyLtlNxGGlaJbOgJC/19zW/KrnlSwUeUKz+3gVoZjHbrFrUZjt+Fc1znJDJB6bMvGt
         nKmkaecV6Cz3FLDjkv9qDWnZoJkcdJYrhj6kYRB1pqMITjXz+yWyo7llJjdraS8JIh+5
         uIpkKtNKb0GPYg+8AdCIb5+J4TF1SvpZJbf6p6yPbwUVaNacVWOcUzEBLZmIj8bffiNx
         nQQnVhlXxGAwwWCvFtjQY7P75MDm3XjEdGq6p3OuVrVsaUndRK+JVqtKIsa/0DDoApq8
         KE4BtZ4+x1qFgyhIi+dAiQLAkVPhmTugmxX42gjO1oH5W2QrJZP1PB8YuhVhG99G+I7i
         cDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4ZPDuDTOT4Hj9oLjVyUIqUCT5gdgKpxCunpJ5F/4lKg=;
        b=JIdPYzpCFDDuQRp28dKIC81FyaWJ+Ivtig5XVVKn4fw+gFo1lkpZoHZUT5loKCY52L
         RCibKBdXfPiKyvuEAaPgl9JDG38Cau3ZELRZvu/YZhfQ8SoPG5SNYh2nxz5fijzK9qvq
         YFRLnXcf11CoyM/xorFAFabOhtKNZFBy1d0LiLPaV86tb7/yrNvHUcTFfYigR3qwD1/6
         kl99d5tR9KGg9dPjhEh5A4X28uo5xE3YiGb3NZG0F8umpCZPmxFN+QY0rkHG2SflZTCH
         pmib59lFhYkMwhTTd61VR3e6P7qHGpcB2mMTCt88XLzjn1ibD6v83sljFIZBSh2eyMPm
         9JfA==
X-Gm-Message-State: AOPr4FWRWnK4eqctrH3UFjMp5ej8pfCiv1M6nPoPVro9r9I325q6sayljoKhdjEJdXs+ZlH8acisw1R52wMtR4xS
X-Received: by 10.107.53.204 with SMTP id k73mr38449203ioo.174.1462821565003;
 Mon, 09 May 2016 12:19:25 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 9 May 2016 12:19:24 -0700 (PDT)
In-Reply-To: <xmqq37pruklb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294041>

On Mon, May 9, 2016 at 11:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Something like this follows Documentation/SubmittingPatches, except
> that it further needs your Sign-off before mine, which I can forge
> if you say it is OK.

The sign-off is a simple line at the end of the explanation for
the patch, which certifies that you wrote it or otherwise have
the right to pass it on as a open-source patch.  The rules are
pretty simple: if you can certify the below:

        Developer's Certificate of Origin 1.1

        By making a contribution to this project, I certify that:

        (a) The contribution was created in whole or in part by me and I
            have the right to submit it under the open source license
            indicated in the file; or

        (b) The contribution is based upon previous work that, to the best
            of my knowledge, is covered under an appropriate open source
            license and I have the right under that license to submit that
            work with modifications, whether created in whole or in part
            by me, under the same open source license (unless I am
            permitted to submit under a different license), as indicated
            in the file; or

        (c) The contribution was provided directly to me by some other
            person who certified (a), (b) or (c) and I have not modified
            it.

        (d) I understand and agree that this project and the contribution
            are public and that a record of the contribution (including all
            personal information I submit with it, including my sign-off) is
            maintained indefinitely and may be redistributed consistent with
            this project or the open source license(s) involved.


>
> Thanks for a report and an analysis of the issue.
>
> -- >8 --
> From: Armin Kunaschik <megabreit@googlemail.com>
> Subject: t4151: make sure argument to 'test -z' is given
>
> 88d50724 (am --skip: revert changes introduced by failed 3way merge,
> 2015-06-06), unlike all the other patches in the series, forgot to
> quote the output from "$(git ls-files -u)" when using it as the
> argument to "test -z", leading to a syntax error.
>
> Note that $(git ls-files -u | wc -l) are deliberately left unquoted,
> as some implementations of "wc -l" includes extra blank characters
> in its output and cannot be compared as string, i.e. "test 0 = $(...)".
>
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
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
