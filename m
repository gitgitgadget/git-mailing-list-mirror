From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Index/hash order
Date: Wed, 13 Apr 2005 13:15:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504131314150.4501@ppc970.osdl.org>
References: <20050412230027.GA21759@elte.hu> <20050412230729.GA22179@elte.hu>
 <20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com>
 <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com>
 <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org>
 <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org>
 <20050413200237.GA26635@elte.hu> <425D7C0F.2050109@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 22:11:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLoCH-0005nV-My
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 22:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDMUOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 16:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261183AbVDMUOE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 16:14:04 -0400
Received: from fire.osdl.org ([65.172.181.4]:13271 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261181AbVDMUOB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 16:14:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3DKDws4022153
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Apr 2005 13:13:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3DKDvFR015647;
	Wed, 13 Apr 2005 13:13:57 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <425D7C0F.2050109@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Apr 2005, H. Peter Anvin wrote:
> 
> Either which way, it feels to me that this idea has already been ruled 
> out, so it's probably pointless to keep debating just exactly what we're 
> not actually going to do.

Hey, isn't that how most discussions progress? ;)

I don't mind alternatives per se. I'm just lazy. I came up with one
solution to the issues I percieved, and I like that one. But dammit, if
somebody comes up with something _clearly_ superior, I'll just bow down in
your general direction, and promptly implement that.

		Linus
