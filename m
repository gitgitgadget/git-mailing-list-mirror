From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 12:22:34 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 21:22:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdCl6-0005Cn-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161171AbVKRUWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbVKRUWx
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:22:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161171AbVKRUWx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 15:22:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAIKMdnO027502
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 12:22:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAIKMZ3Q030364;
	Fri, 18 Nov 2005 12:22:37 -0800
To: Ismail Donmez <ismail@uludag.org.tr>
In-Reply-To: <200511182208.24248.ismail@uludag.org.tr>
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12254>



On Fri, 18 Nov 2005, Ismail Donmez wrote:
> 
> > And git guys, please start to think again about your insane options,
> > that cause more harm than anything good.
> 
> Can git maintainer(s) comment on this please? 

It's easy to say "just do the right thing", and ignore reality.

git commit logs have always been "8-bit data". It's actually gitweb that 
is buggy if it claims it is UTF-8 without checking or converting it to 
such.

I agree that UTF-8 is a good idea, but that's a totally different 
argument.

		Linus
