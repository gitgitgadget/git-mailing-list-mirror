Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A82451FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 13:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbcFTN0T (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 09:26:19 -0400
Received: from plane.gmane.org ([80.91.229.3]:59645 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524AbcFTN0O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 09:26:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bEyxp-0000vB-DO
	for git@vger.kernel.org; Mon, 20 Jun 2016 15:10:05 +0200
Received: from 37.220.140.46 ([37.220.140.46])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 15:10:05 +0200
Received: from istvan.zakar by 37.220.140.46 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 15:10:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Istvan Zakar <istvan.zakar@gmail.com>
Subject: Problem with --shallow-submodules option
Date:	Mon, 20 Jun 2016 13:06:39 +0000 (UTC)
Message-ID: <loom.20160620T145755-931@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 37.220.140.46 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello,

I'm working on a relatively big project with many submodules. During 
cloning for testing I tried to decrease the amount of data need to be 
fetched from the server by using --shallow-submodules option in the clone 
command. It seems to check out the tip of the remote repo, and if it's not 
the commit registered in the superproject the submodule update fails 
(obviously). Can I somehow tell to fetch that exact commit I need for my 
superproject?

Thanks,
   Istvan

