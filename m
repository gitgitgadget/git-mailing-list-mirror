From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch
 content
Date: Fri, 27 Apr 2007 17:20:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704271719240.9964@woody.linux-foundation.org>
References: <ps5qyry4.fsf@cante.net> <7vslalmwcx.fsf@assigned-by-dhcp.cox.net>
 <87y7kdo6pn.wl%cworth@cworth.org> <alpine.LFD.0.98.0704271430490.9964@woody.linux-foundation.org>
 <87wszxo2b5.wl%cworth@cworth.org> <alpine.LFD.0.98.0704271636130.9964@woody.linux-foundation.org>
 <87tzv1nzd4.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Jari Aalto <jari.aalto@cante.net>,
	git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Sat Apr 28 02:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhagX-0006BV-So
	for gcvg-git@gmane.org; Sat, 28 Apr 2007 02:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959AbXD1AVF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 20:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757956AbXD1AVE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 20:21:04 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:51174 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757960AbXD1AVB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2007 20:21:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3S0Kna0025534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 Apr 2007 17:20:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3S0KmJZ011407;
	Fri, 27 Apr 2007 17:20:48 -0700
In-Reply-To: <87tzv1nzd4.wl%cworth@cworth.org>
X-Spam-Status: No, hits=-3.002 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45763>



On Fri, 27 Apr 2007, Carl Worth wrote:
> > And the reason I _hate_ attachements is that you cannot say "no, that one
> > is wrong", and just skip/edit it.
> 
> Well, skipping it while applying the rest is bad form anyway, isn't
> it?

Why would it be?

Maybe for small projects with strictly linear development, but I get a 
_lot_ of patch-series where the patches are independent of each other. 
Andrew's patch-series are one example, but so is a lot of the "trivial 
tree" patch-series too.

			Linus
