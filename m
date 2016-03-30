From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Thu, 31 Mar 2016 00:30:14 +0530
Message-ID: <CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:00:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alLLq-00016J-L5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 21:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbcC3TAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 15:00:17 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35789 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbcC3TAP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 15:00:15 -0400
Received: by mail-qg0-f66.google.com with SMTP id b32so4651795qgf.2
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 12:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=jcfPhLUWJVo9N6qoBI92ANqpsu2OOXoA2VCumgU9qIg=;
        b=xR8knKOhwhaJj1HM3mPeWP9einrZMDzMFZUWjS9sk9bmLlDzios8WEDzdNNAKX9rc5
         wnkbdrcEeQ/1aL6hCPfTD2RLiIUTaxLZTh2TcyN6m3iEnhqAfyLLMAdCcHrx6hxtKgT3
         dFv03iVaBcO5gMqk0GzqXNA6xbiNr1VU/apGN0aD3tiYHIfQmiCKbrwbcuVjkdaAfjZM
         07DicrHgBNsMjHRCyprVpY4bxpKj6k/EVLiYW09JHlT/UMqwa876V1ODTdKUA0QAaLGm
         gIlLuRQZqIwRt3wyQfTgqSzQ3CPWWGLCp9O+DN83Dv1cVB7cXRKI4WI6APnKddiL4HKo
         2kPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=jcfPhLUWJVo9N6qoBI92ANqpsu2OOXoA2VCumgU9qIg=;
        b=hXhMdFyiQIdqkzFfar/5soSzwwFVL6STUAnV1zyzK+ZPjoBlHlbhVBzCcybGRnS1nN
         9fh4yhIYGNTsoJFBjvetU6BHbEZNYjB7SVV3XdptZYvFwNNItrtwmt39WaKxDbsr1jaG
         3jxhEoGhTsLcFP9hU2mJ7FYjyf3vH5/eOYXZhRgf94L3N/lPs4OXbOvWPmw2aXSl3+mn
         KwsImqZ9d8b+JXUcJJW1MRzEGi3F7xmmh42qCsHHN9CVGpwIhWdlDBziISPGyAUzuT8b
         mr1mMPXZJJAMK+DxTfkrIXdjy2b4o5mxPrdbca/C0IEWl+re9jHlPITvf01gkBRwCp3F
         sf2g==
X-Gm-Message-State: AD7BkJIpkebHsSsMWWXTtSOQA4MPHEXqQh75JgPW4eE4mxT3KwF6kSHF8iKl9m16QzOEEDN9VqfRI3qO/Azccw==
X-Received: by 10.140.166.6 with SMTP id m6mr12912493qhm.70.1459364414355;
 Wed, 30 Mar 2016 12:00:14 -0700 (PDT)
Received: by 10.55.188.7 with HTTP; Wed, 30 Mar 2016 12:00:14 -0700 (PDT)
In-Reply-To: <CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290336>

Hi Eric,

Thanks for the reviews on this series.

On Wed, Mar 30, 2016 at 2:46 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> With the exception of the missing --rebase argument, this is exactly
> the same code as in test_rebase_autostash(), right? Rather than
> repeating this code yet again, it might be nice to augment that
> function to accept a (possibly) optional argument controlling whether
> --rebase is used.

Thanks for the idea. I have come up with something like this:

        * Introduce two function test_pull() and test_pull_fail() in
the place of
          test_rebase_autostash() and test_rebase_no_autostash.()

          Using these functions we can easily re-write all the 6 tests which
          deals with combination of autostash and rebase.autostash. Plus
          these functions helped in writing two new tests which deals with
          combination of pull.rebase and autostash. Thus reducing the code
          base to simpler and fewer lines of code. Also I could re-write one
          of the old test to reduce the repetition with them.

Here are the functions and there implementations:

---

test_pull () {
        git reset --hard before-rebase &&
        echo dirty >new_file &&
        git add new_file &&
        git pull $@ . copy &&
        test_cmp_rev HEAD^ copy &&
        test "$(cat new_file)" = dirty &&
        test "$(cat file)" = "modified again"
}

test_pull_fail () {
        git reset --hard before-rebase &&
        echo dirty >new_file &&
        git add new_file &&
        test_must_fail git pull $@ . copy 2>err &&
        test_i18ngrep "uncommitted changes." err
}

test_expect_success 'pull --rebase succeeds with dirty working
directory and rebase.autostash set' '
        test_config rebase.autostash true &&
        test_pull --rebase
'

test_expect_success "pull --rebase --autostash & rebase.autostash=true" '
        test_config rebase.autostash true &&
        test_pull --rebase --autostash
'

test_expect_success "pull --rebase --autostash & rebase.autostash=false" '
        test_config rebase.autostash false &&
        test_pull --rebase --autostash
'

test_expect_success 'pull --rebase: --autostash & rebase.autostash unset' '
        test_unconfig rebase.autostash &&
        test_pull --rebase --autostash
'

test_expect_success "pull --rebase --no-autostash & rebase.autostash=true" '
        test_config rebase.autostash true &&
        test_pull_fail --rebase --no-autostash
'

test_expect_success "pull --rebase --no-autostash & rebase.autostash=false" '
        test_config rebase.autostash false &&
        test_pull_fail --rebase --no-autostash
'

test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
        test_unconfig rebase.autostash &&
        test_pull_fail --rebase --no-autostash
'

test_expect_success 'pull --autostash & pull.rebase=true' '
        test_config pull.rebase true &&
        test_pull --autostash
'

test_expect_success 'pull --no-autostash & pull.rebase=true' '
        test_config pull.rebase true &&
        test_pull_fail --no-autostash
'
---

I'm sorry if this is bit difficult to digest without diff output. I
just wanted to
know if the above mention functions looks suitable to you.

Also I've read your comments on other patches of this series, I will make
changes accordingly ones above mention functions, tests looks fit for a
re-roll.

Thanks,
Mehul
