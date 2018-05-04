Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48064200B9
	for <e@80x24.org>; Fri,  4 May 2018 13:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeEDNIB (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 09:08:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751199AbeEDNIA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 09:08:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F04AE8D778;
        Fri,  4 May 2018 13:07:59 +0000 (UTC)
Received: from [10.10.120.174] (ovpn-120-174.rdu2.redhat.com [10.10.120.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E57111166F4;
        Fri,  4 May 2018 13:07:54 +0000 (UTC)
Subject: cover letter cc's [was: [PATCH 60/67] hw/s390x: add include directory
 headers]
To:     Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
 <1525376963-79623-61-git-send-email-mst@redhat.com>
 <20180504091007.55405a6a.cohuck@redhat.com>
Cc:     qemu-devel@nongnu.org, berrange@redhat.com, kwolf@redhat.com,
        peter.maydell@linaro.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org,
        git@vger.kernel.org
From:   Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <be79d6dd-beaa-ba6f-2990-b5e91139411b@redhat.com>
Date:   Fri, 4 May 2018 08:07:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504091007.55405a6a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 04 May 2018 13:08:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 04 May 2018 13:08:00 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'eblake@redhat.com' RCPT:''
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[adding a cross-post to the git mailing list]

On 05/04/2018 02:10 AM, Cornelia Huck wrote:
> On Thu, 3 May 2018 22:51:40 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> This way they are easier to find using standard rules.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
...

> [Goes to find cover letter to figure out what this is all about.
> *Please*, cc: people on the cover letter so they can see immediately
> what this is trying to do!]

Is there an EASY way to make 'git format-patch --cover-letter $commitid' 
(and git send-email, by extension) automatically search for all cc's any 
any of the N/M patches, and auto-cc ALL of those recipients on the 0/N 
cover letter?  And if that is not something easily built into git 
format-patch directly, is it something that can easily be added to 
sendemail.cccmd?  This is not the first time that someone has complained 
that automatic cc's are not sending the cover letter context to a 
particular maintainer interested (and auto-cc'd) in only a subset of an 
overall series.

On the other hand, cc'ing all recipients for a largely mechanical patch 
series that was split into 67 parts, in part because it touches so many 
different maintainers' areas, may make the cover letter have so many 
recipients that various mail gateways start rejecting it as potential spam.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
