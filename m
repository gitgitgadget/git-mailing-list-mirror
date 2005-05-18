From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/1] Diff-helper update
Date: Wed, 18 May 2005 13:39:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505181338270.18337@ppc970.osdl.org>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org> <7v64xgpgb0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org>
 <Pine.LNX.4.58.0505181134470.18337@ppc970.osdl.org> <7vll6cnup4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, pasky@ucw.cz
X-From: git-owner@vger.kernel.org Wed May 18 22:37:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYVHr-0002WP-Ev
	for gcvg-git@gmane.org; Wed, 18 May 2005 22:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVERUhh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 16:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVERUhh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 16:37:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:54149 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262354AbVERUhb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 16:37:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4IKbIU3007762
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 May 2005 13:37:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4IKbHDP017457;
	Wed, 18 May 2005 13:37:17 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll6cnup4.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 18 May 2005, Junio C Hamano wrote:
> 
> I suspect doing something like this might be saner instead,
> assuming non raw-diffs come at the end.  

It won't ever trigger, since we only exit the loop once we see EOF.

So the non-diffs at the end will trigger by the exact same "oh, we didn't 
recognize it" logic.

		Linus
