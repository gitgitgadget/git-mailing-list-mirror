Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2C121FAA8
	for <e@80x24.org>; Tue, 16 May 2017 21:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbdEPVMY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 17:12:24 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34794 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752750AbdEPVMV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 17:12:21 -0400
Received: by mail-qt0-f173.google.com with SMTP id c13so77367075qtc.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 14:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=0MLr0a6e/0Kt6stJQnvr49/S/PKkZF+0w4fAWDAY1Y8=;
        b=BkCkuJWPLLhoFOi1Lo2eK8scV9eDgW6WUmV09NOrbzwubIkSrGf4eKNTSuqeoNViBO
         KkhI68N0Gqw5Irg7ZPB5zmi8YaQ6dkKNl7mlgpPtNngRo/jAjQ8ATLOk60edSBlDNnJ2
         oTnRSbaqGTSnwQePHdwpvsB6cEzr/BVtbjKCf4YfCXZulH45g1herNkg8U4Nb5LNqvN8
         s8LDUXiHEbljYghbW4WZ/F1SY4qgjEN/GeMu0YWxs24vrcMXI2tk1dWyut+G7VvFZgiM
         hx8pP7OD1fTifwixXPgqza37Lg5AhX8YMv0Li2szv1AqYTUhw9EUKHpywEm0b2MOBXcG
         /IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=0MLr0a6e/0Kt6stJQnvr49/S/PKkZF+0w4fAWDAY1Y8=;
        b=kYYh9SQU4XKUOpItw2VV3LDpVfQGMCPhihgqKnTprnXnMOjExmyPyWqKQ+buPOSgsl
         lbOXYFd5z06OgitwQjG929ikryPg2yuN88ld0RAjkc58/u4GiJDlNRS1MI5+q6E4om3V
         rgO7FBw9CC4/wKYnS/aG1LI77m/yxPU8ClzW944GTXke6XHDY/g0lVMx3bJiyWmyQJVA
         tjiXtDpX1bfOoTpKfqBwYFvjrCo56Y0f1O65t+9FK+RRq0fh+fTF6eQand8174cOjbu8
         Mp2t2mVoZWkX1EGsboK6Hp7AixKvvA/xrvifH/Dt5OS3huEKND1Eig8Vy8g1xiyMV/O2
         0ySg==
X-Gm-Message-State: AODbwcDxGGBBQStg0H6Qda5SRfB7tNx8i5u2MJG0xT2xb2fcGOD0/Mch
        2SwsyzH7MOMRft0R0pw=
X-Received: by 10.200.54.199 with SMTP id b7mr13094607qtc.145.1494969140948;
        Tue, 16 May 2017 14:12:20 -0700 (PDT)
Received: from Matthews-MacBook-Pro.local (146-115-162-193.c3-0.wth-ubr1.sbo-wth.ma.cable.rcn.com. [146.115.162.193])
        by smtp.gmail.com with ESMTPSA id k36sm292314qte.65.2017.05.16.14.12.19
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 14:12:20 -0700 (PDT)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Matthew Groth <mgroth49@gmail.com>
Subject: Re: error using `git mergetool --tool=meld`
Message-ID: <68c4da38-2f3a-1b46-c2e8-3fa1c1170e6d@gmail.com>
Date:   Tue, 16 May 2017 17:12:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I tried `git config mergetool.meld.hasOutput true` followed again by 
`git mergetool --tool=meld` and got the same error.

My original message:

         When using `git mergetool --tool=kdiff3`, it works fine. But 
with `git mergetool --tool=meld` I get this for every merge conflict:

         ```
         Normal merge conflict for 'builders/pdfBuilder.py':
           {local}: created file
           {remote}: created file
         Traceback (most recent call last):
           File "/usr/local/bin/meld", line 20, in <module>
             filename = arg.split('=')[1]
         IndexError: list index out of range
         builders/pdfBuilder.py seems unchanged.
         ```

         And the contents of /usr/local/bin/meld are:

         arglist = []
         for arg in sys.argv[1:]:
             if arg.startswith('--output'):
                 filename = arg.split('=')[1] ##### <<--------- line 20
                 newArg = '--output=' + fix_abspath(filename)
             elif arg.startswith('-'):
                 newArg = arg
             else:
                 newArg = fix_abspath(arg)
             arglist.append(newArg)

         I'm on OSX: 10.12.4

         git --version
         git version 2.12.2
