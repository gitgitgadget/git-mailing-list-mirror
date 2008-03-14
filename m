From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Segmentation fault in git read-tree
Date: Fri, 14 Mar 2008 10:37:41 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803141037000.3557@woody.linux-foundation.org>
References: <200803132359.06745.lenb@kernel.org> <alpine.LFD.1.00.0803132125280.3557@woody.linux-foundation.org> <alpine.LFD.1.00.0803132136080.3557@woody.linux-foundation.org> <7vejadvrk7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Len Brown <lenb@kernel.org>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDsX-0006w2-SC
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbYCNRi6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbYCNRi6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:38:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50050 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750792AbYCNRi5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 13:38:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2EHccTH001623
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Mar 2008 10:38:39 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2EHbfAY011487;
	Fri, 14 Mar 2008 10:37:42 -0700
In-Reply-To: <7vejadvrk7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.326 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77263>



On Thu, 13 Mar 2008, Junio C Hamano wrote:
> 
> Somehow this reminds me of a9ab200 (Clean-up read-tree error condition.,
> Aug 16, 2007) and f34f2b0 (Fix read-tree merging more than 3 trees using
> 3-way merge, Aug 15, 2007).

Yeah. I think we don't actually have any test for more than three trees. 
If we really are supposed to do eight trees, maybe we should test for it.

		Linus
