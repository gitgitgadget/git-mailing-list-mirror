From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "mailinfo: Remove only one set of square brackets" considered
 harmful
Date: Wed, 15 Jul 2009 15:31:44 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907151520380.13838@localhost.localdomain>
References: <alpine.LFD.2.01.0907150821280.13838@localhost.localdomain> <7vljmpegy4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 00:32:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRD1h-0003JD-46
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 00:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbZGOWca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 18:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755848AbZGOWca
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 18:32:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60533 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755716AbZGOWc3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2009 18:32:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6FMVjB2025580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 15 Jul 2009 15:31:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6FMViZU005411;
	Wed, 15 Jul 2009 15:31:44 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vljmpegy4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.417 required=5 tests=AWL,BAYES_00,OSDL_NIGERIAN_ESTATE
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123341>



On Wed, 15 Jul 2009, Junio C Hamano wrote:
> 
> Even though it is silly not to rely on already well established
> conventions such as X-Mailing-List and List-ID but instead to waste
> precious real estate at the initial part of the Subject in this century
> merely for list identification purposes, this change regresses the end
> result.

Note that at least for the security list, it's not about "list 
identification", but simply to make the thing stand out in peoples 
mailboxes.

But I do agree that it's not perfect, and I would like to make the bracket 
removal stricter. Andreas' patch was a step in that direction. But 
different users would probably have different requirements.

For example, from a strictly git tools perspective, it's not even "any 
square bracket", and some people might want to remove only a single 
bracketed level, and only if it starts with "[PATCH".

For other uses, we want to remove the "Re: " at the beginning (and some 
crazy email readers use language/locale-specific versions like "Vs:" for 
that), and examples like the above "[Security]" from the security list.

So maybe the right solution is to allow people to configure this somehow.

		Linus
