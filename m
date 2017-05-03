Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767001F829
	for <e@80x24.org>; Wed,  3 May 2017 16:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbdECQ67 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 12:58:59 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36458 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751394AbdECQ66 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 12:58:58 -0400
Received: by mail-pf0-f179.google.com with SMTP id q66so15401816pfi.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SwcDjWEDgXY2dsO+nxpzjyB9iwyfds0LU4ONCK33eKw=;
        b=FbJNtUGxwMtWO69km8iPlKyQTXTBmCDSEB0hhV8WV0+iLSaNvgoJx6WpUBhMw9GVLA
         VyHiJuvx2NyUlf2KnbmaEUsgUXSHdQnaRv5kzW5dqMuEkW5Vc9MRTUk3QjcgssPuyIxL
         oegglaSjGU4DT7zeLcgLTWXwmkggBygteWL71HMLkwuzbYH38Odcglg1lwDFMzqOpdL0
         7ZIe9VanHwcFergCOBUCS8em8CCisU8oSChA9R0KHu5w0r3imkH0kxHPlL3NC8kW4TtO
         rgNicAfcREljMY+Jfqy+k7V43uFb2m6XVF7w7iHhVOieKjA9LYby8j/xKuSBQWk+Jwvl
         Cnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SwcDjWEDgXY2dsO+nxpzjyB9iwyfds0LU4ONCK33eKw=;
        b=gcjs3HRmLGb3uUMS7wCBx6KSezej3Had+MJ+V6w9HE8ske1UTwkJFXivKkwc5MUch/
         RXpNIc5egqWhJRaOryZ3fXT2oQO1o0P3sVOZKW6aXr5jRQHeWfzeW7MAGJNrglSoj5Jt
         m92USGAoo6JTuQflabBSG1SVH4nGtjW1YtTa01ckAdhs+oyJPVZAyvC0lIOh4Q13v0dA
         XkYUuj2VLEvIaLBwC15aghV4oqzJKHs8SJNqLkqz42ViM4/07PXKptn8p4xRRC9CfN5G
         yrZGPlx0PKJwaxu0LX12dEH8l1zm3ngjHzmFlelBiyCaboUivDbNQcI4U2zW97sGBTsO
         itMA==
X-Gm-Message-State: AN3rC/4RBCoxBOuiMXl4aRengZpZ0crE81U3kPUiyvp1ovklD5KtDS3Y
        y4qc8rQcrgV45O/3JM/cBk7U7jtAkZuW
X-Received: by 10.99.107.198 with SMTP id g189mr39653011pgc.162.1493830737168;
 Wed, 03 May 2017 09:58:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 3 May 2017 09:58:56 -0700 (PDT)
In-Reply-To: <20170503164744.GY28740@aiede.svl.corp.google.com>
References: <20170503162931.30721-1-jn.avila@free.fr> <20170503164744.GY28740@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 May 2017 09:58:56 -0700
Message-ID: <CAGZ79kb0CaoTpZ+HJEDygzuJ14dEDqaCyNcdHEN9_nnkaMhnzg@mail.gmail.com>
Subject: Re: [PATCH 1/4] usability: don't ask questions if no reply is required
To:     Jonathan Nieder <jrnieder@gmail.com>, rashmipai36@gmail.com
Cc:     Jean-Noel Avila <jn.avila@free.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc rashmipai36@gmail.com

On Wed, May 3, 2017 at 9:47 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Jean-Noel Avila wrote:
>
>> As described in the bug report at
>>
>> https://github.com/git/git-scm.com/issues/999
>
> External issue tracker URLs have been known to change or disappear and
> we try to make commit messages self-contained instead of relying on
> them.  It is common to put a 'Requested-by:' footer or sentence saying
> 'Requested at <url> by <person>' near the bottom of a commit message
> for attribution and context.  Relying on the bug report more heavily
> like this example (instead of including any relevant information)
> makes it harder for a reader to understand the patch easily in
> one place.
>
> In other words, instead of asking the reader to read the bug report,
> please include pertinent information the reader needs to
> understand the patch here so they don't have to.
>
>> the user was disconcerted by the question asked by the program not
>> requiring a reply from the user. To improve the general usability of
>> the Git suite, The following rule was applied:
>>
>> if the sentence
>>  * appears in a non-interactive session
>>  * is printed last before exit
>>  * is a question addressing the user ("you")
>>
>> the sentence is turned into affirmative and proposes the option.
>>
>> Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
>> ---
>>  help.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/help.c b/help.c
>> index bc6cd19cf..4658a55c6 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -411,8 +411,8 @@ const char *help_unknown_cmd(const char *cmd)
>>
>>       if (SIMILAR_ENOUGH(best_similarity)) {
>>               fprintf_ln(stderr,
>> -                        Q_("\nDid you mean this?",
>> -                           "\nDid you mean one of these?",
>> +                        Q_("\nThe most approaching command is",
>> +                           "\nThe most approaching commands are",
>>                          n));
>
> For what it's worth, I find the new text harder to understand than the
> old text.
>
> From the bug report:
>
>         Now git says git: 'stahs' is not a git command. See 'git --help'.
>         Did you mean this?
>
>         stash
>
>         Git asked if i meant git stash. and i entered yes. and git
>         printed the character y infinite times.
>
> If I'm reading that correctly, the problem is not that questions are
> alarming but that Git did not cope well with the answer.  When I try
> to reproduce it, I get
>
>         $ git stahs
>         WARNING: You called a Git command named 'stahs', which does not exist.
>         Continuing under the assumption that you meant 'stash'
>         in 5.0 seconds automatically...
>
> which is much clearer.  After commenting out "[help] autocorrect = 50" in my
> ~/.config/git/config, I get
>
>         $ git stahs
>         git: 'stahs' is not a git command. See 'git --help'.
>
>         Did you mean this?
>                 stash
>
> which does seem improvable, at least for consistency with the
> autocorrect case.  For example, would something like
>
>         $ git stahs
>         fatal: You called a Git command named 'stahs', which does not exist.
>         hint: Did you mean 'git stash'?
>
> work better?  And the autocorrect case could say something like
>
>         $ git stahs
>         warning: You called a Git command named 'stahs', which does not exist.
>         warning: Continuing under the assumption that you meant 'stash'
>         warning: in 5.0 seconds automatically...
>
> Is contact information for the bug reporter available so we can try out
> different wordings and see what works for them?

yes, cc'd.
Also see
https://public-inbox.org/git/CAOqCAXSOZCG8mijV+yATtmC1PFGYiOSqtraSdbhbP2rRHBO_Qg@mail.gmail.com

>
> Thanks and hope that helps,
> Jonathan
