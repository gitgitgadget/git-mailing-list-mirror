Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2336209B4
	for <e@80x24.org>; Mon, 10 Oct 2016 21:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbcJJVA7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 17:00:59 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35186 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbcJJVA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 17:00:58 -0400
Received: by mail-oi0-f45.google.com with SMTP id d132so1852854oib.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 14:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=EBemUPprt3Bsmq4mynZ88vma9kRtXPjjdAuQ6jL2X4w=;
        b=cCxYNmxbnqTK/2bxIKn3sxBmIig2sc7eHji3LVz4Gasc8dwOQzWTUwHSPfBctitMS7
         sifFQ/3joHVOdJYqUlS/y0ABqh1CgQY/vYBchc/WPk6wXf+2vMmufc4msztnE6hLj5Wh
         XgNGvy+kilCktq7WjBxSIAXmVXh03L1kqI4JYUaQMI7q+ZXmBdwyDxPjhc3OquEtiP1S
         xCqtNyu9l3iFXE6atuHtHurQT/ccuoEiW6PBGFaiBVKQGHyXBkeNRXdqodnPp7n9WkWE
         mhuVVr7dr8AUO9TJniVFWyCWLQHfou6q5a+4oWBdFQs4XH3N5ihexZm2Sqe1XpSEhu4O
         WZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=EBemUPprt3Bsmq4mynZ88vma9kRtXPjjdAuQ6jL2X4w=;
        b=mrXpyS9NAAyLn99NWCQBSEgXOQt2qOWUs8JYuz4Mrl2pkwkCrvdd7bG/46cSVaOLSE
         rtje+DUdj5y/XOCz9RWzU5Zyr/nCkZsFdhlgQnhxHc6ybsSzHj+FDfcZ8I2ogm/Xqjyr
         0/Y/Vqp2Ro6RlSoJrtJb4VhR4fiOdNDuhX0HtEBYXGj6W+HkRK3CmX3c/KpCbqF4Y61K
         blPg6T7/BrqaMsibF6acbyIa/RNAN0grN+4jjAcjKV6e6G2r8Jv8G6avSZ3OXeqA28g3
         jml6P/0AwI4omKKZFi0AHvpfNnLcVrKg8ogZbxRcgpgWf7qwassPejMk9o8Z2FYb+642
         9ZAQ==
X-Gm-Message-State: AA6/9Rmz00pgBFN7WoilzCGw1/6Hacp6YxGDApsaAubEbycDx4C1FFVFk2Ijja1cPbzUvA==
X-Received: by 10.157.16.81 with SMTP id o17mr95523oto.207.1476133257770;
        Mon, 10 Oct 2016 14:00:57 -0700 (PDT)
Received: from larrylap.suse (cpe-24-31-249-175.kc.res.rr.com. [24.31.249.175])
        by smtp.gmail.com with ESMTPSA id f38sm11456258ote.26.2016.10.10.14.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Oct 2016 14:00:56 -0700 (PDT)
To:     git@vger.kernel.org
From:   Larry Finger <Larry.Finger@lwfinger.net>
Subject: Formatting problem send_mail in version 2.10.0
Message-ID: <41164484-309b-bfff-ddbb-55153495d41a@lwfinger.net>
Date:   Mon, 10 Oct 2016 16:00:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have recently switched to openSUSE Leap 42.2 and found that some of the 
features of send_mail no longer work. The problem occurs when trying to add 
information to a Cc to Stable.

The initial pass through the patch produces the output
(body) Adding cc: Stable <stable@vger.kernel.org> [4.8+] from line 'Cc: Stable 
<stable@vger.kernel.org> [4.8+]'

That is correct, but the actual Cc list contains
         Stable <stable@vger.kernel.org[4.8+]>,

The mangled address is not legal and the mail attempt fails.

Thanks,

Larry
