From: Zhang Lei <zhanglei002@gmail.com>
Subject: Re: [PATCH v5] worktree: add: introduce --checkout option
Date: Wed, 30 Mar 2016 11:11:07 +0800
Message-ID: <CABEEbiArWe+Tq2CYMw+54PkeOAnHqU+tw6iLDW2wRuGHJ964EQ@mail.gmail.com>
References: <01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
	<01020153c1dae323-b918e73f-f116-4760-9747-9aa8cafb2db5-000000@eu-west-1.amazonses.com>
	<CAPig+cRimDGFDk7A2p2rKpJ2GR27_R=BJdpyPK4xeyDU1TruWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 05:11:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al6XM-0001Xi-7m
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 05:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbcC3DLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 23:11:09 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36417 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbcC3DLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 23:11:08 -0400
Received: by mail-ig0-f196.google.com with SMTP id sy18so323114igc.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 20:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=m5Gz4MuRo90tm7cY5f4lN6Nftds9RwgTOAUcoIwGG04=;
        b=Ca199x5wygXjo+44vgwU58YxMTtvZCCxfUFnWVlMjwjWTBGtgC+erM9Dj6aB/mizXl
         ArkMdcWcj+xDIxqYTUyV6Tz18T/4FZFml4Mp9qxq0OzUzU/jLhLgF8+LftYypTJsPA+D
         d8WWy5yqyn5A16LCKqZfCOdE8PN4O1VHNW1CnIN12eouVdTzJVEb9Dw4ElD+sUzhhLxk
         ieaQ27Az1zm5eSrevZjmAHpKBRbBL0MyiEixwYvL0gK7ELKzXx0RMGgfV++RLu6oAa4n
         NaqIgwye/QIliMqs0zPDCTYOLnyLYai1APKnxi2qGi+Yp3Jxmb2ml3tr46XdFtFW/Rj7
         FOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=m5Gz4MuRo90tm7cY5f4lN6Nftds9RwgTOAUcoIwGG04=;
        b=dgbN82RFMoPWvUXL/BuNWOyRxSANKqWE1UnH57TWLCkdIAB7nNrgV+ZzV9buPgY03T
         RD92cs8fRAM0cxuazlVVJ5m+7gNYXum1bGwIW8sD/DL566F8+cUijAuW/EYk/O3WyuJd
         MTZqNhG98Z8ZRfIfchJoxAZ7lx6X64ZAzdF1jQ+Uwbk+7VG3qdQiiVpXj2bCiGSAps34
         6DK/hwUVpQLHLBROWx4Qmbl7eSs9g8LuX08AHxl3LAY1Wk/iblhSiRjL8fcbD6zePUJ9
         m/khs7poQrFNjn3XySFyP88FBoc1h0eQnX69n31OhyG+A/wHwxOvYmaqceodRk+dWje2
         rosQ==
X-Gm-Message-State: AD7BkJI70rnHF3m4ZogiWTSmJ44tqXZeRb8nCkv/EiFb+7vfAr8OzZ1tv9hfPEHNjoS6JBh5ZO4OI8RutPqs6g==
X-Received: by 10.50.92.41 with SMTP id cj9mr7003236igb.38.1459307467256; Tue,
 29 Mar 2016 20:11:07 -0700 (PDT)
Received: by 10.107.1.72 with HTTP; Tue, 29 Mar 2016 20:11:07 -0700 (PDT)
In-Reply-To: <CAPig+cRimDGFDk7A2p2rKpJ2GR27_R=BJdpyPK4xeyDU1TruWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290264>

Thanks for the review.
Sorry for the patch churn, I wasn't quite familiar with working with
mailing list.

2016-03-30 3:20 GMT+08:00 Eric Sunshine <sunshine@sunshineco.com>:
> On Tue, Mar 29, 2016 at 6:11 AM, Ray Zhang <zhanglei002@gmail.com> wrote:
>> By adding this option which defaults to true, we can use the
>> corresponding --no-checkout to make some customizations before
>> the checkout, like sparse checkout, etc.
>>
>> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
>> ---
>> Changes since last version of this patch[v4]:
>>         t/t2025-worktree-add.sh: use test -e to test file existence.
>>         builtin/worktree.c: refactor the code a little bit.
>
> Thanks, this version is still:
>
>     Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>
> A couple comments below...
>
>> ---
>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -284,18 +285,22 @@ static int add_worktree(const char *path, const char *refname,
>>         if (ret)
>>                 goto done;
>>
>> -       cp.argv = NULL;
>> -       argv_array_clear(&cp.args);
>> -       argv_array_pushl(&cp.args, "reset", "--hard", NULL);
>> -       cp.env = child_env.argv;
>> -       ret = run_command(&cp);
>> -       if (!ret) {
>> -               is_junk = 0;
>> -               free(junk_work_tree);
>> -               free(junk_git_dir);
>> -               junk_work_tree = NULL;
>> -               junk_git_dir = NULL;
>> +       if (opts->checkout) {
>> +               cp.argv = NULL;
>> +               argv_array_clear(&cp.args);
>> +               argv_array_pushl(&cp.args, "reset", "--hard", NULL);
>> +               cp.env = child_env.argv;
>> +               ret = run_command(&cp);
>> +               if (ret)
>> +                       goto done;
>>         }
>> +
>> +       is_junk = 0;
>> +       free(junk_work_tree);
>> +       free(junk_git_dir);
>> +       junk_work_tree = NULL;
>> +       junk_git_dir = NULL;
>
> Doing the goto-dance and outdenting the "freeing" code as suggested as
> a possible improvement by [1] probably should have been done as a
> separate preparatory patch since the result in this patch is fairly
> noisy and more difficult to review. However, it's probably not worth
> the patch churn to do so now.
>
>>  done:
>>         strbuf_reset(&sb);
>>         strbuf_addf(&sb, "%s/locked", sb_repo.buf);
>> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
>> +test_expect_success '"add" worktree with --no-checkout' '
>> +       git worktree add --no-checkout -b swamp swamp &&
>> +       ! test -e swamp/init.t &&
>
> I realize that this was suggested by [2], however, a more modern way
> to state this would be:
>
>     test_path_is_missing swamp/init.t &&
>
> but, as also mentioned in [2], it's probably not worth the patch churn
> to change it now.
>
>> +       git -C swamp reset --hard &&
>> +       test_cmp init.t swamp/init.t
>> +'
>> +
>> +test_expect_success '"add" worktree with --checkout' '
>> +       git worktree add --checkout -b swmap2 swamp2 &&
>> +       test_cmp init.t swamp2/init.t
>> +'
>> +
>>  test_done
>
> [1]: http://git.661346.n2.nabble.com/PATCH-add-option-n-no-checkout-to-git-worktree-add-tp7651385p7651884.html
>
> [2]: http://article.gmane.org/gmane.comp.version-control.git/290050
