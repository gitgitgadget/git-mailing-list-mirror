From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-unpack-objects
Date: Wed, 3 May 2006 10:56:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605031054300.4086@g5.osdl.org>
References: <625fc13d0605011552j4189338bx14083657acffc18e@mail.gmail.com> 
 <7vu089qr4t.fsf@assigned-by-dhcp.cox.net>  <625fc13d0605031035l721ab08dmee6f870abb49f4e4@mail.gmail.com>
  <Pine.LNX.4.64.0605031041150.4086@g5.osdl.org>
 <625fc13d0605031044y2ff03ed2h261db5455b234254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 19:56:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbLag-00017j-KK
	for gcvg-git@gmane.org; Wed, 03 May 2006 19:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWECR4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 13:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWECR4n
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 13:56:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750870AbWECR4n (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 13:56:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k43HuctH010054
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 10:56:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k43Hub9g008854;
	Wed, 3 May 2006 10:56:37 -0700
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <625fc13d0605031044y2ff03ed2h261db5455b234254@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19509>



On Wed, 3 May 2006, Josh Boyer wrote:
> > 
> > That's what you just do "git repack -a -d" for.
> 
> But that doesn't roll exsisting packs into a new pack, does it? 

It does. That's what the "-a" (for "all") does.

I don't personally do incremental packs at all - the full repack is fast 
enough on the hardware I use (especially since Junio just kicked it into 
some serious performance shape) that I don't have the need for 
incrementals. 

		Linus
