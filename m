Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16351F404
	for <e@80x24.org>; Thu,  4 Jan 2018 22:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753395AbeADWdi (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 17:33:38 -0500
Received: from mout.gmx.net ([212.227.17.21]:59134 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751952AbeADWdh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 17:33:37 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaIw0-1eDUIg2hZo-00JuNC; Thu, 04
 Jan 2018 23:33:34 +0100
Date:   Thu, 4 Jan 2018 23:33:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Alex Vandiver <alexmv@dropbox.com>
cc:     git@vger.kernel.org, Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 4/6] fsmonitor: Make output of test-dump-fsmonitor more
 concise
In-Reply-To: <36db77ccb5c025a73bf3f5841cd11607427ffdc0.1514948078.git.alexmv@dropbox.com>
Message-ID: <alpine.DEB.2.21.1.1801042331590.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <20180103030456.8181-1-alexmv@dropbox.com> <36db77ccb5c025a73bf3f5841cd11607427ffdc0.1514948078.git.alexmv@dropbox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ajQGipo7ydsFN1mUtX2nunpiZaDXrRnCCuIgicmbFCyUix1WAtk
 vLu8OT47BYVD8s7qtmU+5QP2ushzVWNT3teohWRW3hBH195uUDHmUZb18JMPA1tOOwC6255
 hbqF9A4C0+P2wNrFHNZBxEmQUPClSvZX2gVcIsSwTOHoqx6ab5pOeCZalVTquXwDfHObrhc
 28dQG80cJqD9y1ZqnbZqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Mi5HM/hyi2o=:7/IKDFMWm3hr50CF1u8DPl
 W6bq4tevWzSmBX2OtVfAY3YYpU5s3XtxfcMMDTwluRYwPKCnvccf337PgHzTna/20tHwsaSm7
 Pe3w5Ip5FRR46R9gOSweo87rgJ6sSCGp8m6suQtXuJC6jCqmpL5UtDgjFG8PDCck3+nJSPWw3
 rS+QfSXaq5doJhPij04zBNc+IE9PasMpTXg/Si7vzpt+97g2Lh6rqPxVYpvmxKOPjMwoVGnQz
 5vaxrpr/s/HoFQpDmuJXLQP2tmDYnkCXHIIYI07XS1HMIvcUXRXWP+NWNjJb8SxdZpL4xSXtD
 wQ33/dQirgSbepGOOH8QwsiWtmrLBab/lOGJWA4AHhKfFPKURYRzku46zxxHUN/8ch95lLcVv
 /ZW6c/4vdRSUZo/XR1qK/J92EWo4RxrHoV5utUt4+U1lVPKh+dJBidlh6xGNOs8dX3iiZp2pk
 5IHxsnc5UkwmzC1vOlpsr8i2hcZK/0SJ1bkIHtyVeAWC0mTunxUYBJcNPd3Eq4LF1614UQ9Vq
 L8XXniVuHepTCe+CSd3HaaOSwxf81coXhTSuH6IFP0Z3Ul9cDOqSHlvceGV+U33qXysTQG2hv
 GzGuEu81essXskdazoE8llURzfSrLdNUxvh+Kg5UK7aItv2NbxKoaBy/MDgpyZ40b22twJS8c
 8ClppHfDvkmmDN1kX1dXKsM9zX2xgNG6bTkOCOAYAY2Rc8zo3deBP2tWk79cpX96dGG4pAG3p
 TOnRUrikdBIRGLrbLVem/4qwN88/NzYSIlx8WAKad2R/k6qTYC4U8nu4I3V7SBflJJQm073yE
 JcwDrYUSskvjf4V7JNLxhczcPT2lRguVa92ewQkJTKYnZZyIXv3r1MYc6xWdMCg1T8Dz7BN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex,

On Tue, 2 Jan 2018, Alex Vandiver wrote:

> Rather than display one very long line, summarize the contents of that
> line.  The tests do not currently rely on any content except the first
> line ("no fsmonitor" / "fsmonitor last update").

The more interesting part would be the entries with outdated ("invalid")
information. I thought that this information was pretty useful for
debugging. Maybe we could still keep at least that part, or at least
trigger outputting it via a command-line flag?

Ciao,
Johannes
