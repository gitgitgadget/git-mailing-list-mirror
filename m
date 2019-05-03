Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88C601F453
	for <e@80x24.org>; Fri,  3 May 2019 20:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfECU4l (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 16:56:41 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:37090 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfECU4l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 16:56:41 -0400
Received: by mail-pl1-f171.google.com with SMTP id z8so3252043pln.4
        for <git@vger.kernel.org>; Fri, 03 May 2019 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W+uqNQyyj1VByiPnvFqCX6H29p5f0TE+GS26NTKRawQ=;
        b=eSXcRCn411mSmLYlw2qavEvoYG3Yvnx2iBNZfAfVacnel3oCybqK3LvkKZREANwqKX
         zzrdVxnvbg+ckXg0+tnGvqX2Qx78FrEaRACxOPn1TtiWlCqFkzmAfWnMKoQIxh1gK8Lg
         BZ+srrax51L2Am7dd9AS7rsL6gq/D9NsvfDZD6zhEU64ma0BcxnQHoYExoi4zlEAUuG8
         QEq6pmPZ6FuLQ/aqBayVvqvBnZxwJV0vcT50A4deLQj2qizrs9U6jHWWxenxYBC764cr
         V2LyMb80rlVESILn5MgmAkeNwxG58mYhhhujdRz20we9vo458V8w4FdwarwUeqteskcP
         LRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W+uqNQyyj1VByiPnvFqCX6H29p5f0TE+GS26NTKRawQ=;
        b=rLUPUmyleW87FR+4qAO/Of0zvTJdALPeJJuGms7xdywPnCzQoCnfo6Uvg0TnmkKjlb
         5qEotwRRybzIcBBNL/qNA09MDTH7w4R/8Leig44KKQNENw+KmrV/iH0NmAaFidpBsIfS
         ZNHoe0s0el2ik8F9UM2INiKObJAus6WSN9yH0q+OSFNOVPQ2/kgC7l3GBjaAvspL9Al+
         sGNWz6clYiu5VBa1OY4UpTFhPJAyOVtwOeorusJLBEEHSF7wzzobYF1ncIqUMEvbwuNj
         WT4Fv7eyzfNfaAM3PSQMbHadotjhc2VJjTBe0A4FXSkLJje80thNE5RfRSYf63bl83Ki
         C7CA==
X-Gm-Message-State: APjAAAVlgIxExksTcl0YrVDV+LUXQ5lZmtrMeXY/Y0xnNBajQCtmrpKN
        rFriyPeiMHJkieTyaVyhgFo=
X-Google-Smtp-Source: APXvYqx+ELxIfoSvGWqtNKO00+X/7X/6D3+YfBPiiReecN2lbHnjKfaKZGK1IHCklIP+lZxEqcy12w==
X-Received: by 2002:a17:902:b181:: with SMTP id s1mr13732769plr.9.1556916999615;
        Fri, 03 May 2019 13:56:39 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id r5sm3226037pgv.52.2019.05.03.13.56.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 13:56:38 -0700 (PDT)
Date:   Fri, 3 May 2019 13:56:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: install: gitweb.cgi was not found anywhere
Message-ID: <20190503205637.GC42435@google.com>
References: <CAH8yC8kec2N0fkt6cWChOEGtGkrOE5S+QuZnQnDP1eM9mg_EOQ@mail.gmail.com>
 <20190501223005.GB42435@google.com>
 <CAH8yC8=AB1E=U7vCTkOLELQ9z1vW2up_WCYziW25Uqe0jXZBaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH8yC8=AB1E=U7vCTkOLELQ9z1vW2up_WCYziW25Uqe0jXZBaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton wrote:
> On Wed, May 1, 2019 at 6:30 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Sounds like it's using "install" when it should be using "ginstall".
>> config.mak.uname contains, under the SunOS category:
>>
>>         INSTALL = /usr/ucb/install
>
> Thanks again Jonathan.
>
> /usr/ucb/install no longer exists in Solaris 11.3 i86pc:
>
>     solaris3:~$ ls -Al /usr/ucb/install
>     /usr/ucb/install: No such file or directory
>     solaris3:~$ uname -a
>     SunOS solaris3. 5.11 11.3 i86pc i386 i86pc
>
> The config files need to be patched:
[...]
> Related to /usr/ucb, also see
> https://blogs.oracle.com/solaris/preparing-for-the-upcoming-removal-of-ucb-utilities-from-the-next-version-of-solaris-v2

Hm.  How about this, in combination with the previous one?

If it looks good, I can send it out as a series for real.

[...]
> I also removed a bunch of old patches and hacks that don't seem to be
> needed for Git 2.21.0. Between both of them I am building Git on
> Solaris again.

To be clear, does that mean you are using unpatched source now, or
that you still needed some patches?  In the latter case, can you point
me to them so we can get something sufficient upstream?

Thanks,
Jonathan

diff --git i/config.mak.uname w/config.mak.uname
index d916d1dc7a..41ad90c76a 100644
--- i/config.mak.uname
+++ w/config.mak.uname
@@ -162,7 +162,7 @@ ifeq ($(uname_S),SunOS)
 		NO_STRTOUMAX = YesPlease
 		GIT_TEST_CMP = cmp
 	endif
-	INSTALL = /usr/ucb/install
+	INSTALL = ginstall
 	TAR = gtar
 	BASIC_CFLAGS += -D__EXTENSIONS__ -D__sun__
 endif
