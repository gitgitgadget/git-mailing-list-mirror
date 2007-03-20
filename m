From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git 1.5.1-rc1 doesn't like empty files
Date: Tue, 20 Mar 2007 08:46:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703200846110.6730@woody.linux-foundation.org>
References: <1174361424.3143.42.camel@dv> <7vslc0bhz7.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0703192245490.6730@woody.linux-foundation.org>
 <7v648wbgiy.fsf@assigned-by-dhcp.cox.net> <7v1wjkbgaj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 16:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTgXe-0001Ln-Hj
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 16:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbXCTPq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 11:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753371AbXCTPq1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 11:46:27 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43144 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753364AbXCTPq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 11:46:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2KFkMcD010586
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Mar 2007 08:46:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2KFkL9n003969;
	Tue, 20 Mar 2007 07:46:22 -0800
In-Reply-To: <7v1wjkbgaj.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42750>



On Mon, 19 Mar 2007, Junio C Hamano wrote:
> 
> By the way, I think the test that comes after the part you fixed
> is wrong (I know it is my bad without running git-blame).  Since
> we are making sure that we eat everything, we should expect
> Z_STREAM_END and no avail_in.

Ack.

		Linus
