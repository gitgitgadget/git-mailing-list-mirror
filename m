Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2A0D1F576
	for <e@80x24.org>; Fri, 16 Feb 2018 09:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932472AbeBPJrp (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 04:47:45 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:41751 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbeBPJrn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 04:47:43 -0500
Received: by mail-io0-f176.google.com with SMTP id e4so3566893iob.8
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 01:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=8C/20WfZZQhx3+KOHofqDVaD7tnMzcL1lm/m7pbunDY=;
        b=I+5QaNx7OryGkEU7vmESKog10TBlbl3wrfuj4sCHtXbUhoSVTxdsJrKUpoIChgpSrY
         gAkiF5qWCWl/NOzAjN2acEn5Z4rtSFADFa1J4eR8RTuTKfMo/InNbgkIlD/oR8ApxVr/
         8gRo3f4JnCoT6Ju1WaDmiaaAZlGUqt0X/fF108sziw5vMe+GvmgpXIBjSvNexjCqQweG
         J5Zlfss+0xvPuCLX9GWapNNWkRdMgJkHWY0WJGvsmQT714tP7wa5WeBUwOuyUquvvtND
         Vs3rqziYBY0tno6783pn1HRtVaYEwV+mVO2gGOVKa9y830rXeM8JLlfF2upxrKfLufG+
         M+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8C/20WfZZQhx3+KOHofqDVaD7tnMzcL1lm/m7pbunDY=;
        b=ha0vVZj0DfjF2JMmp3MVqWond5LOjqtFNniJFZXCmddorPnD076xSk2qCJMJNXvIcG
         o3RFcj6dLrZvhrj2Mb1bm6LwDQB6c6NYNy07nYotxXNkz9WKrDjOmmrFXWxmGoANx5gj
         3o6z1mjRn8WM78IljJCOGNVsQWSfbj/nr6XuIecmBK+/1SyvviGcq5rN9NVfJbXWRAuT
         mugHS7P0Q/ekjV3IcolIe5d02Odj8AAughSRViW0gliJ6VfVWvUmXz1S5fhL7l2BR7KD
         4WpBHqxXCYxea2UuxAgBBLgQOPctJ7pvybISb/ZYEpeAziltVcRF5LwFZOfb3uTnvQPT
         itdw==
X-Gm-Message-State: APf1xPBD9e6s3Lwkhv4SpVUl8nh2592U/1ks/NQiEk1oE/HcuNomo+rm
        jOik7rafuaF2DgJPebRCZaQwNeUGZ0cnYvtNFi+Dog==
X-Google-Smtp-Source: AH8x225j+la38aByMS/asEdgmJbbzmxkli7nplZnVpOkd/iaFxMx0L/dX+IaQauBLLIiuSQ/SQx7QApcZ1LAdTJ/3Xw=
X-Received: by 10.107.101.13 with SMTP id z13mr7060059iob.141.1518774462523;
 Fri, 16 Feb 2018 01:47:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.30.82 with HTTP; Fri, 16 Feb 2018 01:47:41 -0800 (PST)
From:   hgfds jhgfds <lvl100p@gmail.com>
Date:   Fri, 16 Feb 2018 17:47:41 +0800
Message-ID: <CAOrVMvvM4XUsE0v7oxotD8yPHkmstG-mQYuhF0OsC-bETGQ-Og@mail.gmail.com>
Subject: Is the -w option for git blame bugged?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I recently asked a question on stackoverflow regarding what seemed to
be erroneous output from git blame when the -w option is specified.
However, no one answered my question, so I decided to ask here
instead.

The question is available at
https://stackoverflow.com/questions/48808281/git-blame-ignore-whitespace-option-bugged

Hope someone can help to shed light on this issue soon.

Thanks!
