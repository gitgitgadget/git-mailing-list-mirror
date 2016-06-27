Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2774B1F744
	for <e@80x24.org>; Mon, 27 Jun 2016 07:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbcF0HUS (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 03:20:18 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36418 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbcF0HUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 03:20:16 -0400
Received: by mail-pf0-f196.google.com with SMTP id i123so15080096pfg.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 00:20:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wDR2bRnQU/B9iLFkWIRDCWmk648a4BzGD7Ic+GF7+wE=;
        b=A3xoRB1Bp9u781XpPR8JBej+pFruKl7t2FavKkps29OX+y889T8JMtpgkoohYnXOV7
         WoJ9Nc3epz5loQCCVajO70jPGV1pTk+/JuMJnll+Y9hDCNl7Ylq54ViirR2g9Jp1WTg9
         O+ul0U6PtIQMfV9YfesnrfpWaJIjDRr4adPAnpF3KpQOTIYflrT5L8775b0edo/G4R+f
         4dHxKyAMU//1/zauX4MMzX4hdrwXJ0JLeMyT9SyqqlWdiLkr40wsmy82bJ2nCaD42Q+X
         +0p7CFXNzpWIatOkqhHsOlkOMenL5qF0uCyNQ9AeXEptPLqN42bKbQDeny1doJHiGy9T
         65jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wDR2bRnQU/B9iLFkWIRDCWmk648a4BzGD7Ic+GF7+wE=;
        b=LB7eBLvMgPmmmAiEuBX68sHfIm15FhlWavZevD7USaCaiZr+LcFRGWDTN8vwkIq40K
         JYAnQf0ZG1Wke9Qer2KwoXHc6+qANY+PJrtQfnP4XXVUx63U25fj1xSYG5e7gj0yOVmj
         YkCORquALLIivFnaKeKDS2zZI8oh9AAnCqmVN58VddkP3m33ivdWVMV8Yado0RAltvYy
         bVeWMuAva09G24xl+szbIu+G93krE7f7cj2qMwv5SUWXE6FQ6ViqpLgySOFwMi1xKiu4
         rW4CN8QT0kQZAKwXrk0YYNMcgOOiR4DVayvEXVNberecSw8hIEDzuSAncM9DAKHGsEO5
         Ulsg==
X-Gm-Message-State: ALyK8tKkFKRP2kN62mg6yosAzSTluHeUwij4rEihoZ0cGy8st5xl5md8+5On4nxgf8hs+w==
X-Received: by 10.98.41.198 with SMTP id p189mr30109918pfp.18.1467012015785;
        Mon, 27 Jun 2016 00:20:15 -0700 (PDT)
Received: from localhost.localdomain ([27.106.101.190])
        by smtp.gmail.com with ESMTPSA id y10sm4250982pas.24.2016.06.27.00.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 00:20:15 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	larsxschneider@gmail.com, christian.couder@gmail.com,
	chriscool@tuxfamily.org, Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSOC Update] Week 8
Date:	Mon, 27 Jun 2016 12:49:01 +0530
Message-Id: <20160627071901.4294-1-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160620073755.2934-1-pranit.bauva@gmail.com>
References: <20160620073755.2934-1-pranit.bauva@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

================================= SUMMARY ==================================
My public git.git is available here[1]. I regularly keep pushing my work so
anyone interested can track me there. Feel free to participate in the
discussions going on PRs with my mentors. Your comments are valuable.


=============================== INTRODUCTION  ==============================
The purpose of this project is to convert the git-bisect utility which partly
exists in the form of shell scripts to C code so as to make it more portable.
I plan to do this by converting each function to C and then calling it from
git-bisect.sh so as to use the existing test suite to test the function which
is converted.

Mentors:
Christian Couder <chriscool@tuxfamily.org>
Lars Schneider <larsxschneider@gmail.com>


================================== Updates =================================
Things which were done in this week:

 * I have converted check_and_set_terms(), bisect_next_check() and
   bisect_terms() and have also sent an RFC[7] to the
   mailing list for discussion which hasn't yet collected any comments. It is
   kind of important to discuss this as it uses a way to set the global
   variables in the script by writing it to a file and then reading it.

 * I have almost converted bisect_replay() and would be sending it out soon.

 * I have also sent a v3[6] of bisect-write[3] branch which contains
   bisect_clean_state(), bisect_reset(), bisect_write() functions.

================================= NEXT STEPS ================================
Things which would be done in the coming week:

 * Finish off bisect_replay().

 * Start with the elephant function bisect_start().

======================= My Patches (GSoC project only) ======================

 * check_term_format patch[5]. This is in pu branch and Junio requires more
   reviewers to support it so that it can be merged into next.

 * bisect_write patch[6]. This is the v3 in the series.

 * bisect_terms patch[7]. This is an RFC and open for discussions.

[1]: https://github.com/pranitbauva1997/git
[3]: https://github.com/pranitbauva1997/git/pull/17
[4]: http://thread.gmane.org/gmane.comp.version-control.git/297266
[5]: http://thread.gmane.org/gmane.comp.version-control.git/295518
[6]: http://thread.gmane.org/gmane.comp.version-control.git/298263
[7]: http://thread.gmane.org/gmane.comp.version-control.git/298279

Regards,
Pranit Bauva
