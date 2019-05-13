Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E773A1F461
	for <e@80x24.org>; Mon, 13 May 2019 20:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfEMUr3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 16:47:29 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:13895 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEMUr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 16:47:29 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id QHr4hxP3PniZTQHr4hqn5L; Mon, 13 May 2019 21:47:27 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=IkcTkHD0fZMA:10 a=nR6-tXCIbCptdSJXO18A:9
 a=QEXdDO2ut3YA:10 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
To:     Git List <git@vger.kernel.org>
From:   Philip Oakley <philipoakley@iee.org>
Subject: git --help not actually showing the git(1) help page..
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Message-ID: <0d37203a-e738-bad3-41e1-05204abc138b@iee.org>
Date:   Mon, 13 May 2019 21:47:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfF3H+jjD1Suu1owTHldbIKqspo8IGZiGl8KB2vOkdSJqY6I3bagOEOv/pzMmxtANAWtJ/bqk00RqJX1Dlj08oiY4v9buuxaKXEZAMkN+tk9tRnjrqP3o
 x3IPXXKPtfM+lEsjWS5gIXLpyTk+Rd+EiKuHiAtbOEpqLsB6W2VYH8zkJ5h6xT6PN5x3oNlQbGA9QlWrn4aIYU5Wga8fdrVXbwOxeBqQRFZisZ5/tElJW/q1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there a cli way, especially on Git for Windows bash, to get the html 
man page of git(1)? I have it on my system, so can go via another page but..

All the `git <cmd> --help` appear to work, but I can't determine the 
correct invocation for bringing up the stupid content tracker's page in 
the browser. Previously I'd have expected either `git --help` or `git 
git --help` to work (can't remember which). The former only produces the 
short form -h help in the bash window, the latter says 'git' isn't a 
command.

cc'ing Dscho and Duy who have had recent contact with that area who may 
know.
-- 
Philip

