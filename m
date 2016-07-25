Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D56203C1
	for <e@80x24.org>; Mon, 25 Jul 2016 06:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbcGYGz7 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 02:55:59 -0400
Received: from plane.gmane.org ([80.91.229.3]:42228 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131AbcGYGz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 02:55:57 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bRZnv-00089k-0B
	for git@vger.kernel.org; Mon, 25 Jul 2016 08:55:55 +0200
Received: from 193.5.216.100 ([193.5.216.100])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 08:55:54 +0200
Received: from dev+git by 193.5.216.100 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jul 2016 08:55:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Beat Bolli <dev+git@drbeat.li>
Subject: Re: Bug: 
Date:	Mon, 25 Jul 2016 06:55:41 +0000 (UTC)
Message-ID: <loom.20160725T085326-574@post.gmane.org>
References: <8915446.47C9zkNvuX@photon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.5.216.100 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ilya Tumaykin <itumaykin <at> gmail.com> writes:

> $ git --no-pager log -1 --format='format:%+s%+b'
> Please fix.

Simply use `git --no-pager log -1 --format='format:%+s%n%+b'`

The message body excludes the empty line preceding it.





