Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337AA2018E
	for <e@80x24.org>; Thu, 25 Aug 2016 12:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757697AbcHYMoP (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 08:44:15 -0400
Received: from mout.web.de ([212.227.17.12]:49330 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbcHYMoO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 08:44:14 -0400
Received: from [192.168.209.54] ([195.252.60.88]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M2MYq-1bJzZi3OZ2-00s46O; Thu, 25 Aug 2016 14:43:34
 +0200
Subject: Re: core.autocrlf, was Re: [git-for-windows] Re: [ANNOUNCE] Git for
 Windows 2.9.3
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox>
 <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608171507530.4924@virtualbox>
 <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com>
 <alpine.DEB.2.20.1608231553030.4924@virtualbox>
 <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net>
 <alpine.DEB.2.20.1608231736180.4924@virtualbox>
 <alpine.DEB.2.20.1608231758260.4924@virtualbox>
 <xmqqbn0iu50a.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608241743460.4924@virtualbox>
 <xmqq37luru7z.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608251343300.4924@virtualbox>
Cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <8b3f92e5-0cac-ebb1-0f03-460ba3ad4d32@web.de>
Date:   Thu, 25 Aug 2016 14:43:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1608251343300.4924@virtualbox>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:xG2IxM6pbfbb7au67EVvehQe9ux/y4tZ6nR3n/C1BhL5pt3dlpJ
 ktZ1lk2Sbw500ZaP2HowN/r+1bEhLz16vEEVek6yV07gw98yL4WY4umAByASqBTTo7Z3efp
 sz7bHwP42bfPkRgs0EO3D4OCECyCTqKTIiUBEnVHXWckA4/m8XVmEtO3/52vqcZLCVOin/o
 T3bh4d+wVRnOG5/uOCpLQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3mLm4LiPCT8=:Lqdl/8TfnJKMe1m7zJD/cH
 tpZhaNX/9Tome9yE3ooCRFZ+exHPDZs2rG9xlaJKNJBs1HCsY+NSwqUCOjci7SHa8P+ss5+5Z
 lL4ABsT7cvzS5zEIULslkK7H/DaScPlNzTpuOtvYocjVe8L+2jxeiHFK++Uc7HwWYeIseDRo0
 faNghf4Uj5fU7NbP2TNuNTkaiwzj8QoLq+0zs0VYiFx4SR+wfy9Ma7bBcYgw32qDQm3KhXs8h
 yrW73hgFguygJbSgs3hQiyl3ZTh77nPmBkxMIYBmZuy2PtynO6XQ1laYH/DPt5zhn5reTZ0UM
 Z5P9Ecadyk15XyH262E6FlGQ0/SM0Lzjyh/6qjc+APijniZEjrfgabP1w+Iqp/EmbxxhKViRM
 dVSXKy2OCD44pTjqWqswLZOFbUT8GzLrMyVUcZJnA4MIhC9EF2fpO0URTHtxV6VPOkYsqRSYV
 nmfCp0/Z4H5Mfr3jHEQDxE59+IIFGUhtDRKystbKXlhuIkweMAqkN1ah+B2hqUie5trkFxvia
 JhjV/Q1s+YoKgEXO1fNyTkPftilLHo/K/ErJoT+9cIpCgJ99XfuhFdD0fDpIYXUvOiCVda3gc
 FPbhAPZdKgXlU7U9F86SPWIggaaeu5G9JOzOCjp/mhyqbWhk/nHrvNd3P0QbjQ42hRs4p7puj
 w01DTQCNrH7Zwj61ZFwVw19yt3XRvDSv4CVssb0mGisIEavjNQrpyOhFO8n4q9reUGgVxKEx+
 V09vGlBzwLoUfYdjjzNqzSvAe3woGcnDdCiJrlnB+siMr3vCiIPFWMl+owrWu8F3q7RWHETjv
 FPu3lYI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> I was not talking about the cost of correcting mistakes. Running --filters
> is potentially very costly. Just so you understand what I am talking
> about: I have a report that says that checking out a sizeable worktree
> with core.autocrlf=true is 58% slower than with core.autocrlf=false. That
> is horrible. []

Is this a public repo ?

Or is there a benchmark repo somewhere ?

