Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 705382047F
	for <e@80x24.org>; Tue, 19 Sep 2017 14:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbdISOQu (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 10:16:50 -0400
Received: from mout.web.de ([212.227.15.14]:50595 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbdISOQt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 10:16:49 -0400
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6UiB-1dAcS70hPX-00yP3b; Tue, 19
 Sep 2017 16:16:28 +0200
Date:   Tue, 19 Sep 2017 16:16:26 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     Ben Peart <peartben@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "David.Turner@twosigma.com" <David.Turner@twosigma.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: Re: [PATCH v6 08/12] fsmonitor: add a test tool to dump the index
 extension
Message-ID: <20170919141626.GA28437@tor.lan>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-9-benpeart@microsoft.com>
 <xmqqtw01u50j.fsf@gitster.mtv.corp.google.com>
 <5438765b-3119-ef15-8635-932b8cba08d3@gmail.com>
 <6f55efc4-96b2-7c53-7d54-ff5801697550@web.de>
 <MWHPR21MB0478E4671130AD9E19B77460F4630@MWHPR21MB0478.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR21MB0478E4671130AD9E19B77460F4630@MWHPR21MB0478.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K0:C7sS/Xnw5SFKIM9Hlc3/Pjx/Nt7v7ElQVriArfQvfLS3YbEdBvV
 Ljb+9KKAu2sh05Ch1QH8UCV0vm6NFDjUwuAfBIwggR7zLfTC70Ds7Tm5Q1PVCWcaA5iRbfI
 eqyS/4Itgz5Luy86wMQ+SmuVhCXtDZOO1F4JHaMBpGFOYnsW995lShpTZ7MkKWkJ+OwrGdU
 lDwIYJmyWRQJ3lZP+bvLw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n3sC/HBVaTU=:W78Svm8d2l9GrAAtcNBfT7
 w40Tf4SLKz2pJrdYxsPjpNPYpSizJ4iTuxHCtKRUy0jx9R5lQYDnqpEWmdLVAprwoiwoaYZrf
 KvYH3sjcKK0PhSrzYVn1GgHMlGNDnw6SaShEdkejj+pKHriD7EA3RM9gN0dXv6W7Kkcm3JDvo
 HFBbVPgLOu/U5nbja/Vdz6ZZyLRkUzo+XM0HUXMUf07xO4OL6hL508iQkj6gc4H1zu0y7wG+f
 tdsMjVOKcMksSRLx7CI0nbEZ8E5IgnhPXuLciWBZ4UlwMjAEKROkKkM7MRLxKoiU3Cnzm/hyj
 AqbnZFulfUuZnju9+1G+WRfstkyPzop4GdgPDAzuYn/MIRE8TJFk77mwHwTbHRETzC/bAlis/
 FgnTepx+zPXzY/lhTAyfwGZ+upZONXxKTNVS3IYnYWsFxuoj+rqKEcV1TDrwPPGhRpjClz2vS
 Pxh/9X4b9jWJspyceZ8tG/cph35BS4phxSeSFW3PHDu9EY9EqM+Qkmv/LYyxIWbkIczRsbVsU
 XXXoJF7Km9F81Krs52pF8FCZKqiiExxqZ4kBLYr7WbIpqmAfS54ZUCkY7SeG12UxLfFl7J3rW
 e1RzheaOL2nnRllb9Nu/j17t7/JvIJAcjq/iZhlzW8kh8NgFhO84Ko5ysycqyW2Ud8NrCt/NR
 WCY1JOVMtYjQF+bjEoJ9136UDLoqnhQX/aehQapFrurVIwbGmsJaDcRK63RX+PgPzlIOjg8Zr
 n5fCl4V8ZtrcC9xIrn0G9UwKQSCFSvBqp89gQ/OT3j6F7p+itiXQsY0g2/Qmt1Ct1TFQ7E9GY
 F86Y+dPesQj5iBnUqgNBp2+8oTBcw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> 
> Should I just make the variable type itself uintmax_t and then just skip
> the cast altogether? I went with uint64_t because that is what
> getnanotime returned.
> 

That is a bit of taste question (or answer)

Typically you declare the variables in the type you need,
and this is uint64_t.

Let's step back a bit:
To print e.g a variable of type uint32_t, you use  PRIu32 in the format
string, like this:

fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),",....

In theory (it is in the later specs, and it exists on many platforms),
there is a PRIu64 as well.

We don't seem to use it in Git, probably because uintmax_t is (more)
portable and understood by all platforms which support Git.
(And beside that, on most platforms uintmax_t is 64 bit).

So my suggestion would be to keep uint64_t and cast the variable into uintmax_t
whenever it is printed.


