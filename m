From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] commit: add a commit.verbose config variable
Date: Mon, 14 Mar 2016 04:24:22 -0400
Message-ID: <CAPig+cQ+8+saxsGzV=-C2w-eSaaOf0MYC=zTQbH3CW2G5UE5uw@mail.gmail.com>
References: <01020153698edabd-73daa5db-3c3e-417b-8d83-6cbc04439d95-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 09:24:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afNnm-0001ic-5S
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 09:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbcCNIYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 04:24:25 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36288 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbcCNIYX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 04:24:23 -0400
Received: by mail-vk0-f67.google.com with SMTP id j65so13957515vkg.3
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 01:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=4a35UsUQncBZRql7RmrYzjwUmWCy8a/3GnVQxdK0UlY=;
        b=bZbIMCv+GdZUKO5kpZrmBh+QVTrcsxSk82FmPzn0c1bDPKgk68L/Oe8o3rFto5zmyz
         hU0Xi7hkTDY1iyuGU59MZMShIsQnOL0BjDiLwGG8AmS+O1wPREHO1T64UyTeIWFGG0cl
         6RzBptnzjHfYOPKe1MkT0tXsjGfzp2TbbGxT6UXTpgjcv37LISHRRVP6C/9EC2aCApnp
         EZO5whXeMuLwuyoHPIHiD7K6mfdLRZO5riUR49PojPu9z6IN3zsJ1jcio6cH51ImA4tv
         WqHFIZOT5OlU9bHy7Km8xrEOSf//817O3GTjMDduTA7UnY5bPgd9Xx3nxwoNg8uObOhN
         AFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4a35UsUQncBZRql7RmrYzjwUmWCy8a/3GnVQxdK0UlY=;
        b=OCqqrd8URt0vgDsJHbM0kBEeyk4DQKi/ZLc2E8wf95napBwUUdd5xcr3XqUIWc6R1B
         x452NdXuGAdgbf40fkNaqGPktfPG42TpqeYzctuvCAnndxGAL4XYBS9hm8AD8lMm90iR
         +DZCFRjsF/uYUFh2AB+yVPc8WIf5LbJETRYNerW83H1AbEy7Jsux0P0h6GIlArNEjKSP
         5Du44gcbfKYmzJST0vlPj0zGk//rTyfq+bPEFLeRXDYM5g3ZZfXFCuiBaDu605ZKDJ25
         AlS+hCWKmDCFhXN3MKrz6eRnFjB4EsAfZaAithT4fAWJ/NJhgEJCL6TIxUfaCwsS46xg
         KDRg==
X-Gm-Message-State: AD7BkJIrkQeuLIlX3osTOrPPLztu2kviZsinUMVUU99x2Fm2gbiixydIqoAOjqn/V8UB3Y9huVjMznqi/8crTg==
X-Received: by 10.31.21.4 with SMTP id 4mr23403483vkv.151.1457943862479; Mon,
 14 Mar 2016 01:24:22 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 14 Mar 2016 01:24:22 -0700 (PDT)
In-Reply-To: <01020153698edabd-73daa5db-3c3e-417b-8d83-6cbc04439d95-000000@eu-west-1.amazonses.com>
X-Google-Sender-Auth: ekIYBrCrAWNi72V3WrEWPxqGwNI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288774>

On Sat, Mar 12, 2016 at 1:41 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Add commit.verbose configuration variable as a convenience for those
> who always prefer --verbose.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> Mentored-by: Eric Sunshine <sunshine@sunshineco.com>

More typical would be to say Helped-by: rather than Mentored-by:.

Also, place your sign-off last.

> ---
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2ddf28c..bb7ce7c 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -96,4 +96,22 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
> +test_expect_success 'commit.verbose true and --verbose omitted' '
> +       test_config commit.verbose true &&
> +       ! git status | grep "*diff --git" &&

This is a bogus regular expression; some greps may barf on it
outright, while others will treat "*" as a literal. Either way, it
could never match "diff --git" so the test would succeed by accident
even if git-status did erroneously respect "commit.verbose".

> +       git commit --amend
> +'

I realize that it's possible to (mis)read Junio's recommendation[1]
about also testing git-status as a hint to combine the git-commit and
git-status checks into a single test, but that's not what was
intended. These are conceptually distinct checks, thus they should
each have a separate test. I'd suggest restoring the
"commit.verbose=true and --verbose omitted" test as it was shown in
[2], and then adding a new test in this script for git-status which
looks something like this:

    test_expect_success 'status ignores commit.verbose=true' '
        git status >actual &&
        ! grep "^diff --git" actual
    '

[1]: http://article.gmane.org/gmane.comp.version-control.git/288648
[2]: http://article.gmane.org/gmane.comp.version-control.git/288674

> +test_expect_success 'commit.verbose true and --no-verbose' '
> +       test_must_fail git -c commit.verbose=true commit --amend --no-verbose
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose' '
> +       git -c commit.verbose=false commit --amend --verbose
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose omitted' '
> +       test_must_fail git -c commit.verbose=false commit --amend
> +'

Not at all mandatory, but it wouldn't hurt to add a couple additional tests:

* commit.verbose=true and --verbose
* commit.verbose=false and --no-verbose

>  test_done
