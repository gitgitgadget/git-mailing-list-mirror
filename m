Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A0820FCF
	for <e@80x24.org>; Fri,  1 Jul 2016 10:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbcGAKJv (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 06:09:51 -0400
Received: from plane.gmane.org ([80.91.229.3]:48727 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400AbcGAKJu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 06:09:50 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bIvOO-0001Hc-QO
	for git@vger.kernel.org; Fri, 01 Jul 2016 12:09:49 +0200
Received: from 147.114.44.208 ([147.114.44.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 12:09:48 +0200
Received: from ioannis.kappas by 147.114.44.208 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 12:09:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ioannis Kappas <ioannis.kappas@rbs.com>
Subject: Re: git svn clone segmentation faul issue
Date:	Fri, 1 Jul 2016 10:09:31 +0000 (UTC)
Message-ID: <loom.20160701T120539-937@post.gmane.org>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net> <alpine.DEB.2.20.1606281334450.12947@virtualbox> <alpine.DEB.2.20.1606281530420.12947@virtualbox> <loom.20160628T175016-898@post.gmane.org> <alpine.DEB.2.20.1606281825190.12947@virtualbox> <alpine.DEB.2.20.1606290911040.12947@virtualbox> <loom.20160629T104814-936@post.gmane.org> <alpine.DEB.2.20.1606291341530.12947@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 147.114.44.208 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> [...]
> 
> My more immediate concern is MSYS2 (the POSIX-emulating basis of Git 
for
> Windows), and I opened a Pull Request there:
> 
> 	https://github.com/Alexpux/MSYS2-packages/pull/647
> 
> If this Pull Request is not picked up in time for the next Git for 
Windows
> version, I plan to use the packages that you tested.

The patch has also been accepted for inclusion in the forthcoming 
subversion 1.9.5 release ("barring unexpectancies"):

http://thread.gmane.org/gmane.comp.version-
control.subversion.user/120144/focus=120146

Thanks,
Yannis

> 
> Thanks,
> Dscho
> 




