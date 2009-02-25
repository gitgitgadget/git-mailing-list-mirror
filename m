From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Files different for me
Date: Wed, 25 Feb 2009 12:05:54 -0500
Message-ID: <7E43550E-68B7-4B22-A83C-F840A7037CA9@silverinsanity.com>
References: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 18:07:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcNEE-0004wP-9E
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 18:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbZBYRF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 12:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbZBYRF6
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 12:05:58 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:41770 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbZBYRF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 12:05:58 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id F1CE71FFC3A2; Wed, 25 Feb 2009 17:05:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb3
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 2BC891FFC3A0;
	Wed, 25 Feb 2009 17:05:51 +0000 (UTC)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709E047DE@EXCHANGE.trad.tradestation.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111469>


On Feb 25, 2009, at 11:11 AM, John Dlugosz wrote:

> I'm working with a group, and using git for source code.  I need to  
> change a couple files temporarily and just for me.  I thought,  
> "that's easy", just don't stage them when I check in changes.  But,  
> what do I do when I pull changes from others?  I think it will  
> complain that I have unsaved changes.
> What's the best way to do this?

Generally when I keep changes like this, I make a commit called "Local  
Changes" or similar and have branch.master.rebase set to true so that  
my changes get rebased on top of origin when I pull.

~~ Brian
