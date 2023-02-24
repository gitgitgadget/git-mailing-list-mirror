Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC21C64ED6
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 03:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjBXDsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 22:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjBXDsY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 22:48:24 -0500
X-Greylist: delayed 918 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Feb 2023 19:48:20 PST
Received: from 163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D28A1632D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 19:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=K2lm2bLmWNLe2aPdEt3tPkz7t8PEOHYP7niqyopmllM=; b=k
        IWd8RmnJ5g6+LGYr7+sDD/5J3i6CqSUYg5pBolyyvZ3ZPyrlhSQPvxiSjuF0zs0W
        Xl0/dtMdLaksc1TW6g8hAWGnMoY3WcHHfraA7vJAi0VooKikQtJzh39AUjZP+k1e
        ZkoJm++n98RJS7R9hVLweXcW4CawEVpGp4fWRjAN3k=
Received: from 18994118902$163.com ( [183.255.48.209] ) by
 ajax-webmail-wmsvr56 (Coremail) ; Fri, 24 Feb 2023 11:31:52 +0800 (CST)
X-Originating-IP: [183.255.48.209]
Date:   Fri, 24 Feb 2023 11:31:52 +0800 (CST)
From:   "Zhang Yi" <18994118902@163.com>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     git@vger.kernel.org, v.garg.work@gmail.com
Subject: Re:Re: [GSOC] [PATCH v2 0/3] t9700:moderizen test scripts
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <xmqqo7pj3hi7.fsf@gitster.g>
References: <CADupsJPpZnjA=Pu_RZZZXy7Titj3UD7ppww48KvcHHHbrGx=rw@mail.gmail.com>
 <20230224013413.1969003-1-18994118902@163.com> <xmqqo7pj3hi7.fsf@gitster.g>
X-NTES-SC: AL_QuycBf6btk0q5CmcZ+kXn0oVgu88UcCzvPok34ZQOZk0uCrp8CctUVhtIXvP4smqCwSGlz+1YiJM6ctBZ5tmUom07C65KpmfHujd7+ylRil3
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <33d3469b.2a04.186817a2bf2.Coremail.18994118902@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: _____wC3KWmqL_hj7ZoQAA--.2010W
X-CM-SenderInfo: zprymmqurrmmmqsbiqqrwthudrp/1tbiGAcg-lv2k70tlQABs7
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

T2suIFRoYW5rcy4KClNvIEkgbmVlZCB0byBkbzoKCiogU3VtbWFyeSB0aGUgdXBkYXRlIGJldHdl
ZW4gdmVyc2lvbnMgaW4gdGhlIGNvdmVyIGxldHRlci4KKiBBZGQgc3BhY2UgYWZ0ZXIgY29sb24g
aW4gcGF0Y2ggdGl0bGVzLgoqIEFkZCBzcGFjZSBhZnRlciBmdWxsLXN0b3AgaW4gcHJvcG9zZWQg
bG9nIG1lc3NhZ2VzLiAKSnVzdCBsaWtlICJUaGUgc3R5bGUgb2YgdDk3MDAtcGVybC1naXQuc2gg
aXMgb2xkLiBUaGVyZSBhcmUgMyB0aGluZ3MgbmVlZCBpbXByb3ZlIi4KKiBDb21iaW5lIDMgcGF0
Y2hlcyBpbnRvIDEuCgpIb3BlIG5vIG1pc3VuZGVyc3RhbmRpbmcuIElmIHNvbWV0aGluZyB3cm9u
ZywgcGxlYXNlIGFkZHJlc3MgbWUuCgo=
