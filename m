Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29EC2206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932115AbcLLTNB (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:13:01 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:33254 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbcLLTNB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:13:01 -0500
Received: by mail-qk0-f176.google.com with SMTP id x190so93445355qkb.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 11:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=l6bl7g28zokR9OWNcLYA16l1gS+uX2e/RVdF+5HSQWk=;
        b=zOSJMzkRxtu7yWUfcb7jD/h21rKqrgkWoSKR8rA0PjUYX3C8c3L90alpcemXm82j8p
         atYIAvU35wSbUd5ptM3tTGEpZHk62l0GmRa1miwarAIC05mMKDZdcWQanc/K5L47u0jV
         IiioYIOuBjUbWM010e/Jfe1Hkp827NwED8uFTsyDXwqUA5xOSGbgrxdqnz74uLJoB+EQ
         eJmYBcrezqRuZb8BoZxiYQ5jvZ2QRjayQXjZFrhcOfaDclKuX1jIB/fP1lJumUZL68Ms
         rQya4RlAetOS1Hh9Rz35EJCVpSFp4+Mz8llDm3G4Ghu5uTwIIVr2+Xvl8A5okml/0kap
         Mj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l6bl7g28zokR9OWNcLYA16l1gS+uX2e/RVdF+5HSQWk=;
        b=ezfk+/poroaSzH3hTp6OydKlCp6lifdqyK0v/mTKMW5b90Qu2qo8ZYzyn/A6nC5qTz
         iESZGca8aw7b0nmKzHU+U4Bqm/PuXHaMKbw8T6HZhWnyNnP0QlelLt0swpAVGtoLpPO0
         03LgOvCYxFNKjLlm3RaYbzJhrclXKLUpvvzqAcAYWtocZNVi4h5pQUTTkOruT7RKCzgs
         t5+lYEP/kRiSgB2QQL7s/rg3Iq8uc20dWJ1EoOA8Iakr37eFQSOr1HDzO2ij+TqB5phR
         tlV9SLtSwXL3WRVmwxXyWaGbacNOelbQ8Mf9LFJ+glKnOXUp88fQo4wvRxUxjb40JpJ+
         56AQ==
X-Gm-Message-State: AKaTC02iogUbnnR1+ESmCqoxarewNNRAJUyZJIOV4OhihSy3GGOB3kHyx8/7RRgiceoarBmEinqeA8Y8e6cJXg==
X-Received: by 10.55.149.131 with SMTP id x125mr81396032qkd.128.1481569979951;
 Mon, 12 Dec 2016 11:12:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.58.131 with HTTP; Mon, 12 Dec 2016 11:12:39 -0800 (PST)
From:   ELI <eliptus@gmail.com>
Date:   Mon, 12 Dec 2016 11:12:39 -0800
Message-ID: <CAKU2X8YiRGBa=ttT7EtEm5csXcUV_pBd1pyAQsEndv-p_3iNYQ@mail.gmail.com>
Subject: Subtree Split Bug - Irrelevant Commits Included in History
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Subtree Split has a bug in which irrelevant commits are included in
the sub-project's history.  Along with breaking compatibility with
branches created before the bug was introduced, this significantly and
unnecessarily bloats the sub-project's git repository.

I contacted this group about a this bug back in April and later
followed up with a reproducible test case.  However, I've failed to
get a response or traction, despite the significance of the bug.

My previous emails, including the reproduction steps, can be found in
the archives:
http://lists-archives.com/git/875747-subtree-split-includes-commits-outside-prefix-directory.html

Regards,
- Harpreet "Eli" Sangha
