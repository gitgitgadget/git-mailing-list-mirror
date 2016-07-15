Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D9E4203C1
	for <e@80x24.org>; Fri, 15 Jul 2016 08:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbcGOIpv (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 04:45:51 -0400
Received: from mailrelay2.pub.mailoutpod1-wdc1.one.com ([104.37.35.57]:63028
	"EHLO mailrelay2.pub.mailoutpod1-wdc1.one.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751486AbcGOIpu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jul 2016 04:45:50 -0400
X-HalOne-Cookie: 5318901d3d13b24e74277d9cefc533288658b0e4
X-HalOne-ID: 8734b867-4a68-11e6-91e6-549f35fe4221
Received: from t430.localnet (unknown [5.186.121.171])
	by mailrelay1.pub.mailoutpod1-wdc1.one.com (Halon Mail Gateway) with ESMTPSA
	for <git@vger.kernel.org>; Fri, 15 Jul 2016 08:45:48 +0000 (UTC)
From:	"Morten W. J." <morten@winkler.dk>
To:	git@vger.kernel.org
Subject: Two consecutive clones of a remote produces different files
Date:	Fri, 15 Jul 2016 10:45:47 +0200
Message-ID: <2183637.OVprKRVBmt@t430>
User-Agent: KMail/5.0.2 (Linux/4.2.0-38-generic; KDE/5.15.0; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi All.

I have experienced something weird today. 

I have a repository hosted on a GitLab server on my LAN and when I clone that 
repository to a linux box and a windows box I get different files!

It is very hard to explain in words, so I have recorded my desktop while 
reproducing it, which I can do consistently:

https://dl.dropboxusercontent.com/u/5234017/git-clone-produces-different-results.ogv

I have no ideas what is wrong or why it behaves the way it does, but I am 
actually pretty scared now. The repository has been updated from as a subtree 
from another repository, but that should not create such behavior?

Can anybody give me some hints on what may be wrong and how I might get 
identical clones again?


Cheers,
    Morten
