From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v8 2/2] commit: add a commit.verbose config variable
Date: Sun, 20 Mar 2016 16:35:31 +0530
Message-ID: <CAFZEwPMZk9jDpi4F9WiYhv4aTqFqn3127i1AUKtNJXwG-11tyw@mail.gmail.com>
References: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
	<010201538b98aaa4-ad08c159-4935-48f1-acdb-7c376da2c368-000000@eu-west-1.amazonses.com>
	<CAPig+cShT2aPkoRK0pXPzbRbQqCU+O5uEqEr4oMkZ8LTwREaAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 12:05:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahbB8-0005lu-Sm
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 12:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373AbcCTLFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 07:05:34 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36307 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbcCTLFc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 07:05:32 -0400
Received: by mail-yw0-f195.google.com with SMTP id p65so14424122ywb.3
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 04:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=r6HoSGjENjFPuva7g6EqtWSL+lbEyeF3vxUVeVifUjc=;
        b=cWTwJ1cbh14hMoYUDZ8a7WlDXVJlctCjT635I4wzJiY5vNJuRovPLhKADQ9ephmJGI
         SNLQrMRmz/p+8fXdJfY4g72Nuu6/bff87qR+/nlR6uEdZydlhN5G7unzDkK05r2aTYo6
         BptS15zjrKP1sIn4VJ1RQ1RHRtbQsxuVygUAZrF/L9s8qz2cLKopt3g9EwCM9u4V2Hov
         wYA/ATfx9A2n1wJ98CXM2RvXGtDx6xXoPVrUo24RVFjKcVjvYY9aYVZHhGTcdK6mE3MH
         gqOB7imTifLkyQUBE8MkDh/jHlEmJmFaTI1+C3AoH8cysc0i/c+2ESkJiFbxE1HIElYc
         AIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=r6HoSGjENjFPuva7g6EqtWSL+lbEyeF3vxUVeVifUjc=;
        b=RelHUGa1GnVfmA01l2W029GQzBljews0PnW1IQfRctUkah5wrubGlLjhfLe3s9S3LM
         n3lj0GVrBlCeAPdT/ljMzdzLT/iqGZbTTrw8hsH1+ehmzFKxB0vVnT8J1nkxlrvwd5Fj
         mbUYPInNRazlW9pbKFYERC7MS9aB396NYl94h/UAiYWvI9SwX2cGoa+8e6XM1VE5+gN+
         somji6xeuqNT2KFgU9u65g2V2uMhaE0QwECB3HK0AhIUNptRHLfg2aEGvZ+gwKGXOeyE
         TLeKoJTlguoOpC8t0eO0SxmQMjnoRfiJte9dViMNjYCYKSNvH83WwEPT2Q/eqTOUG7Ql
         zUkQ==
X-Gm-Message-State: AD7BkJLJGkuv5uXASSjfZij3vX1MtZ12dPppC+CPsrf2JQl9W6JjMAKmZXipaHeqpsK2K7Z/rQIEO4AYAclUKQ==
X-Received: by 10.37.22.134 with SMTP id 128mr11826018ybw.7.1458471931661;
 Sun, 20 Mar 2016 04:05:31 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 20 Mar 2016 04:05:31 -0700 (PDT)
In-Reply-To: <CAPig+cShT2aPkoRK0pXPzbRbQqCU+O5uEqEr4oMkZ8LTwREaAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289345>

On Sun, Mar 20, 2016 at 9:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Mar 18, 2016 at 5:19 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Add commit.verbose configuration variable as a convenience for those
>> who always prefer --verbose.
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>> ---
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> @@ -1654,6 +1661,14 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>> +       if (verbose < 0) {
>> +               if (config_verbose > -1)
>> +                       verbose = config_verbose;
>> +               else
>> +                       verbose = 0;
>> +       }
>
> I think it's more common in this codebase to compare against -1
> directly rather than <0, so:
>
>     if (verbose == -1) {
>         if (config_verbose != -1)
>             verbose = config_verbose;
>         else
>             verbose = 0;
>     }
>
> Or, this might be easier to read:
>
>     if (verbose == -1)
>         verbose = config_verbose;
>
>     if (verbose == -1)
>         verbose = 0;
>
> But, this likely isn't better:
>
>     if (verbose == -1)
>         verbose = config_verbose == -1 ? 0 : config_verbose;
>
> Anyhow, probably not worth a re-roll.

I will note this for future patches.

>
>> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
>> @@ -96,4 +96,59 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
>> +test_expect_success 'commit.verbose true and --verbose' '
>> +       (
>> +               GIT_EDITOR=cat &&
>> +               export GIT_EDITOR &&
>> +               git -c commit.verbose=true commit --amend --verbose
>
> Easier would be to write this as:
>
>     GIT_EDITOR=cat git -c commit.verbose=true commit --amend --verbose
>
> and then you wouldn't need the subhsell.

True. I will update this.

> However, more intuitive would probably be to create another "editor"
> similar to the 'check-for-diff' editor this script already uses. (The
> 'check-for-diff' editor is an obvious example about how to go about
> such an undertaking.) You would need to invoke 'test_set_editor' in a
> subshell for this particular test in order to avoid clobbering the
> global editor used by this script. Or, have a preparatory patch which
> ditches the global setting of the editor and has each test invoke
> 'test_set_editor' as needed (and only if needed).

I guess it would complicate things as sometimes I need to check
whether it has 1 line and sometimes 2 lines.

> Same comments apply to the other new tests which use a custom "editor".
>
>> +       ) &&
>> +       grep "^diff --git" .git/COMMIT_EDITMSG >out &&
>> +       wc -l out | grep "1"
>> +'
>> +
>> +test_expect_success 'commit.verbose true and -v -v' '
>> +       (
>> +               GIT_EDITOR=cat &&
>> +               export GIT_EDITOR &&
>> +               git -c commit.verbose=true commit --amend -v -v
>> +       ) &&
>> +       grep "# Changes not staged for commit" .git/COMMIT_EDITMSG >out &&
>> +       wc -l out | grep "2"
>> +'
>> +
>> +test_expect_success 'commit.verbose true and --no-verbose' '
>> +       test_must_fail git -c commit.verbose=true commit --amend --no-verbose
>> +'
>> +
>> +test_expect_success 'commit.verbose false and --verbose' '
>> +       git -c commit.verbose=false commit --amend --verbose
>> +'
>> +
>> +test_expect_success 'commit.verbose false and -v -v' '
>> +       (
>> +               GIT_EDITOR=cat &&
>> +               export GIT_EDITOR &&
>> +               git -c commit.verbose=false commit --amend -v -v
>> +       ) &&
>> +       grep "# Changes not staged for commit" .git/COMMIT_EDITMSG >out &&
>> +       wc -l out | grep "2"
>> +'
>> +
>> +test_expect_success 'commit.verbose false and --verbose omitted' '
>> +       test_must_fail git -c commit.verbose=false commit --amend
>> +'
>> +
>> +test_expect_success 'commit.verbose false and --no-verbose' '
>> +       test_must_fail git -c commit.verbose=false commit --amend --no-verbose
>> +'
>> +
>> +test_expect_success 'status ignores commit.verbose=true' '
>> +       git -c commit.verbose=true status >actual &&
>> +       ! grep "^diff --git" actual
>> +'
>> +
>>  test_done
