Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2AC71FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 21:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbcHQVzY (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 17:55:24 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35964 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753474AbcHQVzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 17:55:22 -0400
Received: by mail-pf0-f179.google.com with SMTP id h186so240931pfg.3
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 14:54:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tobiah-org.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=WZAEaObubrb/FF393y0ZI4kLqRAE8LvXVDKHajlfYiA=;
        b=fuwKgVDZwddXTydxv0Gm/2wJdmWm97MfJQWnPsEDRYpLJ2PGLUye6z+/CWP+SL8E76
         xxAunlr/fltzpmUCks4uL/9aFdXwiNcX+gi21QN02/8j87gJH/hZSf3LPF++9YbMIh/E
         a9oiyOH+8PQmzoDdcpNtelnq72d1l5qSBII0EAmnwfXRH0GdAE/5yZo2mqsWQK3HhhJU
         5JiM6RjH+pmSGT+xhLVi536dCPTq7MRVAz18ppIl9dAEG1D1G52eTNTaFA4Ps/2SX4TD
         kVzAT74pnd2M5pq2MGmyrjIekMstCXf9Hm1/OjY6qC5MBuDAihSY/ttxjFwjP4ykpIhv
         eJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=WZAEaObubrb/FF393y0ZI4kLqRAE8LvXVDKHajlfYiA=;
        b=Ye7hdJ3/EGM5i0NtJirZ6+fPK+aTHAoZbumaC1qMImhh/HG3k0STmXBpdrSmRaZ0fN
         lu5Y+HP4fhlANfcn6nKgSZ7gxvedBMrNfkElWcuv/5Rl0HycY8BSp/70paduDl9/QD+g
         dQocJb/6/qdAIYwlfOBK5ODjoGjAKb/m/ZpbLrIcAa88tHJX0d1QgN7vhbvEgMWH8/30
         jptRrro0Wemrca0GqXTwG4/PJOz393b87MfPxQ8c2CL6yOMVaBvO2sqoJY1RrUV421+D
         AvUdAAykaALqWe2cRRD4GE5BdISZhDQ21wYU4h/ThkTKdsu0FylR9R4M0eqDl/DarMnP
         TQ6g==
X-Gm-Message-State: AEkoouu+tMiqqdF+s2SLMMx3JPGQqe/31ROpjcsbAnXob/o427zRUdX+uq8OXd0x2+/Zig==
X-Received: by 10.98.100.67 with SMTP id y64mr78605402pfb.84.1471470467745;
        Wed, 17 Aug 2016 14:47:47 -0700 (PDT)
Received: from [10.10.10.25] (72-165-89-133.dia.static.qwest.net. [72.165.89.133])
        by smtp.googlemail.com with ESMTPSA id bx9sm972246pab.17.2016.08.17.14.47.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Aug 2016 14:47:46 -0700 (PDT)
To:	git@vger.kernel.org
From:	Tobiah <toby@tobiah.org>
Subject: Working from different machines.
Message-ID: <71d05705-792f-8bb9-026b-5b9251b104b9@tobiah.org>
Date:	Wed, 17 Aug 2016 14:47:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Right now I have a server at work where I keep a bare repository as
a source and backup for projects.  So I clone a project from there
to my desktop, and work, making a few branches as I try out ideas
for new features.

Then I go home, and I want to work as though I was sitting at my
desktop.  If I clone the committed work, I don't get all my branches.
How can I work so that I now easily have all my branches, then after
I work at home, when I go back to my desktop, the branches now reflect
whatever state I last left them in?

In other words, I want to work from different machines, and always
sit down to the environment exactly as I last left it.

Thanks!



