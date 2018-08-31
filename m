Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83B611F404
	for <e@80x24.org>; Fri, 31 Aug 2018 11:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeHaQEX convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 31 Aug 2018 12:04:23 -0400
Received: from elephants.elehost.com ([216.66.27.132]:59654 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbeHaQEW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 12:04:22 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id w7VBvChE009863
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 31 Aug 2018 07:57:12 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jonathan Nieder'" <jrnieder@gmail.com>,
        "=?utf-8?Q?'Torsten_B=C3=B6gershausen'?=" <tboegi@web.de>
Cc:     "'Robert Dailey'" <rcdailey.lists@gmail.com>,
        "'Git'" <git@vger.kernel.org>
References: <CAHd499APYCH2r2=+M_AGKUzN0GDmrwDty4wK=Xy-utCdMrd56w@mail.gmail.com> <20180830045407.GB140348@aiede.svl.corp.google.com> <CAHd499BCk4Q4oPY=CXK=YrUbNUbz4J_KoeQngfz=92Qfc6q=eA@mail.gmail.com> <20180830185648.GA10427@tor.lan> <20180831032917.GC98946@aiede.svl.corp.google.com>
In-Reply-To: <20180831032917.GC98946@aiede.svl.corp.google.com>
Subject: RE: Automatic core.autocrlf?
Date:   Fri, 31 Aug 2018 07:57:04 -0400
Message-ID: <000c01d44121$bf563090$3e0291b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGf5k4RNUrSErA8PPJ17nKsTt01gQG5m0ftAtjVNywBoDqgoQGrPFX8pQOGk3A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On August 30, 2018 11:29 PM, Jonathan Nieder wrote:
> Torsten Bögershausen wrote:
> 
> > My original plan was to try to "make obsolete"/retire and phase out
> > core.autocrlf completely.
> > However, since e.g. egit/jgit uses it
> > (they don't have support for .gitattributes at all) I am not sure if
> > this is a good idea either.
> 
> Interesting.  [1] appears to have intended to add this feature.
> Do you remember when it is that you tested?
> 
> Feel free to file bugs using [2] for any missing features.
> 
> [1] https://git.eclipse.org/r/c/60635
> [2] https://www.eclipse.org/jgit/support/

My testing was done on EGit 5.0.1 yesterday, which does not provide a default to core.autocrlf.

Cheers,
Randall

