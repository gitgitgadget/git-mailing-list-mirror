Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34E91F803
	for <e@80x24.org>; Wed,  9 Jan 2019 15:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfAIPJF (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:09:05 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40923 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731728AbfAIPJF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:09:05 -0500
Received: by mail-ot1-f52.google.com with SMTP id s5so6924335oth.7
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=4c1gI31sfz7O3xLcje08XpN9ATWw11MFFOT0pCKVL5A=;
        b=OGwSaaUqJJw7MCLmIuTuJoPmyqVSxQE6Y3AaK1okPhqLeABjTYvsz5dZo0zlG1vvv6
         kXWoP/UZV86dr3Vr1voR2Zap6g9yRwR1Alqxzxlzf9zehsi7MeLwv4WNLrLmBfsxUaPg
         VZ9/+1Q2ddnbhL3x8r1H1Pkp8/cJyREJcbyUhzro/ha9lTcI+qnZAIq0IqDfBwOleZjC
         fZ+zG7uby6xyyv279WV5pmTStU/wy6tqCrZb4s6D/KRxZ1EtfBmUILcmTwTU5Xn91N0O
         sWiE6GTIYOxYBnDzYGUrPgStIlOU9hG4TWIIICJ1BOihIwJTW5p2nVe9n8Ricnonh2yo
         DFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=4c1gI31sfz7O3xLcje08XpN9ATWw11MFFOT0pCKVL5A=;
        b=lrivrIh28eyZ3QiKd8yDFCgblF9wfA6x75D+BdbHSTOOzUFfRYqPO8WdfFC3GBUawi
         MVh4AqsPMPgfnNnjj8TFmZLknf/wkeeTiZSKb/TEPX905z7UBR/uOSpMqVKNonVjVA1r
         0hLmhYLK9NapDMYupJs1UDMZPKslRRVNR7acRyPb8uPQIPRjCl/BxghQ9NcJdlTWTj4l
         EqmbVRh5krCMoybqbXGohHrR+YqopJoIhqFHgpgAoiGUpNtG332chcPBHCUR//KB10Eh
         51hEjZsQ+q0Dv+RgDEDxL7FaKJK25kwf5Idvp3V0JKXO4XW9Sf1FsM6FXz8qL//92KFR
         wEaA==
X-Gm-Message-State: AJcUukdoks3fdwjLgKqiERdEmoZZjMIg/GGQ1r98T4g4QJj0Kg0hnktr
        RC/vtdr8ofu3VpQ+WfGIt0Kn0S+eh3caid78V2o2Jw1H
X-Google-Smtp-Source: ALg8bN6i2JrVLhU5J3BTT4rwVaDVNlHitpEBtiDdrguLwix4ny2ofKNvjlvazTHm9PyaVr3iskuHugyoJiPppXr6O9s=
X-Received: by 2002:a9d:430:: with SMTP id 45mr4502160otc.75.1547046544325;
 Wed, 09 Jan 2019 07:09:04 -0800 (PST)
MIME-Version: 1.0
References: <CA+h-Bnuf6u=hkPBcxhMm06FbfkS+jtrozu+inqqmUY1cNkXrWQ@mail.gmail.com>
 <87va2zavu1.fsf@igel.home> <CA+h-BnvN7+ETU-vFxAGDvs0gvXUjAAhMkvTPUxoRTt2Gb4b2ow@mail.gmail.com>
 <CA+P7+xq++4W32JT9WcasXn=Oj9W-U1eteFgpLZn8GVqeO0foog@mail.gmail.com> <nycvar.QRO.7.76.6.1901091501320.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901091501320.41@tvgsbejvaqbjf.bet>
From:   Markus Wiederkehr <markus.wiederkehr@gmail.com>
Date:   Wed, 9 Jan 2019 16:08:52 +0100
Message-ID: <CA+h-Bnvp3mrXBqqY+mdD36feOkx1EhnnQtDXrmPhyW4KzKb_3w@mail.gmail.com>
Subject: Re: git rebase: retain original head?
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 9, 2019 at 3:05 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Having said that, it is an unintended regression in the built-in rebase.
> Markus, could you come up with a minimal test case, preferably in the form
> of a patch to t/t3415-rebase-autosquash.sh?

I don't think I'm familiar enough with the test code to be able to
provide a good patch but the following code should illustrate the
regression.

git init testrepo
cd testrepo
echo 1 > file && git add file && git commit -m "initial"
echo 1 >> file && git commit -am "commit 1"
# rev_commit_1=$(git rev-parse HEAD)
echo 1 >> file && git commit -am "fixup! $(git rev-parse --short HEAD)"
echo 1 >> file && git commit -am "commit 3"
rev_orig_head=$(git rev-parse HEAD)
GIT_EDITOR=: git rebase --autosquash -i HEAD~3
test $(git rev-parse ORIG_HEAD) = $rev_orig_head

In older versions of git this test succeeded, i.e. ORIG_HEAD pointed
to the previous original head, $rev_orig_head. In git version 2.20.1
ORIG_HEAD now points to the commit that got fixuped instead,
$rev_commit_1.

In previous versions ORIG_HEAD only pointed somewhere else if "git
reset" was invoked manually during the rebase operation. I'm not sure
if this is desirable, maybe ORIG_HEAD should always point to the
previous head after rebase completes, no matter what operations were
run in between. What do you think?

Markus
