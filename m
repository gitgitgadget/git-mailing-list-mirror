Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B56AF2070F
	for <e@80x24.org>; Sun, 18 Sep 2016 19:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932595AbcIRTb7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Sep 2016 15:31:59 -0400
Received: from mout.web.de ([217.72.192.78]:63728 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932228AbcIRTb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Sep 2016 15:31:57 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MYNzx-1bYh8S0QbJ-00V7LO; Sun, 18 Sep 2016 21:31:53
 +0200
Subject: Re: Gitattributes file is not respected when switching between
 branches
To:     =?UTF-8?B?0JLQuNGC0LDQu9C40Lkg0JjRidC10L3QutC+?= <betalb@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <CANYoZJng0GNZWU=eUEnXgVQ_NKQQOKM+mhJ9bsXMEJxxEhwQMw@mail.gmail.com>
 <8df2883f-ec3c-3446-2e06-207c93452332@web.de>
 <7c14756e-29f9-b475-f5f5-597acb8cea98@web.de>
 <CANYoZJnB81rEGNAjGj6jOscmdSW_niSy6jRP6acw2xB4ssX8xA@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <beaf2e9c-70c9-b80a-b201-aeed830f8807@web.de>
Date:   Sun, 18 Sep 2016 21:31:48 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CANYoZJnB81rEGNAjGj6jOscmdSW_niSy6jRP6acw2xB4ssX8xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:GJxrEcS5ICVkoOFLmz9R+HZXFEz7ovTl/VYFd/+UgxEiQaOb6u3
 kXncjmOXdEa9F2Jte5KVF1QU0mT8dOKSImJpJTa9xidhceaZaEkcI30OGDhk2zA/FwlwS95
 fZ8TFN1f1FriBVLGaUpuZFEdMiJ5s08BSD0P9iKQHMsJHLGZraPHhcB49vGqOHMbGb8pdAD
 W3nXkOX9MikHwifb2kBlg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yKYXcPjeBNc=:D6Ld4C4ees/+93veSHlSfk
 ipsmLuzQfVAKaHwu1RDbMVs2w1jQTuP/uIR9W48c/hkwTU0aGfTEyWq7mV/8qIJt5/WytIfZ6
 biuw4PQGEXFfRK/L5b1Kz8e5odqUtmVMF7hNhuD5EwitzZQFeIlfQFEAwXFFxpCkJzZsdPKha
 Wyd0RzZXThD9/8wTtn59Wu3We9rhFCCqr9mySf0EvKm5Jg11UsTkkWflcjwDom5klNrxxoJ10
 fWB2U0PeM3BsBHbWforfgSbOo64xcOdG6lIAof0qa1POoGdNiQjTWVOdwIsSHmFY+DiDTfCPf
 zgA0N4fjsagLkJbPl4aHAwKkvUMF/WrboXTqEILKwdJ1hUTShmGOKBJKiJS+9Vhh4v8O/8NNc
 yNOsDrBes1ejnVl/f0um7/YD9RLgBrSdkW47GCRQQZ8tj0fwYsmbvKvsq7BdhqkEarbB3wjk9
 dt1APPBjtBFjJLg9gxgaLOlADqglRXgeGJhQvX6syitYjPNxgoQiy3xtVFd7b7EZeFT2yy691
 TrAYPSG/ubsPkX/oyASLjJYMWPTIqc+TcGDONFSPrXLXa+Z3hl45skYmZj8qr4SCw4MTDHcq5
 DBDsPSnKbaWZpRO/PwcwFGaRhOGLBkNyG9bGM8OtgQM836jGpnZPE/gm85T++5CRJ14oVZUWS
 EG1gcCOMA0Q6Som9dKlr775tjrYxMfn2pD00eGPcBHb9etiAssal2uK35ePr+e79iQpjBgjM0
 PwfhWXfZCY0aDAFkp1I9KEVJeFqkDbu1s2EeABeutbUnInOyGY17tsgh1kleSFzrTLXa/D08V
 6ZuicMI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16.09.16 08:51, Виталий Ищенко wrote:
> Sorry for delay.
> 
No problem about the delay.

(And please no top-posting)


If you say
> ".gitattributes" indeed is not present in "master", but this is intentionally
then nobody has (to my knowledge) thought about this situation/workflow yet.


The short version:
Git is designed to have the same .gitattributes in different branches.
At least not in the long run.

A typical use case is to create a repo, adjust the
.gitattributes and keep this in all branches.



 



