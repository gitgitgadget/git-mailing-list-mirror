From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb.cgi
Date: Wed, 19 Oct 2005 06:59:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510190655230.3369@g5.osdl.org>
References: <43546492.3020401@zytor.com> <20051018110725.GB6929@vrfy.org>
 <43552FC2.3000000@zytor.com> <Pine.LNX.4.64.0510181645200.3369@g5.osdl.org>
 <43559575.1060902@zytor.com> <Pine.LNX.4.64.0510181753340.3369@g5.osdl.org>
 <43559DFE.7060503@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 16:00:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESETf-0007eO-Hk
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 15:59:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbVJSN7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 09:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbVJSN7c
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 09:59:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750975AbVJSN7b (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 09:59:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9JDxTFC016446
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Oct 2005 06:59:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9JDxSJe001716;
	Wed, 19 Oct 2005 06:59:29 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43559DFE.7060503@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10289>



On Tue, 18 Oct 2005, H. Peter Anvin wrote:
> 
> Yes, but I did that.  It seems very strange when something hits the cache.  A
> cgi script can apparently be run quite a few number of times before mod_cache
> sees it globally.

Well, I tried again this morning, and _boy_ is it better. The "projects" 
thing came up immediately, no waiting. 

Maybe it just took a while for the mod_cache thing to take effect as 
Apache swarm members time out? 

Or maybe it's just that the west coast is really quiet at 7AM.

		Linus
