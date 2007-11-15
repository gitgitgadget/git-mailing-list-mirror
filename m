From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Wed, 14 Nov 2007 17:53:51 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711141752230.2786@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de> <20071114204732.GE3973@steel.home> <7vprycfrk6.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de> <20071114232809.GH3973@steel.home>
 <20071115001756.GA25021@atjola.homenet> <7v3av89wq7.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.9999.0711141640400.2786@woody.linux-foundation.org> <85ir441exj.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 15 02:54:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsTwS-0007tz-9V
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 02:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838AbXKOByg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 20:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754456AbXKOByg
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 20:54:36 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38749 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751322AbXKOByf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 20:54:35 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAF1rqb1016694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Nov 2007 17:53:53 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAF1rp12005017;
	Wed, 14 Nov 2007 17:53:51 -0800
In-Reply-To: <85ir441exj.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-4.737 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65044>



On Thu, 15 Nov 2007, David Kastrup wrote:
> 
> Is that supposed to work?  I would have thought that the only options
> would be empty and 0.

I think it should work, even though some things allocations will end up 
being a bit too large (ie anything that uses "sizeof()" will have that one 
unnecessary entry)

But no, I didn't actually test it.

		Linus
