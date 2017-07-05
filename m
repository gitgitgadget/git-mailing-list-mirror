Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840DE202AC
	for <e@80x24.org>; Wed,  5 Jul 2017 00:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752257AbdGEARa (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jul 2017 20:17:30 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36606 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbdGEAR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2017 20:17:29 -0400
Received: by mail-pg0-f47.google.com with SMTP id u62so115578874pgb.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2017 17:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nh8g/8s/tSh/lyVzCRu/tR4rdDBFENl1/Ljx0pL7C1Y=;
        b=KML0wxTRpOivrmA+nTCxkBnAY3/9eH+dcATMj3unmYzMnPx5ZqwOAg/95p8TLP0hsA
         Ae58GshKJtQs/AUGlbswuVMN6B8Eesf7G8B0avrZmhTVtNCBbENo/wk9F24zGZ1ceSGs
         S9BjmDEJ69i2WinVp8FK/Q6skN0sbSRY/3t69x5fTMisNP9A6+KVlBAgzAuvtGxFCO9c
         3Upj0x0eVeU0F/6X5271bVsjU9Yktc8T8ybhsv6lVjhrxD1su3wFjTOvbPwWWFKvEwE6
         mr89re+2FHyyBLzlp7OnqerqBY//H7/37+SluxVJdco9jxijuBTOzyv86K5aom0cS9aw
         bvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nh8g/8s/tSh/lyVzCRu/tR4rdDBFENl1/Ljx0pL7C1Y=;
        b=elVz6ssyGdaP7+Zb2om2LBQmhOsCy5XXPnT650JkyZPx2eDxroVwTyDTAYNFnvwp3p
         6H8gSWcmq9i9eMI4laleyUH2sjNiGENc/IqMm68/Lzun00n/KlBMZZE+cTYq/52Bn5Ev
         fmAKKnVNhVaO0twnBwwUiQ5OxaeiJRuEjf6MKOdH0sYm+4MQDgeDFaPpXyAL7uIxkwgn
         HBYRjDGP3TSAKA+aYgc69yzIYsxVuwKwHjTqBMkbEPKPj8L3AJ9fzVwXNKhe3W+TBdej
         wzDYYNX/xBASY3S6jplpWectOuc4t1Aa05V9MZOareNuBfDWvAndakxbjDOUlE1SrLLw
         5B2g==
X-Gm-Message-State: AIVw110N0Q4vKoFvQG65N1ZtgY+x60F8N8vctJtOv9VMBfx/mOzAGMxU
        W2sfYlpnkuOKNbKpOIOrxrpqS+uVoKF85SxkmQ==
X-Received: by 10.98.19.136 with SMTP id 8mr17595437pft.105.1499213848984;
 Tue, 04 Jul 2017 17:17:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Tue, 4 Jul 2017 17:17:28 -0700 (PDT)
In-Reply-To: <xmqq8tk4loyr.fsf@gitster.mtv.corp.google.com>
References: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com> <4374FA169AD7465AA39BDB477A348B02@PhilipOakley>
 <xmqqo9t1l6vi.fsf@gitster.mtv.corp.google.com> <C31723137B784D54A3CDB1B7D9432D7E@PhilipOakley>
 <xmqq8tk4loyr.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Jul 2017 17:17:28 -0700
Message-ID: <CAGZ79karazektmWg0nneYnfGU29dm8BtPUndOCobetH4xSy=tg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2017, #09; Fri, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 3, 2017 at 11:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>
>>> I am not sure what you are asking.  Is this the command you are
>>> looking for?
>>>
>>> $ grep -e "^[[*]" whats-cooking.txt
>>>
>> Ah, thanks.
>>
>> It does presume that one has extracted the email to the text file,
>> which is easier on some systems and mail clients than others ;-)
>
> Perhaps you would want to find an e-mail client that can handle text
> files better, then? ;-)
>
> If you are cloning and following along my tree from one of these
> places:
>
>     git://repo.or.cz/alt-git.git/
>     git://git.kernel.org/pub/scm/git/git.git/
>     git://github.com/git/git.git/
>
> the 'todo' branch in these repositories keeps track of the
> whats-cooking.txt report (among other things), so you can also:
>
>     $ git cat-file -p origin/todo:whats-cooking.txt |
>       grep -e "^[[*]"
>
> to get the same effect.
>

FWIW:
I have a script in my git dir,

cat git/cookreport.sh
git -C Meta pull origin todo
Meta/cook -w

with Meta being a repo tracking one of the URLs above.

I might add  a | grep -e "^[[*]" or add some scripting to verbose
report my own topics.

Thanks,
Stefan
