From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [PATCH] Add --no-autostash flag to git pull --rebase
Date: Fri, 26 Feb 2016 22:39:55 +0530
Message-ID: <CA+DCAeTAAn-xA=3kHBcURzv_1eJRKd7uMZRwaPNbCZbGS2eFLw@mail.gmail.com>
References: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com>
	<1456485825-21309-2-git-send-email-mehul.jain2029@gmail.com>
	<CACRoPnTKRwGmhQOrJsA2ys66RwRVcY1nu+hs_5_YMqgiSUbNiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 18:10:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLu0-0002rS-Ge
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 18:10:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbcBZRJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 12:09:58 -0500
Received: from mail-qg0-f42.google.com ([209.85.192.42]:33350 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003AbcBZRJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 12:09:56 -0500
Received: by mail-qg0-f42.google.com with SMTP id d32so14082070qgd.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 09:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=z2Vs7G97qhy0exq6b8hMsgGCEnX8o/empupZ5QSMarY=;
        b=x0imWAfPtG660gf2m2MwnZJ23IyK/imZNZ4kWV+2Jv9jhD9la89Xx9b7SdA1Fnj3dv
         DCykLDpG4L2xfR72yUsAOaKchKcthLKXHoz9E5piJlJVpGuB0IR1YA+e1TqaI8imesvr
         sNTJbMOM4ZkGNQ3IpOGZJnWE9amxTdQ74Mty3EvPdJElCzOWvRFrvPc1Zh6mDB26+DWV
         KG6sp//HY/i9Ayl7uMRoTPfCcYnPGW3sgvb6otFRqp2QzSnB5ymlkvEBe3YvWQR+9lOk
         sqGhWgCR6h7BTp08A+TyExwUa2QvLt3TBu4ey1U3uCdUnZGRYSr/52F/cDc6aC/JNeKr
         F9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=z2Vs7G97qhy0exq6b8hMsgGCEnX8o/empupZ5QSMarY=;
        b=L9qiXOfoBpIG72HeE/b7zLhQtQ5IRTFhbZYKqi+eOdEVVtV5eUrmn3XK+LdXf/oTfn
         PKKTL0iImhrz4ElwZdrLouw663VZ9ZK61d2/AMwBX3P3mlv2vJs/+5iDf3CP7+DiAUTG
         sTNuWUy4886bcKFPOk/zEKit3z27dPMAY1JpEj5iDG2/QHXc//VshDVGDkgFK7v+ZXfU
         z5M7QzHZGw83MzfePLO1jo/nCy7Mhq7hweKWBtV1uZB2z72bf6Oa6UsrJ+4MN5gQdw2a
         s4vLlVjCKNM8LZVmY202G+P9GF4OMXITAyZJUIq/9vR57f+Fqoza0i/HtnHp8Bcvdq5g
         dsKg==
X-Gm-Message-State: AD7BkJLjmjARdWoVds3UoJCCroOH4GsCNUOusEWg9zyiD9VcbyyTKlY21Bono4EiGfk+ZzMFoB2S7OieWvFn3w==
X-Received: by 10.140.224.19 with SMTP id u19mr3555278qhb.93.1456506595467;
 Fri, 26 Feb 2016 09:09:55 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Fri, 26 Feb 2016 09:09:55 -0800 (PST)
In-Reply-To: <CACRoPnTKRwGmhQOrJsA2ys66RwRVcY1nu+hs_5_YMqgiSUbNiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287593>

Hi,

Thank you for the suggestions.
On Fri, Feb 26, 2016 at 6:17 PM, Paul Tan <pyokagan@gmail.com> wrote:
> Some grammatical/spelling nits below:

Many apologies for my English.

> I think git-pull's documentation should be updated as well to talk
> about this new command-line switch.

OK.

>> diff --git a/builtin/pull.c b/builtin/pull.c
>> index 10eff03..9d1a3d0 100644
>> --- a/builtin/pull.c
>> +++ b/builtin/pull.c
>> @@ -85,6 +85,7 @@ static char *opt_squash;
>>  static char *opt_commit;
>>  static char *opt_edit;
>>  static char *opt_ff;
>> +static int opt_autostash = -1;
>>  static char *opt_verify_signatures;
>>  static struct argv_array opt_strategies = ARGV_ARRAY_INIT;
>>  static struct argv_array opt_strategy_opts = ARGV_ARRAY_INIT;
>> @@ -146,6 +147,8 @@ static struct option pull_options[] = {
>>         OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
>>                 N_("abort if fast-forward is not possible"),
>>                 PARSE_OPT_NOARG | PARSE_OPT_NONEG),
>> +       OPT_COLOR_FLAG(0,"autostash",&opt_autostash,
>> +               N_("abort if tree is dirty")),
>
> Why OPT_COLOR_FLAG()? And --autostash is not just about aborting if
> the working tree is dirty. Why not just copy the help message from
> git-rebase? Something like:
> "automatically stash/stash pop before and after rebase"

Using OPT_COLOR_FLAG() is wrong, I agree. OPT_BOOL will be a better option.
N_("automatically stash/stash pop before and after rebase") is better.

>>         OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
>>                 N_("verify that the named commit has a valid GPG signature"),
>>                 PARSE_OPT_NOARG),
>> @@ -835,13 +838,14 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>                 hashclr(orig_head);
>>
>>         if (opt_rebase) {
>> -               int autostash = 0;
>> -
>>                 if (is_null_sha1(orig_head) && !is_cache_unborn())
>>                         die(_("Updating an unborn branch with changes added to the index."));
>>
>> -               git_config_get_bool("rebase.autostash", &autostash);
>> -               if (!autostash)
>> +               if(opt_autostash < 0)
>> +                       if(git_config_get_bool("rebase.autostash",&opt_autostash))
>> +                               opt_autostash = 0;
>
> I wonder if this code could be shortened if we simply just called
> git_config_get_bool() just before parse_options(). That way, we don't
> need to check for the "-1" special value.

Definitely. This way opt_autostash can be initialized with 0, thus default
will be false.

>>
>> +               if (!opt_autostash)
>>                         die_on_unclean_work_tree(prefix);
>
> OK.
>
>>
>>                 if (get_rebase_fork_point(rebase_fork_point, repo, *refspecs))
>> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
>> index c952d5e..512d3bf 100755
>> --- a/t/t5520-pull.sh
>> +++ b/t/t5520-pull.sh
>> @@ -245,6 +245,14 @@ test_expect_success '--rebase fails with multiple branches' '
>>         test modified = "$(git show HEAD:file)"
>>  '
>>
>> +test_expect_success '--rebase --no-autostash fails with dirty working directory' '
>
> Maybe add ..."and rebase.autostash set" to the test name? Describes
> the test better, and is consistent with the name of the test below.

Can be done. But which one of these will be more appropriate:
 "rebase.autostash set" or "rebase.autostash set true".
I prefer latter, as it will maintain consistence with the test name of
"--rebase --autostash", which will be
'--rebase --autostash succeeds with dirty working directory and
rebase.autostash set false.'


>> +test_expect_success 'git pull -q --rebase --no-autostash' '
>> +       mkdir clonedqrbnas &&
>> +       (cd clonedqrbnas  && git init &&
>> +       git pull -q --rebase --no-autostash "../parent" >out 2>err &&
>> +       test_must_be_empty err &&
>> +       test_must_be_empty out)
>> +'
>> +
>> +test_expect_success 'git pull -v --rebase --no-autostash' '
>> +       mkdir clonedvrbnas &&
>> +       (cd clonedvrbnas && git init &&
>> +       git pull -v --rebase --no-autostash "../parent" >out 2>err &&
>> +       test -s err &&
>> +       test_must_be_empty out)
>> +'
>
> While more tests are always good, I don't think we need to test for
> "-q" and "-v" with --no-autostash, because it's already covered by the
> test for "git pull -q --rebase". Perhaps with --autostash, but even
> then I don't think we need a test for "-v".

OK then. I will only add tests for "git pull --rebase --no-autostash",
"git pull --rebase --autostash" and
"git pull -q --rebase --autostash" in t5521-pull-options.sh

Thanks,
Mehul Jain
