Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D55207EC
	for <e@80x24.org>; Fri, 23 Sep 2016 22:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757756AbcIWW3x (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 18:29:53 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32906 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbcIWW3w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 18:29:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id w84so4764017wmg.0
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xG0iohEnZ+DOi+xy9xLr3dCAUV/flvH6MLYpmGL+TdI=;
        b=yJNMGYN61Vt8JsZWpM64cxI1dx+tzlHopW+MCutQh+ofrflzuKbJykRg5G1JRl9klP
         mnxVoLRYyJZqy3L7sk1yK/fPVq0VdzaAJBvuqZT4Ttwk//HuAPahkSzdAXs2CeXymnzv
         AY34QqnM3IAifPfQB8HkWmIPEvDl752qflJkjCpoAoh7AR7r2WEFqWGnaV6qRGjeGg+W
         sIcUgfLHG8oNU8vlTvJf+qWVvf2DNjIofFIBdoeuavtnTuGYsQrzPd1Zk/g5o/6XoJq9
         p+bdJCs2UNDHdIO1og6ddA1jl9aiKaPaxLwuY/LR2CJrMhES3w8rsa0IaCSMetdRSO0E
         gMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=xG0iohEnZ+DOi+xy9xLr3dCAUV/flvH6MLYpmGL+TdI=;
        b=E7fLmjotvdPFATedi1BVVSNZ8mzBTJgGGtg2uxMRzhoZ4XsQztlAW7CtAe+84qq6Bi
         NOVOL0+FoZoksRpMmABYG0IuLbyeQRJ1W3JRlMPJ1WExaVf98+zSGoTt4+ZhioTKwLwu
         mre2Gsuqcotv1r2Ztgf86PYrr5aeJKX5QupCUuUCVUnHz0TV7wwcCI05EIekp6YF12sS
         eFUOcwFJjLZzRtLrsE90gyB4qFVQ8XLuPA2n4Ynf0NnY3IS/JuYbAwLNeCtT/zMEHtxv
         txo/iDsreqYVP29BD6yVmwZaMakToSWnR0/kM58ISoo8DI1rkws+6LKEtxEjIw/VY2m4
         F/Xg==
X-Gm-Message-State: AA6/9Rn7Hfh/uwDzHi4a8Hgw5O8H0m/CrTJWdoWugSeOg/+z6ziNDulwGW2rXeSVpS2OAA==
X-Received: by 10.28.93.20 with SMTP id r20mr4453841wmb.89.1474669790586;
        Fri, 23 Sep 2016 15:29:50 -0700 (PDT)
Received: from [192.168.1.26] (epq151.neoplus.adsl.tpnet.pl. [83.20.58.151])
        by smtp.googlemail.com with ESMTPSA id uw3sm9240459wjb.21.2016.09.23.15.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Sep 2016 15:29:49 -0700 (PDT)
Subject: Re: .gitignore does not ignore Makefile
To:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>
References: <CAOZdJXWpcSZ+jAoV8HttkaB7Fh=wzWDTCsHy8W-S9xOOBodVFw@mail.gmail.com>
 <20160922154421.GA6641@ikke.info>
 <xmqqy42j4wp9.fsf@gitster.mtv.corp.google.com>
Cc:     Timur Tabi <timur@codeaurora.org>, git <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <d98bd20f-870a-71a0-fda2-aabe71a5f981@gmail.com>
Date:   Sat, 24 Sep 2016 00:29:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqy42j4wp9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 22.09.2016 o 20:26, Junio C Hamano napisał:
> Kevin Daudt <me@ikke.info> writes:
> 
>> Often people advise tricks like `git update-index --assume-unchanges
>> <file>`, but this does not work as expected. It's merely a promise to
>> git that this file does not change (and hence, git will not check if
>> this file has changed when doing git status), but command that try to
>> change this file will abort saying that the file has changed.
> 
> It actually is even worse.  As the user promised Git that the <file>
> will not be modified and will be kept the same as the version in the
> index, Git reserves the right to _overwrite_ it with the version in
> the index anytime when it is convenient to do so, removing whatever
> local change the user had despite the promise to Git.  The "abort
> saying that the file has changed" is merely various codepaths in the
> current implementation trying to be extra nice.
 
There is a trick that works almost as 'ignore changes' for tracked
files, namely `git update-index --skip-worktree <file>`.  From the
documentation:

  Skip-worktree bit
  ~~~~~~~~~~~~~~~~~

  Skip-worktree bit can be defined in one (long) sentence: When
  reading an entry, if it is marked as skip-worktree, then Git
  pretends its working directory version is up to date and read
  the index version instead.

  [...] Writing is not affected by this bit, content safety is still
  first priority. [...]

It works quite well; the only problem is that `git stash` would
not stash away your changes, and you would need to unmark such
file before saving a stash.


With --assume-unchanged used for ignoring changes to tracked files,
you can quite easily lose your work because you are lying to Git.


Note also that in Git classic "ignored" implies unimportant.
-- 
Jakub Narębski

