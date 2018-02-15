Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4D421F576
	for <e@80x24.org>; Thu, 15 Feb 2018 09:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755248AbeBOJ56 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 15 Feb 2018 04:57:58 -0500
Received: from mut-mta1-se01a-zose1-fr.yulpa.io ([185.49.21.248]:34790 "EHLO
        mut-mta1-se01a-zose1-fr.yulpa.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755165AbeBOJ5z (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Feb 2018 04:57:55 -0500
X-Greylist: delayed 1521 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Feb 2018 04:57:54 EST
Received: from zose-mx-out01.web4all.fr ([185.49.20.46] helo=zose-mta-hub-out-web-01.w4a.fr)
        by mut-mta1-se01c-fr.yulpa.io with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <matthieu.moy@matthieu-moy.fr>)
        id 1emFtt-0001jF-Nz; Thu, 15 Feb 2018 10:32:25 +0100
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-web-01.w4a.fr (Postfix) with ESMTP id 060751C11D1;
        Thu, 15 Feb 2018 10:31:40 +0100 (CET)
Received: from zose-mta-hub-out-web-01.w4a.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-web-01.w4a.fr [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qtFSoMph-SWQ; Thu, 15 Feb 2018 10:31:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zose-mta-hub-out-web-01.w4a.fr (Postfix) with ESMTP id 8E7241C11C1;
        Thu, 15 Feb 2018 10:31:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at zose1.web4all.fr
Received: from zose-mta-hub-out-web-01.w4a.fr ([127.0.0.1])
        by localhost (zose-mta-hub-out-web-01.w4a.fr [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HmONIo2GDK6X; Thu, 15 Feb 2018 10:31:38 +0100 (CET)
Received: from zose-store11.web4all.fr (zose-store11.web4all.fr [10.101.13.41])
        by zose-mta-hub-out-web-01.w4a.fr (Postfix) with ESMTP id 6D8B01C0E22;
        Thu, 15 Feb 2018 10:31:38 +0100 (CET)
Date:   Thu, 15 Feb 2018 10:32:14 +0100 (CET)
From:   Matthieu Moy <git@matthieu-moy.fr>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@splunk.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Message-ID: <1227220836.729681.1518687134631.JavaMail.zimbra@matthieu-moy.fr>
In-Reply-To: <20180214234630.GE136185@aiede.svl.corp.google.com>
References: <20180214222146.10655-1-avarab@gmail.com> <20180214222146.10655-6-avarab@gmail.com> <20180214234630.GE136185@aiede.svl.corp.google.com>
Subject: Re: [PATCH 5/8] perl: update our copy of Mail::Address
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF58 (Linux)/8.7.11_GA_1854)
Thread-Topic: perl: update our copy of Mail::Address
Thread-Index: u1hnr1260wbduncxk+RPGJjonjzJSQ==
X-Originating-IP: 185.49.20.46
X-SpamExperts-Domain: zose1.web4all.fr
X-SpamExperts-Username: 185.49.20.46
Authentication-Results: yulpa.io; auth=pass smtp.auth=185.49.20.46@zose1.web4all.fr
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vGvQxYaDibXf/t5ef8qBOB602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO7JN/Ahk3pUNhgSG5Y/486wK3Vg05iEhVtlVLxIoDa5/JnY3oudDRGl9PqcWMzkbTrhY
 PCxqwgo5YKhx28Sgzz9X47hzEvan4mW51I2Ph9jGEPH14t01+xDEo9jX/vdeZdbkkj0+dz3zOWCJ
 CtA4QkG6N+1VUNcClR7OpKDaMWVK5ab/w0pd6bWIpRejJFE72iN+/YZsfbLeqkjR05PDYJsloZFO
 o+Wa50OVnw/0nSi/v9YHmuAfRp1qyEu5Ju9xPAs+ScOlgemjTy7W4M75SMxj35TZ82Sw4eEBO7EJ
 QDB5qbTwVe2w7c8RZ6IX4qZlkqJh/sf/IF19W7oFco6qiVPpdoW5FF5tQXEr1cN2RQWmBMmyNbDn
 7R5kilAhwr3KtIiiILkMOdp6YQ66CDf05wHbb3LAi50VdkYTPXFZwgQPZU2GICfTGzs+F8lUKgKl
 QuMOFaraXWS+MpnzoBGC6OdRIa89mx+tkjtlOjiIrcym/Dvbcwx3hRAEp9Szw6Y9GvqexC/FKmrB
 VQq3b2CTOB3jT+mbShou6hktCloTvTOZhth9l0V3K/i0PQzTWd3bdN1D9vMVR24Z2IIpUJ/Oara4
 bMhNtP7dNqUWA+bDQmxZZlNr7345IxfA8CDxo1heO7wqyT5p50x81ZKcmzCu2U2TLIJStWxour98
 oA/nMHn/UeymUySRv9UEZ8AMx8P6CS25wVRoSK4vDnDKBdKFXCTNCmNd9/oMqR3HFr02FASixkSn
 zvOM14y3UCJQwrLc0QcEaQl9xXYUqQie9rGnDhjKi1YqYU2OEruN9yRgmZNjM1zLTQBEE9Ey1XFv
 jK16M5mxbVKy9oe8K88nWw9a5cBSshGMS8wi2RE+BtvrU9ipd6iiv02852p6p7VmbWoqV9nP2ZZI
 NnMiGfy9mez1m2b+5xeMjf+8DZYUppeCyKFgo8TjnYyZBS8tp4RZW9IV0tq7/VbxLLZA3+C/u66L
 UngccBIk1Sag4dKiqCrF8eZZCP92LhhFOsN+9bgqzfUVDVqhGPQU+R6WcEzaexyeunHrBs6oeyM9
 /YLytWumqm/pr4Ff54xxyGzTCjn/Zxd+sWtjaPrMy5+1s8UPvgd5svoPogB+zOIRsDZit34c9voj
 xi8bExZ09S6HjTDouvl2APG1BwBDSRgbR8kv2P8SF2NzdJ+smPQvhUTS+PxmdPORrXvQL+LvjUMF
 uaasHQAtjjEvuGslKTrRIXcXpFg5ivY=
X-Report-Abuse-To: spam@mut-mta1-se01a-fr.yulpa.io
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jonathan Nieder" <jrnieder@gmail.com> wrote:

> Ævar Arnfjörð Bjarmason wrote:
>
> > Update our copy of Mail::Address from 2.19 (Aug 22, 2017) to 2.20 (Jan
> > 23, 2018). This should be a trivial update[1] but it seems the version
> > Matthieu Moy imported in bd869f67b9 ("send-email: add and use a local
> > copy of Mail::Address", 2018-01-05) doesn't correspond to any 2.19
> > version found on the CPAN. From the comment at the top of the file it
> > looks like some OS version with the POD stripped, and with different
> > indentation.
>
> Were there changes other than the POD stripping?

No.

I should have mentionned it in the commit message, but the one I took was
from:

  http://cpansearch.perl.org/src/MARKOV/MailTools-2.19/lib/Mail/Address.pm

i.e. following the "source" link from:

  http://search.cpan.org/~markov/MailTools-2.19/lib/Mail/Address.pod

The link name suggested it was the actual source code but indeed it's a
pre-processed file with the POD stripped.

It would make sense to indicate explicitly where this file is from in
this commit's message to avoid having the same discussion next time someone
upgrades the package.

-- 
Matthieu Moy
https://matthieu-moy.fr/
