Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CB75202D7
	for <e@80x24.org>; Tue,  7 Mar 2017 10:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755102AbdCGKa5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 05:30:57 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:35061 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754956AbdCGKaa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 05:30:30 -0500
Received: by mail-ot0-f174.google.com with SMTP id x37so87916500ota.2
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 02:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=s4egXPKqR6szfDO00vVWHRrihT3vxTBKmorPAM41zII=;
        b=KvcKx2BnHBV5SzRohoqeUmAFQW2pIsVAFKeaz+QLGAcCUVLcljrIj5PBKjC6Qt2xN+
         R1BUs/13RDaPrwE0thoJbxv4OMLmSSy3izYXaPphTh0dCUNWG2rNsUX7uMijhMIa697g
         veAOF7T4P4F0zQyv2h60oUpOUcCmNqWtTrLqH9MT+p0ihKJ2Zf7ndGyHOJjWLund2S/o
         hJbTrZh+kTpET4s6xZTcV5J1yZyyUFihPT88yvVi9lnGnqxHJMMznhZeyC2ok52HPeZQ
         JnWz8X+qjp6j1pf/VvON7mAbY42KVr0CfOvrKfWvkByVE7hjmV4lBCKilny8+fdfTg54
         5BVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=s4egXPKqR6szfDO00vVWHRrihT3vxTBKmorPAM41zII=;
        b=Ks5nNM2Mr+Qg/R9lhmnzSvzMbTJ8A23DROXkWCAf8udV7XJPZb19v3BU1vQcTn8SB5
         31fn3fUy922XL6fCNoZIxAFrzmZj5WPy12oQBYNYQu7qAlLKyGyTKGDMa9UhJ41v2Rqv
         dtjwAn0mmiAhfVneVxBFJ6Je3OrjwvnOjHwEuMbesBBOboXDS0LTEDV3M8q70jvYxfkK
         wRURzQVwr+KLdInvZXvVkfuZkQLdFxVPvTHy70bXUyZpxAWPhV9+aH6dUcyn2wRkHHq0
         LAveshhDAtoGWe2rw85irbOzO+zrNDP9XgD9O6hGMIcamuGnOoWXnaRtG9+RtYHlATRP
         yQyQ==
X-Gm-Message-State: AMke39kTP9ePvbQewpNJwHCN0r4FzJkt29/6/FID+ESRHjRyA/oSE9CEsOxLGKz2FeZT9xPD4WhnMAeTI5y51w==
X-Received: by 10.157.82.77 with SMTP id q13mr11840129otg.161.1488882149144;
 Tue, 07 Mar 2017 02:22:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.25.235 with HTTP; Tue, 7 Mar 2017 02:22:28 -0800 (PST)
From:   Vedant Bassi <sharababy.dev@gmail.com>
Date:   Tue, 7 Mar 2017 15:52:28 +0530
Message-ID: <CACczA6WCdu0sdd31R2Z6xbr=meo5PTtcOVYCdVHdgZXAfK-3rg@mail.gmail.com>
Subject: Reg : GSoC 2017 Microproject
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I would like to participate in GSoC 2017 and I have chosen the Use
unsigned integral type for collection of bits , idea from the Micro
projects list.

I request the help of the community for clarifying a few questions that I have.

1. Is this Microproject already taken ?

2. If it is free , I would like to point out one place where a signed
int is used .

      In bisect.h , the structure struct rev_list_info uses flags of
type signed int but , the value of MSB is not checked as a test case
for any error checking. Hence it can be of type unsigned int.
It is only used in rev-list.c for checking cases (BISECT_SHOW_ALL and
REV_LIST_QUIET ).

 Is this a valid case.

Thanks.
