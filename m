Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48B920133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbdCCPiM (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:38:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:52228 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751772AbdCCPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 10:36:51 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MXZw6-1cpz7v0GoQ-00WXZS; Fri, 03
 Mar 2017 16:04:17 +0100
Date:   Fri, 3 Mar 2017 16:04:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 9/9] Test read_early_config()
In-Reply-To: <20170303050745.wv4zsb24ykr34xr7@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1703031553070.3767@virtualbox>
References: <cover.1481211338.git.johannes.schindelin@gmx.de> <cover.1488506615.git.johannes.schindelin@gmx.de> <f27a753830b8fb61a5276ce1d8eeba04ae4dbbfd.1488506615.git.johannes.schindelin@gmx.de> <20170303050745.wv4zsb24ykr34xr7@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VgPbZx/TFAWYBvIy011D+/U1SkwfAe2KXTqQs2YgJoWrIWVVWqN
 Un+OuMFXMg3/Gy8UkILFjc7/ZZnidxDQEzCjJI7lXUNKKmruc550/3lPd8aisKPPX45Y8kC
 StQa8IzVRqsAPUlw/7Gi0/Yhm9VYhoIwBQcHFLRKnmqFDRnNbBCMQL7ar/LUFSOYvC1epeI
 AoIdGfUtH1LBgwZek0ekw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1wqEyWAFIhQ=:MYFys2TJ2rpGzHNtRM95KC
 Y75AAvk7G8biBMRgDqJZPAXzTlBmyQaS3Kby70DXdefORDTx3TCJuHHUkI7VEBvSufOP2/yaA
 dA66tajyTh0WOSNLhA3ojXHp/P9SrcVOuoSxGOg7co8m6emO6GE/HllwhbcGU9UYSLSsbf2o8
 cezbiaDiOLAjRcwWQ/1t7lAHFYDJr1jaSGU51v+op7oYjcJRMfrkfc5FbGMGLEgfQQlOX+n3E
 m/jUIvwIvq7MXRgetRMkG05ZD2+gFjWeCU9GnTA3kS5WCu+RTiuV76vt3MX9CalLksdwW2eIR
 3Lgtw/sRFnkVV3voPg57MSJHeCfoLmF062FNpsEgEI/NWQE4MUWJk+5wtxRD4PEoAPhAUQzGw
 oHqE9FgeeLtrZoMi8g18jRlyf9ZkkU0RoQV5u7gxZz8cgFHehoc8KgffDUVhYLEPXMWdam9Pa
 SMK6aX654L1CEfRXpJgm/IuGECjgxNoff6ZbJaH8dJmf0VkITlygiDyS0Jz4bCiLP4ng4RPWh
 dd+/m7ip8sVhP3z5KcA/3myUKjs8ZTdwWMmcBlHua6YJxaWhshCJsZ013WbkK/YkenJQI69DL
 LwKngbd16xZHZlL/510EyRXoTZZORN6W+5e7sn5cGOAXoxiq0pXHS8ysj+5RIQSEkGIGaCVVR
 LsVaz3CnR8jBXf17ZHQve3Mr5tikd8gQSwwcRkA1cfKFYVtwgZyaMWftzVVYI+BTIl5BkbtSu
 HdBmXJ+dP1bIJ17Vievcqy5tc69Td77YKuyMIgnZLr/zAozoz1NX6XEE1e8nW6ZRCCcb1cXjP
 kKMUnIe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 3 Mar 2017, Jeff King wrote:

> On Fri, Mar 03, 2017 at 03:04:36AM +0100, Johannes Schindelin wrote:
> 
> > So far, we had no explicit tests of that function.
> 
> Makes sense. The pager tests fixed in an earlier commit were effectively
> checking those, but I don't mind making it explicit.

Well, TBH I am a bit uncomfortable with t7006 doing those tests. Just
imagine that something breaks in that script, say, when working on
exporting the read_early_config() function. You probably see this coming:
debugging those breakages is half a nightmare. There are multiple levels
of shell script functions, a Perl script, and an isatty() call between the
bug hunter and the bug.

With the new tests, it all becomes much more straight-forward to debug.
And also less surprising (think about the fun you can have with test cases
that fail when running `make t7006-pager.sh` but not when running `bash
t7006-pager.sh -i -v -x`, just because of a forgotten `test_terminal`...).

And yes, you can debug t7006 with the good old "insert debug print
statements here and there, then compile and run, rinse & repeat" method.
But you know, getting to use a real IDE with real debugger/intellisense
integration after years of working on C code in the terminal with vim and
gdb [*1*], I kinda feel a bit pampered and ask myself how I could possibly
have put up with the awkwardness. ;-)

Ciao,
Dscho

Footnote *1*: for some years I developed Java code in Eclipse and already
then did I notice just how much faster development becomes when you have
powerful tools to help you...
