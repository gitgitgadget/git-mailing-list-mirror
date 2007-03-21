From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Be more careful about zlib return values
Date: Wed, 21 Mar 2007 08:29:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703210827591.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703201124260.6730@woody.linux-foundation.org>
 <7vodmn2eya.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 16:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU2lq-0006kN-Jr
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 16:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbXCUP3i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 11:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbXCUP3i
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 11:29:38 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40461 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332AbXCUP3g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 11:29:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2LFTWcD025824
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Mar 2007 08:29:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2LFTUVT028987;
	Wed, 21 Mar 2007 07:29:31 -0800
In-Reply-To: <7vodmn2eya.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42796>



On Wed, 21 Mar 2007, Junio C Hamano wrote:
> 
> I am observing a very curious performance regression with this
> patch.  I do not see anything obviously wrong correctness-wise
> nor performance-wise with it.

Ok, the test you are doing won't call the write function at all, so the 
performance effect you see is almost certainly due to [un]lucky I$ 
placement. It happens..

		Linus
