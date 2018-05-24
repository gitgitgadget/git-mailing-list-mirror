Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793081F42D
	for <e@80x24.org>; Thu, 24 May 2018 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970839AbeEXPLk (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 11:11:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S968131AbeEXPLj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 11:11:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0ADF640201A8;
        Thu, 24 May 2018 15:11:39 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-117-98.ams2.redhat.com [10.36.117.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C59DE2156601;
        Thu, 24 May 2018 15:11:37 +0000 (UTC)
Subject: Re: [PATCH v2] rev-parse: check lookup'ed commit references for NULL
To:     Todd Zullinger <tmz@pobox.com>, Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com,
        B.Steinbrink@gmx.de, sbejar@gmail.com
References: <20180523220915.GB32171@sigill.intra.peff.net>
 <20180524062733.5412-1-newren@gmail.com>
 <20180524140454.GC26695@zaya.teonanacatl.net>
From:   Florian Weimer <fweimer@redhat.com>
Message-ID: <291c385c-c1e5-8c26-fa10-a59b342751ff@redhat.com>
Date:   Thu, 24 May 2018 17:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524140454.GC26695@zaya.teonanacatl.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 24 May 2018 15:11:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 24 May 2018 15:11:39 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'fweimer@redhat.com' RCPT:''
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/24/2018 04:04 PM, Todd Zullinger wrote:
> I added Florian to Cc, in case he wants to provide a
> preferred address.

Sorry, using this address is fine.

Thanks,
Florian
