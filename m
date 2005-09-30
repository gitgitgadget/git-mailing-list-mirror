From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [howto] Kernel hacker's guide to git, updated
Date: Fri, 30 Sep 2005 11:14:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0509301112100.3378@g5.osdl.org>
References: <433BC9E9.6050907@pobox.com> <20050929200252.GA31516@redhat.com>
 <433C4B6D.6030701@pobox.com> <7virwjegb5.fsf@assigned-by-dhcp.cox.net>
 <433D1E5D.20303@pobox.com> <7v64si4von.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932560AbVI3SOc@vger.kernel.org Fri Sep 30 20:17:49 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932560AbVI3SOc@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELPPy-000592-3L
	for glk-linux-kernel-3@gmane.org; Fri, 30 Sep 2005 20:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVI3SOc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 30 Sep 2005 14:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVI3SOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:14:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55012 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932560AbVI3SOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:14:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8UIEN4s012564
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Sep 2005 11:14:23 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8UIEM21016189;
	Fri, 30 Sep 2005 11:14:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64si4von.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9569>



On Fri, 30 Sep 2005, Junio C Hamano wrote:
> 
> I suspect the version Linus posted has a funny interaction with
> 'git-pull'; 'git pull --tags' by mistake, or intentionally to
> file a bug report to annoy me ;-), would create an Octopus out
> of those tags, if I am not mistaken.

Hey, even more impressive is "git pull --all", which will happily try to 
create an octopus of every single ref available at the other end.

Now, I think that octopus merges in _general_ are likely to be driver 
error, and that it might make sense to have a separate flag to enable 
them in the first place. That would solve the confusion..

So then you could do

	git pull --all --octopus xyzzy

if you _really_ meant to do that. 

		Linus
