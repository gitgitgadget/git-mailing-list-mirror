From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 13:49:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504291338540.18901@ppc970.osdl.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org>
 <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1>
 <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org>
 <20050429163705.GU21897@waste.org> <Pine.LNX.4.58.0504291006450.18901@ppc970.osdl.org>
 <20050429191207.GX21897@waste.org> <Pine.LNX.4.58.0504291248210.18901@ppc970.osdl.org>
 <20050429202341.GB21897@waste.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 22:43:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRcKD-0000bY-Fi
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVD2UsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbVD2UsK
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:48:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:44442 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262963AbVD2Ur1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 16:47:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3TKlJs4004973
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 29 Apr 2005 13:47:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3TKlIqG003590;
	Fri, 29 Apr 2005 13:47:19 -0700
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050429202341.GB21897@waste.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 29 Apr 2005, Matt Mackall wrote:
> 
> The changeset log (and everything else) has an external index.

I don't actually know exactly how the BK changeset file works, but your 
explanation really sounds _very_ much like it.

I didn't want to do anything that even smelled of BK. Of course, part of
my reason for that is that I didn't feel comfortable with a delta model at
all (I wouldn't know where to start, and I hate how they always end up
having different rules for "delta"ble and "non-delta"ble objects).

But another was that exactly since I've been using BK for so long, I
wanted to make sure that my model just emulated the way I've been _using_
BK, rather than any BK technical details.

So it sounds like it could work fine, but it in fact sounds so much like 
the ChangeSet file that I'd personally not have done it that way. 

			Linus
