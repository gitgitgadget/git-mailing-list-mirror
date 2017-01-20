Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D423F1F89C
	for <e@80x24.org>; Fri, 20 Jan 2017 11:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbdATLTU (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 06:19:20 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32796 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbdATLTH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 06:19:07 -0500
Received: by mail-lf0-f68.google.com with SMTP id x1so8277516lff.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 03:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zzyvDvNsOJdR2pkxxV1K9Wqx6Mvm8LTHMafo9pvqpZg=;
        b=D5UtNLCKQj1Ou+DQ+XV4Hfm8CC96MC0qOIzUlg/Pv2SXREZirBF63QGez/2jhM6J7O
         rbnz0nU+3O2t1ZOovFLZ7OLZilEo5HPhcqXpeFYQzIr/vUV1B8wCzqoHaHF5lYZayke8
         /6DvcFpAH+sbnOPD+7llb99HiQ1XHVfsY2NIyPB8yRA0qkRYzZ8knFWAodm7SUztQMNx
         d2Qctz1rk5vesYehLyPKCQxdqy4UtVaozEg1bVX0336zHOc7LT5wFT733TV1HnNTFO5U
         p+6uEY85hd4CSkUZowq+69NolnZk6jBTKwavsJqygm4VIliQRosUKesCOdmCU7CRyjyr
         8OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zzyvDvNsOJdR2pkxxV1K9Wqx6Mvm8LTHMafo9pvqpZg=;
        b=pqrwDLqgyJ5oh2sBGVm4QhOkxEeVVBscd5+qJ7lGP5i6JD6Cl3PRo6H72jIF4exZwI
         CciWVwRt2VRcGrVUUaWMH8c4GSAA6pBBsB2QMet7BlO4pq4AWQcTnteLKuQkYxWhfZPX
         gFqUqKVwjuan6s/rvHsmk3a9stZbXhEni+FXnB22A981QqQEHdkQ/WIROGupq2wtrFZJ
         9hTAFEwfdIJ9Kzkhb1UQxl3hzHfs4OiCexz6EWUxZ8GKhTDDnB5p9+HXr+3Ki1whboG7
         aO/trtxkFFibmJvIY4ipt8EoUbKgg/JhUFmBB6qRAuIKjLyy/9B6x/bi7BHWvV0BuER6
         Z+ZQ==
X-Gm-Message-State: AIkVDXLiq2mf25kVaFiI6W4GADxB7Zh/xfQxtcXQaqqO7fQV/AY75lrAny/73rFY5cCiNQ==
X-Received: by 10.25.132.6 with SMTP id g6mr5052577lfd.144.1484911116167;
        Fri, 20 Jan 2017 03:18:36 -0800 (PST)
Received: from [192.168.1.26] (enm186.neoplus.adsl.tpnet.pl. [83.20.2.186])
        by smtp.googlemail.com with ESMTPSA id d16sm540632lfj.28.2017.01.20.03.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jan 2017 03:18:35 -0800 (PST)
Subject: Re: Git: new feature suggestion
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <4817eb00-6efc-e3c0-53d7-46f2509350d3@synopsys.com>
 <20170119093313.ea57832dfd1bc7e0b0f1e630@domain007.com>
 <CA+55aFxAe8bH2xXkx1p5gYN+nc-D-vjNnfUeA_64Q3ttpbHq+w@mail.gmail.com>
 <b96b71b9-f8a2-d039-6e8a-c64e7aac02a0@gmail.com>
 <CA+55aFz5Rnt8U3bpvgoHQSfjPrnxnMfWUGBbHW2XKiagKXga5w@mail.gmail.com>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Git Mailing List <git@vger.kernel.org>,
        "CARLOS.PALMINHA@synopsys.com" <CARLOS.PALMINHA@synopsys.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <e9e988b6-290f-3160-222f-2762865fe508@gmail.com>
Date:   Fri, 20 Jan 2017 12:18:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFz5Rnt8U3bpvgoHQSfjPrnxnMfWUGBbHW2XKiagKXga5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.01.2017 o 01:26, Linus Torvalds pisze:
> On Thu, Jan 19, 2017 at 1:48 PM, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 19.01.2017 o 19:39, Linus Torvalds pisze:
>>>
>>> You can do it in tig, but I suspect a more graphical tool might be better.
>>
>> Well, we do have "git gui blame".
> 
> Does that actually work for people? Because it really doesn't for me.
> 
> And I'm not just talking about the aesthetics of the thing, but the
> whole experience, and the whole "dig into parent" which just gives me
> an error message.

Strange. I had been using "git gui blame" _because_ of its "dig to parent"
functionality, and it worked for me just fine.

The other thing that I like about "git gui blame" is that it shows both
the commit that moved the fragment of code (via "git blame"), and the
commit that created the fragment of code (via "git blame -C -C -w", I think).


Anyway, all of this (sub)discussion is about archeology, but what might
be more important is automatic rename handling when integrating changes,
be it git-am, git-merge, or something else...

-- 
Jakub Narębski

