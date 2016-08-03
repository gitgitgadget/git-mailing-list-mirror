Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 685F91F855
	for <e@80x24.org>; Wed,  3 Aug 2016 10:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757381AbcHCKQV (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 06:16:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55984 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757651AbcHCKQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 06:16:17 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5813586647
	for <git@vger.kernel.org>; Wed,  3 Aug 2016 10:16:16 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-59.phx2.redhat.com [10.3.116.59])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u73AGFIS025830
	for <git@vger.kernel.org>; Wed, 3 Aug 2016 06:16:15 -0400
To:	public git mailing list <git@vger.kernel.org>
From:	Laszlo Ersek <lersek@redhat.com>
Subject: appending a pattern to the default "diff.cpp.xfuncname"
Message-ID: <40ceebb8-b343-a5ca-e7ff-23cccc181528@redhat.com>
Date:	Wed, 3 Aug 2016 12:16:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 03 Aug 2016 10:16:16 +0000 (UTC)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

I've used diff.<TYPE>.xfuncname with great success for file <TYPE>s that
I defined myself. However, now I would like to append an extra pattern
to the TYPE=cpp case (for which git has builtin patterns). Is there an
easy way to do this?

I figured I could open-code the builtin patterns from "userdiff.c", and
then append my new pattern to those, but it looks kinda gross :)

Thanks!
Laszlo
