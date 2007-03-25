From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: merge strategy request
Date: Sat, 24 Mar 2007 21:31:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703242130050.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz>
 <Pine.LNX.4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Lang <david.lang@digitalinsight.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 25 06:32:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVKOk-0000Al-PC
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 06:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbXCYEb4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 00:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbXCYEbz
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 00:31:55 -0400
Received: from smtp.osdl.org ([65.172.181.24]:58752 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965095AbXCYEby (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 00:31:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2P4Vk1o018397
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Mar 2007 21:31:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2P4VjtQ020535;
	Sat, 24 Mar 2007 21:31:46 -0700
In-Reply-To: <Pine.LNX.4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43031>



On Sun, 25 Mar 2007, Johannes Schindelin wrote:
> 
> Basically, just write a program named "git-merge-david-lang", which takes 
> arguments of the form
> 
> 	merge-base [merge-base2...] -- head remote [remote...]

I think you are missing what David wants.

David does *not* want a new global strategy. Adding those is fairly easy.

David seem sto want a new per-file merge strategy, with the bog-standard 
recursive merge. We've talked about that possibility in the past, but we 
don't do it now. We always end up doing just the three-way merge.

		Linus
