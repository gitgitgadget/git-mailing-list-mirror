From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Index/hash order
Date: Wed, 13 Apr 2005 14:04:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504131404380.4501@ppc970.osdl.org>
References: <20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com>
 <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com>
 <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org>
 <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org>
 <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com>
 <20050413201523.GC27088@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 23:06:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLp2v-0007Yw-ET
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 23:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVDMVIY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 17:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVDMVIY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 17:08:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:14470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261177AbVDMVIV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 17:08:21 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3DL8Hs4027641
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Apr 2005 14:08:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3DL2wS9018513;
	Wed, 13 Apr 2005 14:02:59 -0700
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050413201523.GC27088@elte.hu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Apr 2005, Ingo Molnar wrote:
> 
> well, the 'owned by another user' solution is valid though, and doesnt 
> have this particular problem. (We've got a secure multiuser OS, so can 
> as well use it to protect the DB against corruption.)

So now you need root to set up new repositories? No thanks.

		Linus
