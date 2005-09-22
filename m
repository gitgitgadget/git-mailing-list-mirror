From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 'bad file' error updating from Linus
Date: Thu, 22 Sep 2005 16:32:22 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509221630200.2553@g5.osdl.org>
References: <dgu56t$d2p$1@sea.gmane.org> <509c8057050922054272b823fe@mail.gmail.com>
 <dgv8jv$amv$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 01:32:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIaYe-0006Vz-Tm
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 01:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbVIVXc2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 19:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVIVXc2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 19:32:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751140AbVIVXc1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 19:32:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8MNWPBo022062
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 22 Sep 2005 16:32:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8MNWMBW027090;
	Thu, 22 Sep 2005 16:32:24 -0700
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dgv8jv$amv$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9152>



On Thu, 22 Sep 2005, walt wrote:
> 
> I think it was a disk failure, but no matter -- it's fixed now.

Nope, it's not.

It just depends on which IP address you happen to get when you look at 
www.kernel.org.

www.kernel.org resolves to two addresses:

	Name:   zeus-pub.kernel.org
	Address: 204.152.191.5
	Name:   zeus-pub.kernel.org
	Address: 204.152.191.37

and the .5 address is working, but the .37 address has the broken mirror.

I thought hpa took it out of service while it was re-syncing, but 
apparently not. 

		Linus
