Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08EFC1F858
	for <e@80x24.org>; Mon, 14 Nov 2016 15:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933131AbcKNP7p (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 10:59:45 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37127 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933116AbcKNP7o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 10:59:44 -0500
Received: by mail-wm0-f44.google.com with SMTP id t79so106381124wmt.0
        for <git@vger.kernel.org>; Mon, 14 Nov 2016 07:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=39jmKu6GUdh/mDIht0wKxECahtFU5neJ2CHysuTIT/U=;
        b=UXbgg9gAxdd46HNAI47qHBO9oo72A//xHq6CZopaMstqeTjbvuwgWJQD03V68wsRSP
         DBKaG5km93pDtZuH6vARKrf1gdbXv2iLyghO9uOeCA3+DOqplABw0gH2adIo4jKwUJIm
         6pDev/l0BwO4YLoGcqaA3klGJRg3l4Wj5T9+t1TsoZslcVjK3HKN1376F15/G+G/D9xP
         JTQvpK5ti27W/IgXhl1kWx7vY7vEJDqevWvlHYT1jKIPNX31m0JhBUewYTLpN7F+JXO9
         Ji3ibV6CZGakTotRqhqHt9M0QisOowFy9mZ+RBk0Pm3hxGCRsZx9r+Ze5DSQo/h6stQL
         tPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=39jmKu6GUdh/mDIht0wKxECahtFU5neJ2CHysuTIT/U=;
        b=aYzjmYEAHifbHWAyuvR+sFvvPrqvDAHHtosync317UV0dH+GITAhamIlf8D6qKD/oF
         oT3NzXBJ7oOqhWEDCC3vuGkaKgKs263yZvjL/E/BlP1Ov2y83NhofLIe0G/HYNUpJckK
         ckCdVXTW7KWjHdyCbICEmBX7dUR1O+dVXvc/0MtJNngr/niaTAminmYIBubWCPlCB8TF
         P6LvW43feTEa397YZnzPZGJCQ736j1NJOGzhkRKXzqydAx+hSHFbZjDQXt4Z/YD+ZRMa
         TMuEhyomISmNT3t5c+6MM11JxAm4dF6D2b5XTqfDcm+klSsmgFM1kAVGNmhNgdAHsQQf
         MECg==
X-Gm-Message-State: ABUngvcpYoenVqK84gRkwQAcb+r+sCcOFduFmacq3iDsCn/vuRsTLqEA6YeqZjFjkNFL+Q==
X-Received: by 10.194.22.41 with SMTP id a9mr8905573wjf.30.1479139182347;
        Mon, 14 Nov 2016 07:59:42 -0800 (PST)
Received: from ?IPv6:2001:4ca0:0:f223:9d26:9826:691b:27a5? ([2001:4ca0:0:f223:9d26:9826:691b:27a5])
        by smtp.gmail.com with ESMTPSA id v10sm29442598wji.29.2016.11.14.07.59.41
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Nov 2016 07:59:41 -0800 (PST)
To:     git@vger.kernel.org
From:   Robert Fellendorf <robert.fellendorf@googlemail.com>
Subject: GIT Problem/ISSUE
Message-ID: <a3751faa-91b5-2ce8-767a-a25e25f23433@googlemail.com>
Date:   Mon, 14 Nov 2016 16:59:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Team,


I'm having some trouble with my git software. I just would like to 
'pull' a project out of a repository.

At the beginning git worked just fine but since a few days ago I'm 
constantly getting the error:

Couldn't resolve host 'gitlab.lrz.de'

git did not exit cleanly (exit code 128) (391 ms @ 14.11.2016 16:53:37)


To my architecture: I'm having a Windows 10 Pro Version with the Intel 
U6600 processor.

I have Kaspersky running (But, indeed, I also tried it to shut this 
software down while testing git - additionally I killed all tasks which 
could considered to be a firewall)

Furthermore, I tried to use the ssh protocoll which did'nt worked out, 
as well.

I added a ssh key changed the environment variable. Didn't worked as well.

I have a direct link to the internet (in particular I'm not accessing 
the internet via a proxy)


A reinstallation of the software did't helped neither.


For your help I would like to thank you already in advance.


Kind Regards

Robert Fellendorf

