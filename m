From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb using "--cc"?
Date: Wed, 8 Feb 2006 18:26:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602081817040.2458@g5.osdl.org>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org> <43EAA560.8030504@didntduck.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kay Sievers <kay.sievers@suse.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 03:26:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F71WB-0003f7-5Y
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 03:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422776AbWBIC0o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 21:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWBIC0o
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 21:26:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46782 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422776AbWBIC0o (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 21:26:44 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k192QdDZ030112
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 18:26:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k192Qdwn025159;
	Wed, 8 Feb 2006 18:26:39 -0800
To: Brian Gerst <bgerst@didntduck.org>
In-Reply-To: <43EAA560.8030504@didntduck.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15784>



On Wed, 8 Feb 2006, Brian Gerst wrote:
> 
> git-whatchanged doesn't show that merge commit either.

Actually, it does. You just have to ask it.

	git-whatchanged --cc

The thing is, "git-whatchanged" is different from "git diff" and other 
helpers, in that it by default shows the "raw" git representation. Which 
indeed doesn't show that merge as being anything interesting.

But with "--cc", the merge suddenly blossoms.

Now, arguably, the raw format should default to the same kind of "were 
there data conflicts" that "-c" does for merges, but it doesn't, so it's 
silent ;(

		Linus
