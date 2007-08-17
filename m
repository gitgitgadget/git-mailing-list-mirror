From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix read-tree merging more than 3 trees using 3-way
 merge
Date: Thu, 16 Aug 2007 20:44:43 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708162044280.30176@woody.linux-foundation.org>
References: <600399.61066.qm@web52807.mail.re2.yahoo.com>
 <7vbqd8o1qs.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708161750550.30176@woody.linux-foundation.org>
 <7vbqd6j4a0.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0708161930100.30176@woody.linux-foundation.org>
 <7v7inuj0eh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Perrin Meyer <perrinmeyer@yahoo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 05:45:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILslm-0005V1-NY
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 05:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757253AbXHQDoy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 23:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757229AbXHQDox
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 23:44:53 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38146 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756719AbXHQDow (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2007 23:44:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7H3imKZ025429
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 16 Aug 2007 20:44:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7H3ihTH020431;
	Thu, 16 Aug 2007 20:44:43 -0700
In-Reply-To: <7v7inuj0eh.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-4.752 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.24__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56044>



On Thu, 16 Aug 2007, Junio C Hamano wrote:
>
> [PATCH] Clean-up read-tree error condition.
> 
> This is a follow-up to f34f2b0b; list_tree() function is where it
> first notices that the command line fed too many trees for us to
> handle, so move the error exit message to there, and raise the
> MAX_TREES to 8 (not that it matters very much in practice).
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

ACK. Obviously.

		Linus
