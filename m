From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cleaner/better zlib sources?
Date: Thu, 15 Mar 2007 19:56:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703151955440.3816@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <45F9EED5.3070706@garzik.org> <Pine.LNX.4.64.0703151822490.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151848090.3816@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>,
	Git Mailing List <git@vger.kernel.org>, mpm@selenic.com,
	bcrl@kvack.org
To: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 03:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS2cQ-00083Z-S0
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 03:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbXCPC4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 22:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbXCPC4g
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 22:56:36 -0400
Received: from smtp.osdl.org ([65.172.181.24]:50755 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbXCPC4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 22:56:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2G2uKcD002944
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 15 Mar 2007 19:56:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2G2uJeJ000956;
	Thu, 15 Mar 2007 18:56:20 -0800
In-Reply-To: <Pine.LNX.4.64.0703151941090.4998@alien.or.mcafeemobile.com>
X-Spam-Status: No, hits=-0.485 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42317>



On Thu, 15 Mar 2007, Davide Libenzi wrote:
> 
> That's the diff against 1.2.3, but it does not seem to make an substantial 
> difference in my Opteron ...

But the "goto" stuff you did is 5-6%? 

Is that 5-6% of total git costs, or just of inflate() itself?

		Linus
