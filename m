From: Kate Rhodes <masukomi@gmail.com>
Subject: Re: simple cvs-like git wrapper
Date: Fri, 1 Feb 2008 08:05:56 -0500
Message-ID: <1201871157.D6625E4@ea26.dngr.org>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain> <20080130021050.GB9612@venus>
Reply-To: Kate Rhodes <masukomi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ed S. Peschko" <esp5@pge.com>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 14:07:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKvbE-0004ti-V6
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 14:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759234AbYBANGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 08:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758931AbYBANF7
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 08:05:59 -0500
Received: from mta9.prod1.dngr.net ([216.220.209.219]:59016 "EHLO
	mta1.prod1.dngr.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758214AbYBANF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 08:05:59 -0500
Received: from prod.danger.com (unknown [10.253.33.100])
	by px09.prod1.dngr.org (Postfix) with ESMTP id 3FCA831DD3F;
	Fri,  1 Feb 2008 05:05:58 -0800 (PST)
Received: from [10.253.33.100] (HELO localhost.localdomain)
  by mfe8.prod.danger.com (CommuniGate Pro SMTP 5.1.8)
  with ESMTP id 1597150; Fri, 01 Feb 2008 05:05:58 -0800
X-Mailer: Danger Service
X-Danger-Send-Id: AAAbzkejGTYAAYap 
In-Reply-To: <20080130021050.GB9612@venus>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72169>

I'm leaning towards agreement with Shawn that you're a little confused 
as to how syncing works or you're not adequately expressing what you're 
really hoping for and why git isn't doing it and we're misunderstanding 
you.

Regardless, if you're looking for something that will pull down all the 
updates from a central branch, merge them in, and then rebase your 
current changes on top of it you should check out how git-p4 does it in 
order to get the basic mechanics for your script.

~kate = masukomi
http://weblog.masukomi.org
