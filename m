From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 3 Oct 2007 09:13:49 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710030912410.3579@woody.linux-foundation.org>
References: <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
 <20070927023633.GA28902@coredump.intra.peff.net> <20071002041652.GA32133@coredump.intra.peff.net>
 <7vsl4up0tf.fsf@gitster.siamese.dyndns.org> <20071002050820.GA4261@coredump.intra.peff.net>
 <20071002051332.GA4462@coredump.intra.peff.net> <86ejge6o8b.fsf@lola.quinscape.zz>
 <20071002161114.GC6828@coredump.intra.peff.net> <86ve9p32cp.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0710021916080.3579@woody.linux-foundation.org>
 <20071003065414.GA13737@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 18:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id6ri-0004uX-Ct
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 18:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbXJCQOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 12:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbXJCQOS
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 12:14:18 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47326 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752727AbXJCQOS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 12:14:18 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l93GDoPJ024133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 3 Oct 2007 09:13:51 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l93GDn7L029640;
	Wed, 3 Oct 2007 09:13:50 -0700
In-Reply-To: <20071003065414.GA13737@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.448 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_33
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.46__
X-MIMEDefang-Filter: lf$Revision: 1.187 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59853>



On Wed, 3 Oct 2007, Jeff King wrote:
> 
> I get slightly better speedups with my pathological case (around 30%):

Ok, 30% is definitely "worth doing". Even if your performance still sucks, 
and 71 seconds is just way out of line for anything like this (of course, 
these days you need that "-l0" to ever trigger that case, but it would be 
nice if we could speed things up so much that we no longer care).

		Linus
