From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] revision limiting sometimes ignored
Date: Wed, 6 Feb 2008 09:42:38 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802060942020.2967@woody.linux-foundation.org>
References: <20080203030054.GA18654@coredump.intra.peff.net> <20080203043310.GA5984@coredump.intra.peff.net> <alpine.LFD.1.00.0802040922480.3034@hp.linux-foundation.org> <7vr6fsk08w.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802041146060.3034@hp.linux-foundation.org>
 <alpine.LFD.1.00.0802041223080.3034@hp.linux-foundation.org> <7vir13g9hx.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802051300050.3110@woody.linux-foundation.org> <alpine.LSU.1.00.0802052228280.8543@racer.site> <alpine.LFD.1.00.0802051539570.2967@woody.linux-foundation.org>
 <20080206164303.GA1255@code-monkey.de> <alpine.LFD.1.00.0802061220590.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tilman Sauerbeck <tilman@code-monkey.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Feb 06 18:44:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMoJT-0003JS-2I
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 18:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbYBFRnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 12:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753814AbYBFRnZ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 12:43:25 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52440 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753113AbYBFRnY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 12:43:24 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m16HgdFr006416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2008 09:42:40 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m16Hgccm022409;
	Wed, 6 Feb 2008 09:42:38 -0800
In-Reply-To: <alpine.LFD.1.00.0802061220590.2732@xanadu.home>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.215 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72822>



On Wed, 6 Feb 2008, Nicolas Pitre wrote:
> 
> Anyway, the author's date are not necessarily monotonic.

Git never even looks at the author date. Only the commit date matters.

		Linus
