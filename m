From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 08:08:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511300808350.3099@g5.osdl.org>
References: <20051130001503.28498.qmail@science.horizon.com>
 <Pine.LNX.4.64.0511291742000.3135@g5.osdl.org> <7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511291852530.3099@g5.osdl.org> <Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
 <7vslte1y5z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 17:56:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhUWT-0001cy-LG
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 17:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbVK3QJb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 11:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbVK3QJb
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 11:09:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45759 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751429AbVK3QJa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 11:09:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAUG90nO015984
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 30 Nov 2005 08:09:01 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAUG8xxj027237;
	Wed, 30 Nov 2005 08:09:00 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslte1y5z.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13005>



On Tue, 29 Nov 2005, Junio C Hamano wrote:
> 
> About #3, I am not quite sure.  I often use --name-status and I
> do _not_ want -p to kick in when I do so.  How about something
> like this?

Yes. I was thinking about something like that, but I decided it was too 
much work ;)

		Linus
