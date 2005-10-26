From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: Wed, 26 Oct 2005 09:11:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510260910290.10477@g5.osdl.org>
References: <86y84gfjv4.fsf@blue.stonehenge.com> <86u0f4fjah.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 18:20:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUnsR-0000b2-U5
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 18:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVJZQLp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 12:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVJZQLp
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 12:11:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964802AbVJZQLo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 12:11:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9QGBgFC000499
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 26 Oct 2005 09:11:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9QGBfJN001831;
	Wed, 26 Oct 2005 09:11:41 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86u0f4fjah.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10677>



On Wed, 26 Oct 2005, Randal L. Schwartz wrote:
> 
> got it... a bit messy, but here it is:
> 
> Subject: [PATCH] fix for openbsd

I think we might as well do it for any error, and skip the test of the 
actual errno entirely.

		Linus
