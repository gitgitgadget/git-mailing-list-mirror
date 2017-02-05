Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996871FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 21:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752750AbdBEVpl (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 16:45:41 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:33689 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbdBEVpk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 16:45:40 -0500
Received: by mail-it0-f68.google.com with SMTP id e137so6781294itc.0
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 13:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=spaxNW2hSB7noL88QORECR/RWao7eT/EfPLP1e6SJLc=;
        b=ArUJagxJqf09ujCiFgnnBR2AuuyomQoaqJnSsEy3Jw7MEONscJAW+rxOWjezb4QkNm
         BJTNyIiO6uvUb4AseIfRI+EB6uGDKvxNvitpUZa575e9V7M/ByotPehV/Rf8GbxCjlLJ
         RTrM1vD2x/AhGVj0/LKYA5q7cv62XsqPBl/bZJUQ1g0a+/nMoyB+QiIqGFvLYKK9flbm
         EuRrKh+YO934hoz4jqWyDWlsCK50CaObqvsMDyD5Nsz17X0nh928WMpuge3BdCVs74by
         rvKng2yt9DhsGwzqMKO/XxLKs6X87gyYZxpw0A7O+RFmU/87RN8+/a/1+ZTOMr3p6puu
         tX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=spaxNW2hSB7noL88QORECR/RWao7eT/EfPLP1e6SJLc=;
        b=TRTyFwJgBZlPUxD3WFri+9Vtct7wKckvBhWnSsaA2Zq+iV44Rez2VpZaNDzyM4f+O8
         gM0ZbEFMRbQnJ1dclxWN1z3/8Oz0AZKyM4somZJ6Zq/itJgRyuEcIm15BMDZg3+2KCUN
         EQG+QujTQAOxP0Q5MKN4g/Cb26iH1aZMitNTOw3DfYLVm7bVBoO2hEqATOC6cL1Vmxqw
         ex0D3Mm//NVXcO90rW9nqOt3SjB4ln+K4+wtwqwkbrr36SMvyY65BsjCQ5yAD3ebrdfz
         oNIqKT52f8NuM8naNOjrF4C2fU1VN0KD5RMbFDdcGkIBNMulsY7DQXR2vPQcgV5h4CBe
         drmg==
X-Gm-Message-State: AIkVDXJ7h0j/pwQ0HEyY9Rwcv5IwyG0LUsnbhz3G9lwUXySR6VF1POXFkLyIYYcvhHmXybVY+q2ZWxpfT7n87A==
X-Received: by 10.36.116.71 with SMTP id o68mr5542943itc.60.1486331139879;
 Sun, 05 Feb 2017 13:45:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.149.75 with HTTP; Sun, 5 Feb 2017 13:45:39 -0800 (PST)
From:   Liam Breck <liam@networkimprov.net>
Date:   Sun, 5 Feb 2017 13:45:39 -0800
X-Google-Sender-Auth: -eplF5eP0ox1rTW7wmVo5cYI_0Q
Message-ID: <CAKvHMgQLKccm2LcL4LGhz0afVthaS2gvEcLtoHX2TcDnr1npbw@mail.gmail.com>
Subject: In-body from headers ignored
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git format-patch & send-email generate the in-body From header.

git am recognizes it.

git commit & format-patch & send-email ignore it. (The latter two will
add a new header above an extant one.) Is there a rationale for this?

If not, maybe this is a bug?
