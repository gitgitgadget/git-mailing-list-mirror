From: Jiang Xin <worldhello.net@gmail.com>
Subject: Vietnamese l10n pull request problems
Date: Mon, 28 May 2012 11:31:50 +0800
Message-ID: <CANYiYbHWsfNSVESsZ6KoSH+_FEuLrrESC1_N0=DB5uMaWSv+Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 28 05:32:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYqgb-00024u-P8
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 05:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754183Ab2E1Dbz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 May 2012 23:31:55 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48722 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468Ab2E1Dbv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2012 23:31:51 -0400
Received: by obbtb18 with SMTP id tb18so4776160obb.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 20:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=M2WQacgSsApdOPLMkBjW6oUZQDV8MuZhBzvtNXQcChE=;
        b=hecjYc/7OlXTUw8gDWZrm4ZKMCDzuGO/DTrYEBpykUa0XLYoZGLt1NQaFIJArK16lJ
         M3wFJ9Z9mS+PCcuUKivQStu3TGJEh6RvvG+YnerfQ9l5aE1wYVMcIxS0rABwfOvkyGrv
         ppjmvp4H8LFaIQKZIvXesOVxpzcmD5ik1HJdoBbxkpQVT9S0Q+opmXY4vraYsAHf9zsC
         qJnUKVTtw6oqrsaZO5RCZxZyrynetRjJrcrixu4fWwo39wkkxg90dnFLzF5sqkIMAvau
         Bgh+K0Y1ZTNCWhgQj+S1vn2bnV/6Q1dR056Jzb9it9CeKTgS3hl8QbF4kUlyLSY3A0bU
         VG/w==
Received: by 10.50.209.73 with SMTP id mk9mr3426478igc.66.1338175910515; Sun,
 27 May 2012 20:31:50 -0700 (PDT)
Received: by 10.50.82.105 with HTTP; Sun, 27 May 2012 20:31:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198623>

Hi, all

Vnwildman, the new git l10n team leader for Vietnamese send me a huge
pull request, it has some problems I think other l10n teams should care=
 about.

The URL for the pull request is https://github.com/git-l10n/git-po/pull=
/22 .

1. Commit log should has a signed-off-by line, no dought

2. Trival commits (from the same contributor, with not description in
    commit log) should be squashed or not, I am not sure.

    The comment is at:
https://github.com/git-l10n/git-po/pull/22#issuecomment-5954319

>> From Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n <vnwildman AT gmail.com>=EF=
=BC=9A
>>> squash
>> It isn't necessary. When you pull from my repository, it will merger=
 automatically.
>
> If the six commits are from different people, or each commit is atomi=
c and is
> necessary for other contributors to review it, or every commit has a =
well written
> commit log (with not only single subject line, Signed-off-by line, bu=
t also with
> detail description for the commit), you won't squash them.

3. l10n team leaders should not merge git upstream directly.

>> Oh dear!I hate to change history!
>
> You must clean your history for two reasons:
>
> 1. One pull request to upstream git.git was rejected by Junio, for
>     one commit from the German team hacked files outside po/
>     directory. So I changed the history of git-l10n/git-po. I am sorr=
y
>     you are victim for this.
>
> 2. You pull from git.git, such as commit 95a3338c8dc,
>     25d0a1d66462, 0851be, ad32d7f.
>     which are not suitable for l10n team leaders.
>     Don't do that, I can not review these merge commits.

4. Fuzzy tranlations must be fixed before pull request can be accepted
    and closed.

    Comment URL: https://github.com/git-l10n/git-po/pull/22#issuecommen=
t-5954625

>>> I also found that there were 28 fuzzy translations in your vi.po.
>>> You must fix them before I can close this pull request.
>>
>> fuzzy translations, Why it is the problem?
>
> Fuzzy means wrong, outofdate translation, I will make Vietnamese
> people puzzled. For example, orignal message is
> "Delete file, yes or NO? (default no)", but the fuzzy translation is
> "Delete file, YES or no? (default yes)". You translation will hurt ot=
hers.
>
> But you can leave them untranslated. Untranslated l10n message is OK.
>
>> The last question:
>> So, I have to change my history, don't I?
>
> You have to make your history more clear, for the two reasons I just =
talked above.
> But for fuzzy translations, you can just make another commit and fix =
them.

--
Jiang Xin
