From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 11:10:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609271109510.3952@g5.osdl.org>
References: <20060927180147.33024.qmail@web51009.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 20:11:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSdrr-0001eY-P8
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 20:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbWI0SKo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 14:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030512AbWI0SKo
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 14:10:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54194 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030523AbWI0SKn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 14:10:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8RIAYnW017269
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Sep 2006 11:10:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8RIAXIV002416;
	Wed, 27 Sep 2006 11:10:33 -0700
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060927180147.33024.qmail@web51009.mail.yahoo.com>
X-Spam-Status: No, hits=-0.469 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.154 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27919>



On Wed, 27 Sep 2006, Matthew L Foster wrote:
> 
> Ok, the word "history" in the context of git primarily means the order of changes not the when?
> Would it be a conceptual or technical issue for git to directly track the local time of
> merges/changesets?

True merges _get_ tracked - they are commits too (they just have multiple 
parents).

But it's only the time the merge was done that gets tracked, not the time 
the merge was then pushed out to somebody else.

		Linus
