Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FB11F42D
	for <e@80x24.org>; Fri, 23 Mar 2018 09:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbeCWJf1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 05:35:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:55391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeCWJf0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 05:35:26 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lq9oW-1eLadE2q7U-00doLm; Fri, 23
 Mar 2018 10:35:20 +0100
Date:   Fri, 23 Mar 2018 10:35:21 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Michele Locati <michele@locati.it>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] filter-branch: use printf instead of echo -e
In-Reply-To: <081ccfce-7a89-503e-465e-3befe6f33f17@locati.it>
Message-ID: <nycvar.QRO.7.76.6.1803231034400.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180319144905.11564-1-michele@locati.it> <20180319155259.13200-1-michele@locati.it> <nycvar.QRO.7.76.6.1803212249170.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <081ccfce-7a89-503e-465e-3befe6f33f17@locati.it>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7mOG8IiIotcJ8mnALk8ULjPKS6HPKLwM/9LYAXMRPZGcNFuNNzN
 VWYCkRxRQpjcd/rxYczOdzWLq5Zx3IdDtjMghLArcKvAZHNMnuSkmLBctRAad++YcQ+qKPi
 IcLVUnsslPFajUHTuXz12SROXBTO4tbO7lBWraFiI3NEt1j3AbIGrdV9CEErxCVpDonP9sr
 pSOj5l8z0cS1Vd7uK8EYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:enTf/eoX3pg=:lCmU1PK/AOIhXq3wyy3VJu
 4OzaepMuWPtz7zxrIAe0I39g4p8OhPGIzlx7rOxqYYs6NIBgqzTBN+QqBjFueDlUuurvFy+Jg
 EjE370oFRuwSdMwK5Zivr5/Zbp1fPrr5eQRMDiA+eovI+skoEgYCbwppdocnJdvvxka47ktou
 QEmeMA4BFM1DT8ffwZjmSSeHMXIe3uXykC4pa3kfl5smdoP1mzU+9HPLQal5S47ldEYUPtew9
 cQIJIT/GyED822q3Ax+8lzjHNhv2ZKegtjEF4IDO3RG1BTe88Asi4u/KjLy5TzyQdmIiXM3qb
 eO2XeKvRZXZu8i7T3/rQwFPdPUbihOYcjzDw5Wbne28G0uYjABASBOdc/PlvZ5LvdXJLSkhui
 OAXwlAVLx43Dic9+LvcJDeITyYxgahVtAYGdUGZPMWtvczbiiUbb/cA10VI+Z4lDPBFwG5Ax3
 dvE/KOHOsvD3JF/LSW/fU0ULSY3UgmFEyIJW5p6t2Df77aN4Es4HHknGjY82B+y13DB91QDkm
 39MJ/ZWcqz6AqTCwHmYnJNzSxb/umXPJmgf3xPvbAyxeXIeW9c+WRH9005yKQdjRTrSXlIBRu
 TERc/tLWOhknLsLyzieu3852OCSUZfXGCm9ChR4D4aSwUM6QKJk5PIwdsd5QKjEgwsNNtS5AG
 g5hOyTInQ6A3wxI3V2IFVPtNmfM5KSot/AKYR8d4rIw5uDST3j6wm247Wd6V9EBoUZ509Wj5g
 LBNJlQ17EK160KNOXcb78/vpitipbj/i7kw32WQOeXUXjpxVY1ei970bBvFnho+1ycCHtq+y8
 4a8I0QYIQNW0egb4mACpJSiWFRdSRhq8fAoecupLUEEzTN4aHc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michele,

On Thu, 22 Mar 2018, Michele Locati wrote:

> Il 21/03/2018 22:50, Johannes Schindelin ha scritto:
> > 
> > On Mon, 19 Mar 2018, Michele Locati wrote:
> > 
> > > [...]
> > > -- 
> > > 2.16.2.windows.1
> > 
> > Yaaaaay!
> > 
> > Out of curiosity: did the CONTRIBUTING.md file help that was recently
> > turned into a guide how to contribute to Git (for Windows) by Derrick
> > Stolee?
> 
> Well, no. Here's what led me here...
> 
> [...]

Thank you for taking the time to tell the story!

Ciao,
Johannes
