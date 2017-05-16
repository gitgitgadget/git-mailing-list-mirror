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
	by dcvr.yhbt.net (Postfix) with ESMTP id CF6FD201A4
	for <e@80x24.org>; Tue, 16 May 2017 18:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdEPS0L (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 14:26:11 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34761 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdEPS0K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 14:26:10 -0400
Received: by mail-qk0-f178.google.com with SMTP id k74so137744405qke.1
        for <git@vger.kernel.org>; Tue, 16 May 2017 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=WUSu4KQJuqmWVy29O2R1muKCgMvyN6oJMu8PNbpAJBg=;
        b=XreaGKnyFiLFN7Xm24KdPPQ+vxGTVDiNDlo1yewUo7ufHSmg16BiZ+muZpilzYHVp6
         tt0oOLIVafQ4tzFLqFFBc1ZvJJD5w95n3LrHiPdxJXTZVg+v7EWJEbsugNx2evkXzRUG
         9mb9dwFx2COMRQJ6jzpoSFifB7zLvO4JwLo1lVxaAoUVnfkOW5pwsClPdjnRcv8dc2SE
         v5vqkocXyjUd39rH8WjrnUUYfze1n9Tm90hwPVHnAEMHXM6gRCdq8x4KAhsyT8BVuqXB
         2kHaHmooT6rycjfxXu/fm7UDDoF052zfnurJDFARTApQMxWw+AZNDqvP8vIe3r03bWR8
         nQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=WUSu4KQJuqmWVy29O2R1muKCgMvyN6oJMu8PNbpAJBg=;
        b=Jw4QyLxuPdFkNt2C+618D+ciMVQeJyxgyOzmGoHASb2PqfdHo6PObrt9z0t8BQtjMy
         8RuuZw33SNSrGw0pGFGE1PTMDjKOzd1vu5utVMWuyPE2NSFuGeB9ostiSTeEWHxwepku
         L4EUyt1yI3GaiNrS6jAuN3KhnN7R6eTTGkAk2nH0DK14Ixq/W4q5a4ja3PqXemj3V9cn
         vNp3btI2vJ8rhDg5Q5O0b6E0b4gj3YyXpm7iD5JyQmJ0FdK84Q0XfN+LpzwwBtpHfAST
         C/H26d1hVzN/9jjCp5JeGhcnTH+3yP/ytTWgPnRQBHSxrCu3hr9Urh4/03+oU7NrNRUN
         bQmA==
X-Gm-Message-State: AODbwcCh5dYcZE8rDQvLub6LpD0LeKl+EVeMUPjEcFUEVg6jJ/IMH37p
        +R+5HOFQzuUaKvTXZFQ=
X-Received: by 10.55.200.218 with SMTP id t87mr12463090qkl.261.1494959168995;
        Tue, 16 May 2017 11:26:08 -0700 (PDT)
Received: from Matthews-MacBook-Pro.local (146-115-162-193.c3-0.wth-ubr1.sbo-wth.ma.cable.rcn.com. [146.115.162.193])
        by smtp.gmail.com with ESMTPSA id n35sm8263qtc.55.2017.05.16.11.26.08
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 May 2017 11:26:08 -0700 (PDT)
To:     git@vger.kernel.org
From:   Matthew Groth <mgroth49@gmail.com>
Subject: error using `git mergetool --tool=meld`
Message-ID: <83801c20-96e6-7f9c-1e0e-2d46e32dc5f6@gmail.com>
Date:   Tue, 16 May 2017 14:26:07 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using `git mergetool --tool=kdiff3`, it works fine. But with `git 
mergetool --tool=meld` I get this for every merge conflict:

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

This is my first post to the mailing list, sorry if the bug report is 
missing anything.

