Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D6CE1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 04:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731057AbfBMEYI (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 23:24:08 -0500
Received: from p3plsmtpa07-04.prod.phx3.secureserver.net ([173.201.192.233]:34996
        "EHLO p3plsmtpa07-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729725AbfBMEYI (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Feb 2019 23:24:08 -0500
Received: from jessie.local ([212.149.203.197])
        by :SMTPAUTH: with ESMTPSA
        id tm5cgVju8bpOptm5egTzGW; Tue, 12 Feb 2019 21:24:08 -0700
Date:   Wed, 13 Feb 2019 06:24:04 +0200
From:   Max Kirillov <max@max630.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Max Kirillov <max@max630.net>, Git List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2] pack-refs: fail on falsely sorted packed-refs
Message-ID: <20190213042404.GB3064@jessie.local>
References: <CAPig+cTn2gURyQgWHZQMNf2cZ+zwFhbH1Q4iPmbwuvYjMrPZPg@mail.gmail.com>
 <20190208212221.31670-1-max@max630.net>
 <CAPig+cSNoXQQrDDXt6yN-gbYc3P4ZEiwJL1nwQWBomyLdVm_Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSNoXQQrDDXt6yN-gbYc3P4ZEiwJL1nwQWBomyLdVm_Vg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-CMAE-Envelope: MS4wfOkZ20IxReBsSaTWqnsc2CfCmIi5DLf0l/JuoOcilVoft8pmYqlzVW3uGsbW8h7kwLJHP0XlS4m0t2NALRjLBHt9p2SJWP+ppVp+Rd+jaLGDsmvV+jIP
 0O4Wx/D9Fh8ZfRv+eXH3XrygkH1YOQ52mhRcqnXujAcH4YBSW+OmqqpuQpQGkhStfpTpVJgA/WGv3feKU5T7L73jVfeXDQd+F2iDI+KOXRoO+MPwq6W7QadE
 qsQfquWh0nhpK6cqbVCE4Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 08, 2019 at 04:40:28PM -0500, Eric Sunshine wrote:
> The call to strbuf_init() is leaking the allocated strbuf buffer each
> time through the loop. The typical way to re-use a strbuf, and the way
> you should do it here, is strbuf_reset().

Thank you! Will fix it
