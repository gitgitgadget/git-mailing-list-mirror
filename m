From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/5] add pack index v2 reading capability to git
 v1.4.4.4
Date: Wed, 16 Jul 2008 09:25:17 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807160924340.2835@woody.linux-foundation.org>
References: <1216189899-14279-1-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jul 16 18:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ9qp-0001py-UG
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 18:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411AbYGPQ0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 12:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756448AbYGPQ0g
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 12:26:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38732 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756349AbYGPQ0g (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jul 2008 12:26:36 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6GGPJNS012551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jul 2008 09:25:20 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6GGPHMW001397;
	Wed, 16 Jul 2008 09:25:18 -0700
In-Reply-To: <1216189899-14279-1-git-send-email-nico@cam.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.909 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88695>



On Wed, 16 Jul 2008, Nicolas Pitre wrote:
> 
> Junio: if you could just apply them, tag the result as v1.4.4.5 and
> push it out then at that point it simply will be up to Debian to make
> it available as a "major usability fix".

Actually, it fixes a crash. Didn't 1.4.4 SIGSEGV without this on pack-v2?

So you don't even have to sell it as a usability issue, but literally as a 
bugfix.

		Linus
