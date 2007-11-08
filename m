From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 8 Nov 2007 13:38:03 -0500
Message-ID: <DE41BBF5-DD69-4A6B-97EE-ED42C8B1B616@silverinsanity.com>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net> <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de> <4732D2CC.1010008@viscovery.net> <4732D7F6.7040006@op5.se> <4732DC98.70304@viscovery.net> <97F64156-A457-4BC1-84BE-108369FFD18C@zib.de> <5498B368-053A-424E-B901-A55B66FF5801@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Andreas Ericsson <ae@op5.se>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Nov 08 19:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqCHD-0008Kt-O7
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 19:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761079AbXKHSiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 13:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761119AbXKHSiJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 13:38:09 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:46566 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760798AbXKHSiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 13:38:07 -0500
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 854801FFC10F;
	Thu,  8 Nov 2007 18:38:05 +0000 (UTC)
In-Reply-To: <5498B368-053A-424E-B901-A55B66FF5801@lrde.epita.fr>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64061>


On Nov 8, 2007, at 9:51 AM, Benoit Sigoure wrote:

> You're missing the point.  Johannes suggested that you rebase *only*  
> for bisecting purpose.  Once you find the culprit commit, throw away  
> your rebased stuff.  I've never thought about doing this myself, but  
> it's a very clever way of tackling this problem.  It's slightly less  
> convenient if you need to bisect a large portion of the history  
> (that involves many branches and merges) because in this case we'd  
> like to have a magic git-linearize-history <start-treeish> <end- 
> treeish>.  Unless this is already easily doable with git-rebase?


I don't think you have to linearize it before bisecting.  If you  
bisect and discover that it was due to a merge, then you can rebase  
*that merge* to discover what part of the merge caused the issue.

~~ Brian
