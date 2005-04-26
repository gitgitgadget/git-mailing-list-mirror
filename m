From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git.git object database at kernel.org?
Date: Mon, 25 Apr 2005 17:58:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251756190.18901@ppc970.osdl.org>
References: <7vhdhvstb2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504241553580.18901@ppc970.osdl.org> <426D3B01.8060408@zytor.com>
 <Pine.LNX.4.58.0504251729080.18901@ppc970.osdl.org> <426D8FDF.5050608@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 26 02:51:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQEIS-0003qG-Rs
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 02:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVDZA4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 20:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVDZA4f
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 20:56:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:20358 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261236AbVDZA4e (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 20:56:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q0uTs4019394
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 17:56:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3Q0uSTd018026;
	Mon, 25 Apr 2005 17:56:28 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426D8FDF.5050608@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005, H. Peter Anvin wrote:
> 
> Oh well.  If you have the offset, the algorithm is fully arithmetric and 
> doesn't rely on the zoneinfo system, so it can be trivially implemented. 

You have a different definition of "trivial" than I do. I have not a 
frigging clue how to handle leap seconds etc ;)

>    And again, curl_gettime() does handle the whole string to time_t 
> conversion of the common formats.

I don't doubt you, I just would prefer to not rely on boutique libraries 
too much. 

Yeah, we already use it for http-pull, so I guess it's moot, but at least 
that felt less like a core command..

		Linus
