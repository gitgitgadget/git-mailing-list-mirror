Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF2A81F97E
	for <e@80x24.org>; Sat, 24 Nov 2018 15:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbeKYCeE (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 21:34:04 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:59187 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeKYCeD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 21:34:03 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 432HZ842T1z1rZh3
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 16:45:20 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 432HZ83swqz1qqkn
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 16:45:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id zH_Tq2VgUyKL for <git@vger.kernel.org>;
        Sat, 24 Nov 2018 16:45:18 +0100 (CET)
Received: from hermia.goebel-consult.de (ppp-83-171-169-66.dynamic.mnet-online.de [83.171.169.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPS
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 16:45:18 +0100 (CET)
Received: from [192.168.110.2] (lenashee.goebel-consult.de [192.168.110.2])
        by hermia.goebel-consult.de (Postfix) with ESMTP id 0194D60175
        for <git@vger.kernel.org>; Sat, 24 Nov 2018 16:49:22 +0100 (CET)
To:     git@vger.kernel.org
From:   Hartmut Goebel <h.goebel@crazy-compilers.com>
Openpgp: preference=signencrypt
Organization: crazy-compilers.com
Subject: How to add edges to visualize cherry-picks and ported patches
Message-ID: <9469d243-46c6-bf94-2586-84c59b866733@crazy-compilers.com>
Date:   Sat, 24 Nov 2018 16:45:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksCgpJIGhvcGUgdGhpcyBpcyB0aGUgcmlnaHQgcGxhY2UgZm9yIHRoaXMgYW5zd2VyLiBJ
ZiBub3QsIHBsYWVzZSBwb2ludCBtZQp0byBhIG1vcmUgYXBwcm9wcmlhdGUgcGxhY2UuCgpB
IHByb2plY3TCoCAiUDIiIFsyXSBmb3JrZWQgZnJvbSBhbm90aGVyIHByb2plY3QgIlAxIiBb
MV3CoCBxdWl0ZSBzb21lCnRpbWUgYWdvLCBib3RoIHJlcG9zIHNoYXJlIGEgY29tbW9uIGhp
c3RvcnkgdXAgdG8gc29tZSBwb2ludC4gQWZ0ZXIgdGhpcwpwb2ludCwgUDIgY2hlcnJ5LXBp
Y2tlZCBjb21taXRzIGZyb20gUDEsIGJ1dCBkaWQgbm90IG1lcmdlIFAxIGFueQpsb25nZXIu
IFVuZm9ydHVuYXRlbHkgdGhlIGF1dGhvciBvZiBQMiBkaWQgbm90IHVzZSBhbnkgbWVjaGFu
aXNtIChlLmcuCmFuIGludGVybWVkaWF0ZSBicmFuY2gpIHRvIGFsbG93IHRyYWNraW5nIHVw
IHRvIHdoaWNoIHBvaW50IFAxIGNvbW1pdHMKYXJlIGNvbnNpZGVyZWQuIFRodXMgdGhlIGdy
YXBoIGxvb2tzIGxpa2UgdGhpczoKClAxOiAtLUEtLUItLUMtLVgtLVgtLUQtLUUtLVgtLVgt
LVgtLUYtLQoKUDI6IC0tWS0tWS0tQS0tQi0tQy0tRC0tRS0tWS0tRi0tCgpJIHdvdWxkIGxp
a2UgdG8gYWRkIGVkZ2VzIChzYXk6IGFub3RoZXIgYnJhbmNoIGFuZCBtZXJnZS1jb21taXRz
KSB0byB0aGUKZ3JhcGggdG8gbWFrZSBpdCBsb29rIHNvbWV0aGluZyBsaWtlIHRoaXM6CgpQ
MTrCoCDCoMKgwqAgLS1BLS1CLS1DLS1YLS1YLS1ELS1FLS1YLS1YLS1YLS1GLS0KwqDCoMKg
wqAgwqAgwqDCoCDCoMKgwqDCoMKgwqDCoCBcwqDCoMKgwqDCoMKgwqDCoMKgwqAgXMKgwqDC
oMKgwqDCoMKgwqDCoMKgIFwKwqDCoMKgwqDCoMKgwqDCoCDCoCDCoCDCoMKgwqDCoMKgIG8t
LS0tLS0tLS0tLW8tLS0tLS0tLS0tLW8tLS1uZXcgYnJhbmNoCsKgIMKgwqAgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC/CoMKgwqDCoMKgwqDCoMKgwqDCoCAvwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLwpQMjogLS1ZLS1ZLS1BLS1CLS1DLS0tLS0tLUQtLUUtLS0tWS0tLS0tLUYtLQoK
T2YgY291cnNlIHRoZSBuZXcgYnJhbmNoIHNob3VsZCBjb250YWluIHRoZSBzYW1lIGNvZGUg
YXMgdGhlIHJlc3BlY3RpdmUKUDItY29tbWl0LiBTbyBhdCB0aGUgZW5kLCB0aGUgbmV3IGJy
YW5jaCBjb3VscyBiZWNvbWUgdGhlIFAyJ3MgbmV3CiJtYXN0ZXIiIGJyYW5jaC4KCkhvdyBj
YW4gSSBhY2hpZXZlIHRoaXMgKHdoaWNoIGNvbW1hbmRzIHRvIHVzZSk/CgpJcyB0aGVyZSBz
b21lIHdheSB0byBhdXRvbWF0ZSB0aGlzPyAoZS5nLiBiYXNlZCBvbiBgZ2l0IGNoZXJyeWAp
CgpUaGFua3MgaW4gYWR2YW5jZSBmb3IgYW55IGFuc3dlcgoKWzFdIGh0dHBzOi8vZ2l0aHVi
LmNvbS9zaWFjcy9Db252ZXJzYXRpb25zClsyXSBodHRwczovL2dpdGh1Yi5jb20va3JpenRh
bi9QaXgtQXJ0LU1lc3NlbmdlcgoKLS0gClJlZ2FyZHMKSGFydG11dCBHb2ViZWwKCnwgSGFy
dG11dCBHb2ViZWwgICAgICAgICAgfCBoLmdvZWJlbEBjcmF6eS1jb21waWxlcnMuY29tICAg
ICAgICAgICAgICAgfAp8IHd3dy5jcmF6eS1jb21waWxlcnMuY29tIHwgY29tcGlsZXJzIHdo
aWNoIHlvdSB0aG91Z2h0IGFyZSBpbXBvc3NpYmxlIHwKCg==
