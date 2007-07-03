From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [Quilt-dev] Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 09:03:07 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707030901310.9434@woody.linux-foundation.org>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
 <20070702145601.a0dcef0f.akpm@linux-foundation.org>
 <alpine.LFD.0.98.0707021713200.9434@woody.linux-foundation.org>
 <200707031534.47004.agruen@suse.de>
 <20070703084926.2e834aa5.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Andreas Gruenbacher <agruen@suse.de>, quilt-dev@nongnu.org,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 18:03:28 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5kqd-0005j2-7Z
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 18:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbXGCQDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 12:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758240AbXGCQDU
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 12:03:20 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50346 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755091AbXGCQDT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jul 2007 12:03:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l63G3D7P017582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jul 2007 09:03:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l63G378n000307;
	Tue, 3 Jul 2007 09:03:07 -0700
In-Reply-To: <20070703084926.2e834aa5.akpm@linux-foundation.org>
X-Spam-Status: No, hits=-3.139 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51511>



On Tue, 3 Jul 2007, Andrew Morton wrote:
> 
> But the problem is that patch will get stuck in interactive mode prompting
> for a filename.  I've never actually worked how to make patch(1) just fail
> rather than going interactive, not that I've tried terribly hard.  Any
> hints there?

"patch -t" (or "--batch") should do it, I suspect.

But even with "patch -tu -p1" you do seem to end up having patch notice 
indented patch fragments (ie things that obviously are *not* part of the 
patch, but some explanation).

		Linus
