Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA92D1F4F8
	for <e@80x24.org>; Sun,  9 Oct 2016 05:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbcJIFmd (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 01:42:33 -0400
Received: from mout.web.de ([212.227.17.11]:53725 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbcJIFmc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 01:42:32 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MZUWH-1ba43M0KKb-00LIP3; Sun, 09 Oct 2016 07:42:21
 +0200
Subject: Re: [PATCH v10 14/14] contrib/long-running-filter: add long running
 filter example
To:     larsxschneider@gmail.com, git@vger.kernel.org
References: <20161008112530.15506-1-larsxschneider@gmail.com>
 <20161008112530.15506-15-larsxschneider@gmail.com>
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <3bdfebab-aae9-3263-218e-c8ae394084fc@web.de>
Date:   Sun, 9 Oct 2016 07:42:18 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161008112530.15506-15-larsxschneider@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:mLQjrygEQutUN0y9Npts6T98KDql/q6bZHHhWrmSCqtR79quTSe
 gVrj14rhHU+KyfhlMoGlfdXf9kO3Dzpmcyrn5z74gjtEsvnGqVVYCZTrhJ5RaHYFwRNDHaD
 PDFnSa9nxqDERQ7GOxYwe06ZmciaGHEEOz4LB+HyStRbIIhmmX5gKBI7KigBw9WzpSEgh6c
 terAQEanpg0P/HfjL3K1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GzWqA/xd/Dw=:I2+/0oTY9TU8q55l38pyEW
 dE7Covj+wFqorTRgmpLTxWHPOZ8xsw8zmY5DVtbexDHdgMvF+S0xQgy14hVWLbjABDtHuF9Q8
 TmM21AIPV+baclyGlu9KX/il8NsBnHLGaOoE1Bvvf2A6W2jyXNghNIhR2FnB5MFL28qt56Kha
 BkzrVNEGECaJib2Ec3RPQZ2Xp6JDfAPRYd7MHY9Zzlty7ykD44nDPNi4usHrSdSxTMUOkOMIU
 lg6T6iXK1iAL6BuLVBVaZNAj+UDLttnKZBHf0noEg5/yi3Q60b+/M5Jj503OdRDzvaxISgVW9
 dtZS6gD+w/cW6ccgPZ372oIkR0R9CCeH0xiepFgXM6gNKk9f84eD1eWraeEZ+ww7sTD+7udgS
 0HP2uWaqiKJEYQYPnd5CxMG4dgh9jhhIrTZj2OxBQO2mOLleoNDe3eLNSshWw2A4iex3QGIzj
 pY+RudzWVD472mogSPUXjhO4wixj0xl1zPOloGa5tTdb4MxlIeDsYE6EWEZKW4yqVx9YnjXzY
 RTMmAnH2k8GWLqJSe0lIaUso5Xptgi4gs0i9fJqVPHdlIpDvlAYG729wMjFibKhJZKB8gaYm/
 Ved3YoC+BI56EG07afEOUbpLeUiItppVzhnbw9yVDm/HGrnF1BkAmWcmj39ThxcX3ZGnO4duk
 t94LGQHje37v4b57CA5HJJGxo8WSYy+9cPli8DNFaMn1BpOF+1GYWYI8ynOrY414xzl4Ipj+p
 jP4Hi2xAMnwpQmura7o4Tm4ZBj/fdRngACY4TGUEwwIcBgFbztEa+3ZkMO1TfwGQQbeuIgGuz
 qAIURkt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08.10.16 13:25, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Add a simple pass-thru filter as example implementation for the Git
> filter protocol version 2. See Documentation/gitattributes.txt, section
> "Filter Protocol" for more info.
> 

Nothing wrong with code in contrib.
I may have missed parts of the discussion, was there a good reason to
drop the test case completely?

>When adding a new feature, make sure that you have new tests to show
>the feature triggers the new behavior when it should, and to show the
>feature does not trigger when it shouldn't.  After any code change, make
>sure that the entire test suite passes.

Or is there a plan to add them later ?

