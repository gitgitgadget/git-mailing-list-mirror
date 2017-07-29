Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373022089D
	for <e@80x24.org>; Sat, 29 Jul 2017 02:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbdG2C5a (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 22:57:30 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:36885 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbdG2C53 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 22:57:29 -0400
Received: by mail-pg0-f53.google.com with SMTP id y129so117552530pgy.4
        for <git@vger.kernel.org>; Fri, 28 Jul 2017 19:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=661qe+FEqv2jfO8nZcPjWPw4OEw4swcxa4KmG54ZltA=;
        b=RpHGYhz06AbMAbxgmIhj+GyN3pJ/70y4L8GPPWr9c0qpUmbBPVL3BU/hcfE3y7yb5a
         Grne0H5zuWei+reGRJbZ1iCVZ4VodjrLpSeCBb+jn0atXXxiZ8C8qrdWJnDGpVGvfJXb
         /wu6Knnuq7Fz2H2k+5tVBbNlRQcyVclAbf8pFLzqHjtK5nR2USv+gT0v40yDVUbdEmd+
         pUEJpMW+r6oHpOhrEpYEXo4+wQjbSYRbPOvI4o781BMxJggURAzAi7M34/Hud2wlU0ro
         tC6PYXfYlY3FAiG8ALU2nJKMH8aS0719Hcspzj3w2ayl0KHQb3iHugJe/dERzyPHVSjc
         Lj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:mime-version
         :content-transfer-encoding;
        bh=661qe+FEqv2jfO8nZcPjWPw4OEw4swcxa4KmG54ZltA=;
        b=gup3uj3JxzbRVpwU0bUXfJAaBvqKW/6+LIM4MvMWlmTEQHRsYq/ffXt1vOMVjLpCFP
         HDFzcQtiX0U5NdP0xGyLeG9AlfRWXy2sQWOnD5Y7ULPuila3w0AVa3nfrGMozmAcy1nB
         Skan8j+oSjx+4oyMdEcDvP09PmRL42gNI9GVm/6BD/LVsFJw+twiq9Q0IlExVf7429oG
         8s1x5KmFhRb69UAvkaijgU0YSVePM16NWqwggdSRsWONr0+uAWKBzhitPZmHKq/2V9Fh
         VZv8PIXnSUB/aoU4e+EnZc5RfDtrYmfuKYKpJR8TXTf7DgDJd9PVbkDtFZXbE7RwrxoX
         IFQQ==
X-Gm-Message-State: AIVw111veC2Tofjl0hV4fuZCJ+9/HObDxMX1A+ZKGbpaLFC4BcKnHFjZ
        i1OGrlf6D1mNCyzFk4A=
X-Received: by 10.98.137.202 with SMTP id n71mr9028423pfk.243.1501297048339;
        Fri, 28 Jul 2017 19:57:28 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id m18sm39798183pfe.126.2017.07.28.19.57.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Jul 2017 19:57:27 -0700 (PDT)
Message-ID: <1501297078.2711.2.camel@gmail.com>
Subject: Guidlines for error messages
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Sat, 29 Jul 2017 08:27:58 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all,

On reading the CodingGuidelines, I saw a section that specifies rules
about the structure and formatting of error messages. I have reproduced
it below,


    Error Messages

     - Do not end error messages with a full stop.

     - Do not capitalize ("unable to open %s", not "Unable to open %s")

     - Say what the error is first ("cannot open %s", not "%s: cannot open")


Having used git all these days, I have seen error messages that do seem
to be violating the above guidelines (at least the first 2 points). A
few are,


    Aborting commit due to empty commit message.


    fatal: There is no merge to abort (MERGE_HEAD missing).


    fatal: You have not concluded your merge (MERGE_HEAD exists).
    Please, commit your changes before you merge.


    error: Empty commit message.
    Not committing merge; use 'git commit' to complete the merge.


    error: pathspec 'hell' did not match any file(s) known to git.


    fatal: Not a valid object name foo


    fatal: ambiguous argument 'foo..bar': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'


A few that do seem to be following the guideline are

    fatal: could not read log file 'imaginary_file': No such file or directory

    fatal: no input file given for in-place editing



    That makes me wonder, has the guideline changed ?
    Is this something that must be fixed ?
    Am I missing something ?

    -- 
    Kaartic
