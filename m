Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC891F744
	for <e@80x24.org>; Thu, 30 Jun 2016 10:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbcF3Klb (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 06:41:31 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37023 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbcF3Kla (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 06:41:30 -0400
Received: by mail-wm0-f50.google.com with SMTP id a66so112223011wme.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 03:41:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3uLGAfpDDIyBYN/zFGX+RNpHF7rZBh0JvT4ICJ1U80k=;
        b=JFDECTkUaF3YCQtWIGcljWsR8EA2EkMeL35FbQOUFUUCBXQdnvx/fAAasAIW/n/nn6
         6Qjwuo6HqeAGKp50DzFgoeCsPUJvy/bgnx05ucEWV2OyuBP/01sBRn2YgBNe/n7P6rIs
         4Em2rkhIpoRZQYqxp0khkaJ2vv9goq8nwCzd8hknmuvn+5FKH8BIErbe3R2mS+RTACWj
         vZTHNb0okoalVTc9+Qk5198hk83ICJpNXzsNvWV03BjjRNmgAJ/ocEOFaSHMkU6WvZhW
         pyLJv3xjz+CFa+vsDdcvaF3DNz299gWuKmLvd/JQppWv25PjKTKKhQnbbsWP/u15ywle
         ZALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=3uLGAfpDDIyBYN/zFGX+RNpHF7rZBh0JvT4ICJ1U80k=;
        b=M/rB+lAw0Usx4LNPJy/WUrVErKmBOsUWYfTS6coeFnMVYCy2PTixZnwcWPc6ylBpsX
         IZLodmOHVC1c1g/iMVVZzIaiy10Hsll6BNgxRlnMm397oy79P9UZjE+ssyxDWxEH+w3t
         ZcMjjvuzjFiDA7tjBkgLQO0B/IVNdDj+UxM8+wrP+lcPlNKGGDPHTaC0yM6lv8rj8ena
         QsSJotcb0abeChHI3JGG3g7c9+NUKVcQQ/3hfzSSaPapw/iZBifbNJCx/YUmMPg9GyRn
         vctoZUdmwyA/wKdBWE77kI7K6HanywOKCtPUXuaAZ0M3zczh5v/PqSli7Fr5GmqEKo62
         30IQ==
X-Gm-Message-State: ALyK8tIVCR9xGpGlvmFAOenRNtamIwtPMc1NgRcIJnm69xmUuQfAT+fCZtu91a3LxXC4DA==
X-Received: by 10.194.200.164 with SMTP id jt4mr13341137wjc.18.1467283288507;
        Thu, 30 Jun 2016 03:41:28 -0700 (PDT)
Received: from [192.168.1.34] (daw105.neoplus.adsl.tpnet.pl. [83.23.22.105])
        by smtp.googlemail.com with ESMTPSA id q6sm2750723wjt.46.2016.06.30.03.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2016 03:41:27 -0700 (PDT)
Subject: Re: git tag --contains for cherry-picks
To:	Jeff King <peff@peff.net>, Laszlo Papp <lpapp@kde.org>
References: <CAOMwXhNp9SwA_oQ8bE6-m72C+po+28maGtsP8wRFRfBLjSb5NA@mail.gmail.com>
 <20160630062236.GA15380@sigill.intra.peff.net>
Cc:	Git List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5774F747.4000700@gmail.com>
Date:	Thu, 30 Jun 2016 12:41:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20160630062236.GA15380@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-30 o 08:22, Jeff King pisze:
> On Wed, Jun 29, 2016 at 12:48:33PM +0100, Laszlo Papp wrote:
> 
>> Old releases are maintained with important bug fixes or even new features
>> in our case. It sometimes means that we need to cherry-pick commits across
>> branches, like from master to a specific release branch.
>>
>> Cherry-picking changes the hash of the commit, therefore, this may no
>> longer work for cherry-picks:
>>
>> git tag --contains
>>
>> I am thinking of having something like:
>>
>> git tag --contains-follow
>>
>> which would follow cherry-picks. I am not sure how easily and/or
>> efficiently this can be implemented, but my gut feeling is that in the vast
>> majority of the cases, the content check would bail out already at the
>> "subject line".
> 
> Git generally considers commits "equivalent" based on the patch-id, whic
> his a sha1 of the diff (modulo some canonicalization).

The problem with patch based equivalence is that for cherry-picking
on old release branches you might need to modify a patch for it to
apply - and then patch-id might not detect it.

[...]
> Of course there are other ways of determining commit equivalence. You
> could find ones with duplicate commit messages, or duplicate subjects,
> or whatever. But if you have a cherry-picking workflow, I suspect the
> easiest thing may be to simply use "git cherry-pick -x", which will
> write the sha1 of the original commit into the cherry-picked commit
> message. You can then use that to correlate directly.

"git log --grep=<sha-1>" would help there (or even match the specific
message that "git cherry-pick -x" adds).

-- 
Jakub Narębski

