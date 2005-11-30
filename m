From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 08:13:32 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511300813190.3099@g5.osdl.org>
References: <20051130001503.28498.qmail@science.horizon.com>
 <Pine.LNX.4.64.0511291742000.3135@g5.osdl.org> <7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511291852530.3099@g5.osdl.org> <Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
 <7vslte1y5z.fsf@assigned-by-dhcp.cox.net> <7vek4y1x79.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 17:58:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhUb7-0004Ie-IV
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 17:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVK3QON (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 11:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVK3QOM
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 11:14:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7361 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751435AbVK3QOL (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 11:14:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAUGDanO016221
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 30 Nov 2005 08:13:36 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAUGDWw9027478;
	Wed, 30 Nov 2005 08:13:35 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek4y1x79.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13006>



On Tue, 29 Nov 2005, Junio C Hamano wrote:
> 
> Actually there is one.  If we are asked to do diff -1 and an
> unmerged path does not have stage #2 but stage #1 entry exists,
> we would end up showing that stage #1, without telling the user
> that we are showing something different from what was asked.
> How about doing something like this, on top of yours?

Yes.

		Linus
