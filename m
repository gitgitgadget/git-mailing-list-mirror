From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] xread/xwrite: do not worry about EINTR at calling sites.
Date: Tue, 20 Dec 2005 10:59:41 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512201058570.4827@g5.osdl.org>
References: <7vhd95h02o.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512191142410.4827@g5.osdl.org> <43A732C9.2060509@zytor.com>
 <7vvexkpoxf.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512201136430.29711@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, "H. Peter Anvin" <hpa@zytor.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 20:02:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eomio-0004sg-7L
	for gcvg-git@gmane.org; Tue, 20 Dec 2005 20:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbVLTTAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Dec 2005 14:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVLTTAT
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Dec 2005 14:00:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41349 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751007AbVLTTAR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2005 14:00:17 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jBKIxhDZ025034
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 20 Dec 2005 10:59:43 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jBKIxfBo024849;
	Tue, 20 Dec 2005 10:59:42 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512201136430.29711@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13851>



On Tue, 20 Dec 2005, Johannes Schindelin wrote:
> 
> In another project I'm working on, a user insisted that on Solaris 2.7, 
> write(2) sometimes returns ENOENT when it really means "try again". I 
> cannot verify, since I don't have Solaris 2.7.

That would be either a very confused user or a terminally sick Solaris 
kernel. In either case, not worth fixing. 

		Linus
