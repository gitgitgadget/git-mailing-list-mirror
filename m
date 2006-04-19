From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] sha1_name.c: no need to include diff.h; tree-walk.h will
 do.
Date: Wed, 19 Apr 2006 13:50:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604191348230.3701@g5.osdl.org>
References: <7v1wvt8hdb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 22:51:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWJdZ-0000XE-9m
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 22:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWDSUuy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 16:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWDSUux
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 16:50:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8097 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751087AbWDSUuw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 16:50:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3JKomtH008145
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Apr 2006 13:50:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3JKomsk001707;
	Wed, 19 Apr 2006 13:50:48 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wvt8hdb.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18938>



On Wed, 19 Apr 2006, Junio C Hamano wrote:
>
>  * Just a clean-up, comes on top of the one that returns mode
>    from get_tree_entry().

Ack (along with the mode addition).

However, since the function is now no longer private to the SHA1 name 
lookup, I wonder if it might not be more logically put into "tree-walk.c" 
instead of "sha1_name.c".

Just a thought.

		Linus
