Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B23001F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 18:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfJKSRR (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 14:17:17 -0400
Received: from mail.fsf.org ([209.51.188.13]:47824 "EHLO mail.fsf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbfJKSRR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 14:17:17 -0400
X-Greylist: delayed 2456 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Oct 2019 14:17:17 EDT
Received: from mail.iankelling.org ([72.14.176.105]:41446)
        by mail.fsf.org with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <iank@fsf.org>)
        id 1iIypu-0007S1-5d; Fri, 11 Oct 2019 13:36:18 -0400
Received: from iank by mail.iankelling.org with local (Exim 4.90_1)
        (envelope-from <iank@fsf.org>)
        id 1iIyps-0007NO-Oo; Fri, 11 Oct 2019 13:36:16 -0400
References: <20191010062047.21549-1-ajd@linux.ibm.com>
 <c942d9ce-d8fe-32ca-bedd-1cdb3837823d@linux.ibm.com>
 <7c2f16e3-1397-9ced-e334-a52e99b27e9b@linux.ibm.com>
 <6574162.ouEm0onZRE@silver>
User-agent: mu4e 1.1.0; emacs 27.0.50
From:   Ian Kelling <iank@fsf.org>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        patchwork@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eric Blake <eblake@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled
 for DMARC purposes
In-reply-to: <6574162.ouEm0onZRE@silver>
Date:   Fri, 11 Oct 2019 13:36:16 -0400
Message-ID: <871rvjdw1b.fsf@fsf.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by mail.fsf.org: GNU/Linux 2.2.x-3.x [generic] [fuzzy]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Christian Schoenebeck <qemu_oss@crudebyte.com> writes:

> 4. MTA's should also address this DKIM issue more accurately.

I agree that Exim should be changed as you suggest.

>
> By taking these things into account, emails of domains with strict DMARC 
> policies are no longer munged on gnu lists.

Additional info: Migration of many gnu/nongnu.gnu.org lists is still in
progress for another week or so, then that will be true for most of
them. For a minority of lists, the list administrators have set weird
settings like making all messages have from: rewritten as from this
list, and we are leaving them as is since the list administrators opted
in to that at some point. But if the list deals with patches and not
modifying the headers is useful to the people on the list, I think a
request to change the list settings is likely to be accepted by the list
admin.

-- 
Ian Kelling | Senior Systems Administrator, Free Software Foundation
GPG Key: B125 F60B 7B28 7FF6 A2B7  DF8F 170A F0E2 9542 95DF
https://fsf.org | https://gnu.org
