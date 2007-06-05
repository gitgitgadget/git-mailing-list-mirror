From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git Vs. Svn for a project which *must* distribute binaries
 too.
Date: Mon, 4 Jun 2007 20:58:55 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706042057530.23741@woody.linux-foundation.org>
References: <5971b1ba0706040448i6e166031od1212192a549c4a9@mail.gmail.com> 
 <alpine.LFD.0.98.0706040755560.23741@woody.linux-foundation.org>
 <5971b1ba0706040838nc9ea7c7h54a57d4235d53bcf@mail.gmail.com>
 <Pine.LNX.4.64.0706041923580.22840@iabervon.org>
 <alpine.LFD.0.98.0706041715500.23741@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706041841010.6705@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Bryan Childs <godeater@gmail.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Tue Jun 05 05:59:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvQCd-0005zK-75
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 05:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758163AbXFED7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 23:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759902AbXFED7Q
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 23:59:16 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:50235 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758163AbXFED7P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2007 23:59:15 -0400
Received: from localhost (phoenix.linux-foundation.org [207.189.120.27])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l553x0Ah016577;
	Mon, 4 Jun 2007 20:59:01 -0700
In-Reply-To: <Pine.LNX.4.64.0706041841010.6705@asgard.lang.hm>
Received-SPF: neutral (207.189.120.27 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-3.109 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49152>



On Mon, 4 Jun 2007, david@lang.hm wrote:
> 
> if you put the binaries in a seperate repository and do shallow clones to
> avoid getting all the old stuff wouldn't that work well?

Yes. I'm not a huge fan of shallow clones, and I suspect they've not 
gotten all that much testing, but that would certainly solve the problem 
of getting unnecessarily much data..

		Linus
