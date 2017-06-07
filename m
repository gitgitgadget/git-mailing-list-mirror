Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51D91FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 12:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbdFGM44 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 08:56:56 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35638 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdFGM4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 08:56:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so1445332pgc.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pnOOzTxi6gNbCBI9Qj4rJgW9Zy3N7Tc8Nxhxv6kg2a0=;
        b=XsN0eAEjFxfb3rd9l1dOhKIJE2OJ1+BXfUgl9aA0nVnr5H7p0QcL6FQ2hDWzUXZrfg
         yPXMABHLsNSOEl3WrPx+yPc6rykFIe+zJetyzZ5fYd69cix0Nr7YPLNqjAGdTc5JgnW3
         VmFy56gZo72mFUv6zzsSwYyGe3jFokQedZdQcYYmZGmHbzO5D3PxYVjzxvmQg6OT9WE4
         mDfrJXWPmSqJyWI0SIJ1zIl84a8b/ozPgtSbxCeZqqJLSDVjvTtfc1JLVng4ZHZFQ67w
         QJp+Tu+8PDWjLlAsNw3z4feLRrF5buCME1dzXAixpTa3xh09wYr+N3hAljuz/sHDtfuc
         eQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pnOOzTxi6gNbCBI9Qj4rJgW9Zy3N7Tc8Nxhxv6kg2a0=;
        b=bXIKMdXwtaBNc/yk3v3NyCYd8FK/CD0xS0m6ZIbNLSC2+1bZKSspI+u3Z5PChkeDt2
         suCYMP9S3zK+z7+pNUCzvXc1e7oeqqQjtkh4ZLydwZBIEHwRC75lqsy+UlO/N9Yyth1c
         OBHwnoCrrMbUFYaF68PGnPamM5CvQ3LFzrIMJQWG3KMRiAxIQI9Q0AzpijX1VB1nA9TS
         4ERK05YGps21mdsl9YaC1l0nKJQrp/MZEcOAiCbTmufqjP9Lw1dZYlQHYP7OKRwbTib2
         O6M8/27Nzrbysa3KXybW1G1SSkdDuDsCM5ve9415ojO33L542SESkWZF7/pByx7PdAQ2
         U84w==
X-Gm-Message-State: AODbwcB0R9aRO9GeZa5RrEdv7N2ZY44Mg1z5By3L5QxZpOUCpo9Z2KRd
        57KpQMMUWMxbG6XSTb+e/A==
X-Received: by 10.99.141.200 with SMTP id z191mr20040191pgd.99.1496840214684;
        Wed, 07 Jun 2017 05:56:54 -0700 (PDT)
Received: from [10.4.2.238] ([182.73.79.179])
        by smtp.gmail.com with ESMTPSA id m5sm5124870pgd.28.2017.06.07.05.56.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Jun 2017 05:56:54 -0700 (PDT)
Subject: Re: What does this output of git supposed to mean ?
To:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     David <bouncingcats@gmail.com>, Samuel Lijin <sxlijin@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <1496671452.4809.2.camel@gmail.com>
 <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
 <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>
 <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com>
 <20170606011151.qe5ycih77vqlqgme@genre.crustytoothpaste.net>
 <CAJZjrdWoK__rZVCG3vRSSEOPgxK7b_wWjpJ3YUQcLxw+J8KfGQ@mail.gmail.com>
 <xmqqvao9991r.fsf@gitster.mtv.corp.google.com>
 <CAMPXz=oorE7MQa4a_1eC-+Huf1Tf2XQFjEBcQxsOdso9BJ1S-A@mail.gmail.com>
 <D0E8FF50F1E74043AA0BD71E80C365E5@PhilipOakley>
 <xmqqr2yx8h9v.fsf@gitster.mtv.corp.google.com>
 <1496758102.6664.2.camel@gmail.com>
 <4A4DB115A50D432A8FF7B8589C5BAC84@PhilipOakley>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <2d7e165d-b44c-ab3c-a4db-af5df64048a9@gmail.com>
Date:   Wed, 7 Jun 2017 18:26:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <4A4DB115A50D432A8FF7B8589C5BAC84@PhilipOakley>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 07 June 2017 03:35 AM, Philip Oakley wrote:
> Maybe have a try at a patch to update the text? See the 
> git/Documentation/SubmittingPatches for guidance.
I guess this should be trivial (correct me if I'm wrong). I'll try when 
I find time. In case I make the change which of the following message 
should replace the message 'Initial commit' ? (this could be a poll, I 
guess)

1. No commit yet
2. Waiting for initial commit
3. Your current branch does not have any commits

Further what is to be done about the following comment,

On Wednesday 07 June 2017 12:23 AM, Jeff King wrote:

There is a slight complication, though. There's similar text in "git 
status -sb", which shows: ## Initial commit on master Should that also 
change to use consistent terminology? If so, we need a phrasing short 
phrasing that matches (and the --porcelain and --porcelain=v2 formats of 
course would need to remain the same).

BTW, could anyone provide a pointer to the implementation that prints 
this message ?

--
Regards,
Kaartic Sivaraam
