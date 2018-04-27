Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66A3D1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 17:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758941AbeD0RZK (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 13:25:10 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:46440 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758271AbeD0RZI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 13:25:08 -0400
Received: by mail-io0-f175.google.com with SMTP id f21-v6so3288141iob.13
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=u3mBAzEp/28NIxRe1NljZf1482PYzu6jLKUhq2Akk2c=;
        b=ERcNnJnWUkxmfCxPUfL/ANvRlBsNwy/brVYzV27aEVIHyWX3wIqKAW2IXlv1sVqpua
         m6sd831acghHqcksXwRNxNPTTlN8bwbUiPUOooB6SsdKh02lqQ41pMTBKGX3tiW3B/lr
         PcnDn8q/GDjSUKPMT6ySLrsWkHZg+aKfG/iYsfEnA0XCchGZtZUU7IKkxguZlkDLM7TJ
         OXUJkt9v5GAQrqOOj1VwgN0UdNce1k/sN3dH2BXx2FT9hbJxVOMozoi0ydrI26g6aPov
         DFPltAfCUqqwhvtKeC9WSvQmJjY9J3MFLl18rZptPZnQuvHTyqIaOvnDgIlyUBSZqAjH
         Pn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=u3mBAzEp/28NIxRe1NljZf1482PYzu6jLKUhq2Akk2c=;
        b=IOb/JjDanAnHMlxehl7odybLKac+Dm7+vOE5A/p3aMWSmuTAPVRXllFWszUmow5wQz
         YhuSf61Xs0ZGVyowy1Vj9aI/4jLiIp1FLbruNkkOj1ilAVF0+eJoQ8o/vwIKCMn5m5TM
         Fm7vAvtFMeN6H3hSZWnBP9W4iWpjQROhuGNO8nSmCVEceRZ0yOLX5fFDfsFaZlvieF56
         EZq25N2+RIL5AHcayymJcSk3JgpOyIBWZrqX5fME5HqEjv17dmBUu7/mi6WslDC0e6uo
         ACLxZhOkJoAUD2Mj0YF+C54ixpOa/68pGXTz+A1CYHkUiD866ZuGgk5b1IcJ3VkS15PV
         DAZw==
X-Gm-Message-State: ALQs6tB0tfWL4ZZ+Ae4oNx8hbbgAiQUIrgKcOOPwU3mQmuFIv9Bkcj2d
        /g8ffGOLHKYichfAK1grILfhXJmNLqpCdq5sZviZr30+
X-Google-Smtp-Source: AB8JxZpnRedrisGu9uuDDvXHTNL7ZX5HNmLUVBBCPId2SPjx1ES0Mf+r8QrD9NF2q0QT81vhHkHYRqRRdF6h+xVJ1Ps=
X-Received: by 2002:a6b:ad44:: with SMTP id w65-v6mr3094585ioe.211.1524849907516;
 Fri, 27 Apr 2018 10:25:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:cbcb:0:0:0:0:0 with HTTP; Fri, 27 Apr 2018 10:24:26
 -0700 (PDT)
From:   kelly elton <its.the.doc@gmail.com>
Date:   Fri, 27 Apr 2018 12:24:26 -0500
Message-ID: <CALVfKe9K+qoDNXf1PbnvXWdYn-Vtv8xUJF-1PctC8uN1p4gyiA@mail.gmail.com>
Subject: Missing --relative documentation
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git format-patch is missing documentation for --relative.
There is also no auto complete(or tab complete, whatever it's called)
for the --relative switch/argument.

https://stackoverflow.com/a/16309416/222054

Thanks,
Kelly Elton
http://www.kellyelton.com
