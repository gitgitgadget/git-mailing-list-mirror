From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Add expat and expat-devel dependencies (for http-push)
 to RPM spec.
Date: Sun, 13 Nov 2005 12:51:03 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511131248190.3263@g5.osdl.org>
References: <4376C797.3050600@matysik.co.nz> <Pine.LNX.4.64.0511130942490.3263@g5.osdl.org>
 <437788A0.6030103@op5.se> <Pine.LNX.4.64.0511131137470.3263@g5.osdl.org>
 <4377A3E1.7070003@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 21:52:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbOoi-0001GG-7A
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 21:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbVKMUvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 15:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbVKMUvI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 15:51:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14493 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750900AbVKMUvH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 15:51:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jADKp4nO008294
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 13 Nov 2005 12:51:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jADKp4hL015795;
	Sun, 13 Nov 2005 12:51:04 -0800
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4377A3E1.7070003@op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11751>



On Sun, 13 Nov 2005, Andreas Ericsson wrote:
> 
> I *think* the ssh transport should work nicely over rsh as well. I don't have
> the slightest idea of where to find an rsh installation to test it with
> though.

You're right, it should be possible to just do a

	export GIT_SSH=rsh

and things should just work.

But I don't have any machines that allow rsh either ;)

		Linus
