From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Wed, 14 Sep 2005 13:27:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509141325310.26803@g5.osdl.org>
References: <20050914124206.GC24405@master.mivlgu.local>
 <7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sergey Vlasov <vsu@altlinux.ru>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 22:30:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFdr1-00086s-FX
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 22:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVINU13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 16:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVINU13
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 16:27:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30600 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932471AbVINU12 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 16:27:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8EKREBo015556
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 14 Sep 2005 13:27:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8EKRCvi023792;
	Wed, 14 Sep 2005 13:27:13 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8560>



On Wed, 14 Sep 2005, Junio C Hamano wrote:
> 
> Thanks for the patch.

This is wrong.

Any "fetch" logic that writes the refs before all the objects are gathered 
is _buggy_. It's not about "recovery", it should never do that in the 
first place.

Is it just the http one that is this broken?

		Linus
