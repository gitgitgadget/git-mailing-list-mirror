From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-gui: use "blame -w -C -C" for "where did it come
 from, originally?"
Date: Thu, 21 Jun 2007 12:47:54 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706211243400.3593@woody.linux-foundation.org>
References: <200706162226.l5GMQBss004492@mi0.bluebottle.com>
 <7vk5tx5333.fsf@assigned-by-dhcp.pobox.com> <20070621050117.GF8477@spearce.org>
 <alpine.LFD.0.98.0706211237220.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 21:48:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Sdk-00006H-2g
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 21:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678AbXFUTsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 15:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756764AbXFUTsL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 15:48:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60146 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755769AbXFUTsJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2007 15:48:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LJm0VS020803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jun 2007 12:48:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5LJltaJ003660;
	Thu, 21 Jun 2007 12:47:55 -0700
In-Reply-To: <alpine.LFD.0.98.0706211237220.3593@woody.linux-foundation.org>
X-Spam-Status: No, hits=-4.536 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50654>



On Thu, 21 Jun 2007, Linus Torvalds wrote:
> 
> I'd personally rather *not* have git-gui make the -w/-M/-C choice for me. 
> Why don't you just allow the user to say? Sometimes I might want to see 
> who introduced broken whitespace. Let me say
> 
> 	git gui blame -w filename.c
> 
> please? Instead of making that choice for me, and then blaming git for 
> something that wasn't git's problem.

Side note - this ended up being one reason why "gitk" is so good. It just 
passed down the arguments to "git-rev-list", and it allowed me to improve 
on the original gitk without gitk ever even _realizing_ it was improved 
upon. All the pathname filtering etc was done without gitk ever learning 
about it - it "just worked".

		Linus
