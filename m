Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56E120357
	for <e@80x24.org>; Thu, 13 Jul 2017 07:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750949AbdGMHMg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 03:12:36 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:32882 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdGMHMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 03:12:34 -0400
Received: by mail-qk0-f174.google.com with SMTP id a66so29595398qkb.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Y6DWf11Qz2bYLzKgTXfzvhPpzy9rFHi4fQOiXP1iEe0=;
        b=B0Z/N1edr+PetFEtbvX48ycvNM9UvYpCYffQ7xlTh48Ym5lN+3gzwaU6X7fFh1SvpG
         cx45iIb4FOImqEZWIqGNsdZsZc531w49wr68E1foOoJurBLr+zWKqXTS2jNvg9RXc8lt
         GHQPMo5GOjBE49kqcAW02vUfRT4D6WFzozOktQx8Z1V40X8WAJADnylivQEj0BkEJDrK
         1bm/zrWFxZG79Am98nfEYsriZqrsSUIqrx/FZiics2/ypujW0UUdh4NCjZu1eeDsWatN
         XKoB81pgLe3m4BUIHB9deXXLMl03Q3JxX/Ey20O/46FuQLwpkjf1zRBb1u47f27q6Rz0
         D+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Y6DWf11Qz2bYLzKgTXfzvhPpzy9rFHi4fQOiXP1iEe0=;
        b=mWbQsVyspL1+oViR3h4rAcRpAkTjfI7Hq41tY9dsdj1JUsXLiWkfmduvp5JzPlpbSU
         T1optbQJO8rX3tq1RtkvxYLDc6uFQYXsTyNx5vkBG7TbCi/ZPi9aadW+AYFELNGiqvU3
         U/HwoMElKYAod4PkGEw58spWXlcqf2gl5rXapOmrpSFtPlnIUOlhgmDkGF4/Y+dipR5b
         Jdwvtga5Xb8XZRuBTYt7rkhLKKuR/bgNNW7oWkGgBJ3WAEPIsmkSDIwPq32vnpazugl+
         /0wb76CcfVRKQFoOoax1DHsDJhzgcOeqsZ+H0RkZRccOv/h+j5q2eMMot7qkKTebD2Bp
         BmCg==
X-Gm-Message-State: AIVw110CIfrw18BDnmL4wrd7NymnVQQGrHzFalN4TghmlRIbG3R6T6p8
        29Ijp4blVZFbKh73byXyPqj2D3TXooRf
X-Received: by 10.55.104.81 with SMTP id d78mr2983531qkc.24.1499929953429;
 Thu, 13 Jul 2017 00:12:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.63.198 with HTTP; Thu, 13 Jul 2017 00:12:32 -0700 (PDT)
In-Reply-To: <xmqqr2xl1suy.fsf@gitster.mtv.corp.google.com>
References: <CAE5ih7-Sy9YmGbLs=wzfxXCSFLkEotqLRuu_xNz9x=7BhvrvnA@mail.gmail.com>
 <20170711225316.10608-1-miguel.torroja@gmail.com> <CAE5ih78mrTz1sfJbRSuPTNojxWyH_1JFDY2pe7GMAZdPhzcvpA@mail.gmail.com>
 <CAKYtbVb8T=edPG5539=uwDjHnCerLO2Oejy8bWK+giSS8nNGig@mail.gmail.com> <xmqqr2xl1suy.fsf@gitster.mtv.corp.google.com>
From:   Miguel Torroja <miguel.torroja@gmail.com>
Date:   Thu, 13 Jul 2017 09:12:32 +0200
X-Google-Sender-Auth: YkZrxrmzTZvGmVbWKMQUxpzBiyk
Message-ID: <CAKYtbVaxR0sdL_k=vy-aT5wEzvCTzDcM6Q-i0hO6jLMzjEUwmA@mail.gmail.com>
Subject: Re: [PATCH] git-p4: parse marshal output "p4 -G" in p4 changes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks,

I've just sent in reply to your previous e-mail three different patches.

* The first patch is just to show some broken tests,
* Second patch is to fix the original issue I had (the one that
initiated this thread)
* Third patch is the one that filters out "info" messages in p4CmdList
(this time default is reversed and set to False, what is the original
behaviour). The two test cases that are cured with this change have to
set explicitely skip_info=True.


On Wed, Jul 12, 2017 at 7:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Miguel Torroja <miguel.torroja@gmail.com> writes:
>
>> The motivation for setting skip_info default to True is because any
>> extra message  output by a p4 trigger to stdout, seems to be reported
>> as {'code':'info'} when the p4 command output is marshalled.
>>
>> I though it was the less intrusive way to filter out the verbose
>> server trigger scripts, as some commands are waiting for a specific
>> order and size of the list returned e.g:
>>
>>  def p4_last_change():
>>      results = p4CmdList(["changes", "-m", "1"])
>>      return int(results[0]['change'])
>>  .
>>  def p4_describe(change):
>>     ds = p4CmdList(["describe", "-s", str(change)])
>>     if len(ds) != 1:
>>         die("p4 describe -s %d did not return 1 result: %s" % (change, str(ds)))
>>
>> Previous examples would be broken if we allow extra "info" marshalled
>> messages to be exposed.
>>
>> In the case of the command that was broken with the new default
>> behaviour , when calling modfyChangelistUser, it is waiting for any
>> message with 'data' that is not an error to consider command was
>> succesful
>
> I somehow feel that this logic is totally backwards.  The current
> callers of p4CmdList() before your patch did not special case an
> entry that was marked as 'info' in its 'code' field.  Your new
> caller, which switched from using p4_read_pipe_lines() to p4CmdList()
> is one caller that you *know* wants to special case such an entry
> and wanted to skip.
>
> Your original patch that was queued to 'pu' for a while and then
> ejected from it after Travis saw an issue *assumed* that all other
> callers to p4CmdList() also want to special case such an entry, and
> that is why it made skip_info parameter default to True.
>
> The difference between knowing and assuming is the cause of the bug
> your original patch introduced into modifyChangelistUser().
>
> The way I read Luke's suggestion was that you can avoid making the
> same mistake by not changing the behaviour for existing callers you
> didn't look at.
>
> Instead of assuming everybody else do not want an entry with 'code'
> set to 'info', assume all the callers before your patch is doing
> fine, and when you *know* some of them are better off ignoring such
> an entry, explicitly tell them to do so, by:
>
>  * The first patch adds skip_info parameter that defaults to False
>    to p4CmdList() and do the special casing when it is set to True.
>
>  * The second patch updates p4ChangesForPaths() to use the updated
>    p4CmdList() and pass skip_info=True.  It is OK to squash this
>    step into the first patch.
>
>  * The third and later patches, if you need them, each examines an
>    existing caller of p4CmdList(), and add a new test to demonstrate
>    the existing breakage that comes from not ignoring an entry whose
>    'code' is 'info'.  That test would serve as a good documentation
>    to explain why it is better for the caller to pass skip_info=True,
>    so the same patch would also update the code to do so.
>
> While I was thinking the above through, here are a few cosmetic
> things that I noticed.  There is another comma that is not followed
> by a space in existing code that might want to be corrected in a
> clean-up patch but that is totally outside of the scope of this
> series.
>
> Thanks.
>
>  git-p4.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 1facf32db7..0d75753bce 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1501,7 +1501,7 @@ class P4Submit(Command, P4UserMap):
>          c['User'] = newUser
>          input = marshal.dumps(c)
>
> -        result = p4CmdList("change -f -i", stdin=input,skip_info=False)
> +        result = p4CmdList("change -f -i", stdin=input, skip_info=False)
>          for r in result:
>              if r.has_key('code'):
>                  if r['code'] == 'error':
> @@ -1575,7 +1575,7 @@ class P4Submit(Command, P4UserMap):
>                  files_list.append(value)
>                  continue
>          # Output in the order expected by prepareLogMessage
> -        for key in ['Change','Client','User','Status','Description','Jobs']:
> +        for key in ['Change', 'Client', 'User', 'Status', 'Description', 'Jobs']:
>              if not change_entry.has_key(key):
>                  continue
>              template += '\n'
