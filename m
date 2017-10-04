Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D91220281
	for <e@80x24.org>; Wed,  4 Oct 2017 08:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbdJDIog (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 04:44:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751736AbdJDIoe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 04:44:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8961F5F7BC
        for <git@vger.kernel.org>; Wed,  4 Oct 2017 08:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 8961F5F7BC
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx10.extmail.prod.ext.phx2.redhat.com; spf=fail smtp.mailfrom=fweimer@redhat.com
Received: from oldenburg.str.redhat.com (ovpn-116-181.ams2.redhat.com [10.36.116.181])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DFA060F81
        for <git@vger.kernel.org>; Wed,  4 Oct 2017 08:44:33 +0000 (UTC)
To:     git@vger.kernel.org
From:   Florian Weimer <fweimer@redhat.com>
Subject: Is git am supposed to decode MIME?
Message-ID: <24940e12-3f72-1ef0-0983-58523d8dec51@redhat.com>
Date:   Wed, 4 Oct 2017 10:44:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 04 Oct 2017 08:44:34 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git am documentation talks about “mailboxes”.  I suppose these 
contain messages in Internet Mail syntax.  Is git am supposed to decode 
MIME?

I'm asking because I have a message whose body is encoded as 
quoted-printable, but git am does not parse the patch contained in it.

If git am is supposed to deal with this, I'll dig deeper and try to 
figure out where things go wrong.

Thanks,
Florian
