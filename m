From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: A shortcoming of the git repo format
Date: Wed, 27 Apr 2005 08:22:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504270820370.18901@ppc970.osdl.org>
References: <426F2671.1080105@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 17:16:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQoFn-0005WR-Em
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 17:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVD0PUX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 11:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVD0PUX
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 11:20:23 -0400
Received: from fire.osdl.org ([65.172.181.4]:5312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbVD0PUR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 11:20:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RFKCs4015122
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 08:20:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RFK8cV019645;
	Wed, 27 Apr 2005 08:20:11 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <426F2671.1080105@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 26 Apr 2005, H. Peter Anvin wrote:
> 
> One solution to all of this would be to define a quoting standard for 
> strings, and simply require that all free-format strings (like the 
> author fields) or at least strings that match [0-9a-f]{20}, are always 
> quoted.

git uses more of the ".newsrc" format, in that it just knows which 
characters are legal or not.

To find the email address, look for the first '<'. To find the date, look 
for the first '>'. Those characters are not allowed in the name or the 
email, so they act as well-defined delimeters.

		Linus
