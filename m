Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5989207DF
	for <e@80x24.org>; Sun, 18 Sep 2016 10:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759245AbcIRKvn (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Sep 2016 06:51:43 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:20059 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759057AbcIRKvn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2016 06:51:43 -0400
Received: from PhilipOakley ([92.22.63.19])
        by smtp.talktalk.net with SMTP
        id lZhDbvHdXY8RwlZhEbHQAZ; Sun, 18 Sep 2016 11:51:40 +0100
X-Originating-IP: [92.22.63.19]
X-Spam: 0
X-OAuthority: v=2.2 cv=b+Xw2ZOx c=1 sm=1 tr=0 a=vjlzJYBYqocBNNOviNpP3A==:117
 a=vjlzJYBYqocBNNOviNpP3A==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=A4Y335kgy9w4ghY8J98A:9 a=QEXdDO2ut3YA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <630656BFF8F84E43A2E4C67138A9A675@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Fredrik Gustafsson" <iveqy@iveqy.com>,
        "Andrew Johnson" <ajohnson388@gmail.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
References: <CAM_5GX48gDAZSvAWnxO5n8uhYf8vmfAJ88_31_ewsQxyPfF7iA@mail.gmail.com> <20160917183919.GJ20666@paksenarrion.iveqy.com> <223e818d-6d10-2679-c2d0-150011e74a59@gmail.com>
Subject: Re: Why are there multiple ways to get the manual in Git?
Date:   Sun, 18 Sep 2016 11:51:41 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfAvcW3RnlpbNs2OInaH1fcrE3uyH5oCjQtUDicKbNZ5cWotM8z/mR54dweCmeB6O58CpQZ3WaA9cpYrsrX7eOMZk8/L8p9WLhA05kKTuImy+IF8zaFhd
 jBf20dZOTXUicFXVocIiNHi2Ae4daLtjVoXRF3+c4TPdpsjtn8aa9G/7rGIRq3H1ocOQwb7rEABxUnRbCSlstDWKvMuirWBNcGLgDZYp+cEoeHLEgt67XlcE
 N/hoOGSmDWoYLFiCypIRa21aK3APyPtP/9Mhvpwo2gukyM/QascAhHYSuFpEPftW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Jakub Narębski" <jnareb@gmail.com>
>W dniu 17.09.2016 o 20:39, Fredrik Gustafsson pisze:
>> On Sat, Sep 17, 2016 at 01:47:52PM -0400, Andrew Johnson wrote:
>
>>> $ git help <verb>
>>> $ git <verb> --help
>>> $ man git-<verb>
>>>
>>> I tested all three to confirm they were equivalent.
>>
>> While I'm not able to answer your question, I can shred a little light
>> about them not being equal. For example using a windows machine
>>
>> $ man git-<verb>
>>
>> does not work and
>>
>> $ git help <verb>
>>
>> opens a webbrowser instead of a man page. Using a unix system I would
>> however assume that
>>
>> $ man git-<verb>
>>
>> would work since it's the standard way of getting help on those systems.
>
> There is also additional difference.  There are help pages which are
> not about specific Git command, but about concepts (gitcli, gitrevisions,
> githooks, gitrepository-layout, gitglossary), or about files (gitignore,
> gitattributes, to some extent githooks).
>
> Those are only accessible with `git help <concept>` or, on OS with
> installed 'man', also `man <gitconcept>`.

The `git revisions --help` does work ;-) But like you say, its apparent 
"command" name is 'gitrevisions'.

Thus real commands gave a git-command name, while concepts have a gitconcept 
name which can then be found via the man command.

--
Philip 

