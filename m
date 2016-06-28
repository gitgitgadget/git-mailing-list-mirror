Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F0892018A
	for <e@80x24.org>; Tue, 28 Jun 2016 19:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbcF1TsI (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 15:48:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:54852 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbcF1TsH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 15:48:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24AEC2018A;
	Tue, 28 Jun 2016 19:48:04 +0000 (UTC)
Date:	Tue, 28 Jun 2016 19:48:04 +0000
From:	Eric Wong <e@80x24.org>
To:	Ioannis.Kappas@rbs.com
Cc:	git@vger.kernel.org
Subject: Re: git svn clone segmentation faul issue
Message-ID: <20160628194804.GA3653@dcvr.yhbt.net>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ioannis.Kappas@rbs.com wrote:
> Fortunately, a patch has already been submitted to subversion
> with (github) revision
> a074af86c8764404b28ce99d0bedcb668a321408 (at
> https://github.com/apache/subversion/commit/a074af86c8764404b28ce99d0bedcb668a321408
> ) on the trunk to handle this and a couple of other similar
> cases. But by the looks of it has not been picked up yet in
> the latest subversion 1.9.4 release or the 1.9.x branch,
> perhaps because this patch was identified in sanity checks
> rather than coming out from a perceivable production issue?

Thank you for documenting this.  Curious, does this affect older
SVN versions or only 1.9.x?

I don't know Perl internals well or SWIG at all; so reports
like these are very much appreciated.
