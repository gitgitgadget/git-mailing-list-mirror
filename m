From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Ignore submodule commits when fetching over dumb
 protocols
Date: Tue, 26 Jun 2007 14:36:37 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706261434540.8675@woody.linux-foundation.org>
References: <20070626211940.GA27221@liacs.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sven Verdoolaege <skimo@liacs.nl>
X-From: git-owner@vger.kernel.org Tue Jun 26 23:37:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Iij-0006pr-5M
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 23:37:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbXFZVhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 17:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbXFZVhG
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 17:37:06 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42019 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752187AbXFZVhF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jun 2007 17:37:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QLahGd028338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Jun 2007 14:36:44 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5QLabFM002566;
	Tue, 26 Jun 2007 14:36:37 -0700
In-Reply-To: <20070626211940.GA27221@liacs.nl>
X-Spam-Status: No, hits=-4.613 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50979>



On Tue, 26 Jun 2007, Sven Verdoolaege wrote:
>
> Without this patch, the code would look for the submodule
> commits in the superproject and (needlessly) fail when it
> couldn't find them.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

This should probably be put in the maintenance branch, since I think we've 
tried to make sure that the current 1.5.x series plumbing can handle 
superproject data even if it doesn't then have the porcelain to make it 
all easy..

		Linus
