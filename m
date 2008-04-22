From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 22 Apr 2008 11:31:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-916834090-1208860301=:4460"
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org,
	gitster@pobox.com
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:33:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoFna-0005Qg-GG
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 12:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759578AbYDVKbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 06:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761200AbYDVKbR
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 06:31:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:49009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759905AbYDVKbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 06:31:16 -0400
Received: (qmail invoked by alias); 22 Apr 2008 10:31:14 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 22 Apr 2008 12:31:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19BzthAeYZBrvoXK74PiDOF0RujcNHofMcLmINX6R
	PpQi6G/IgpyJnn
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080422095549.GB3752@alea.gnuu.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80095>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-916834090-1208860301=:4460
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 22 Apr 2008, Jörg Sommer wrote:

> Junio C Hamano schrieb am Mon 21. Apr, 22:32 (-0700):
>
> > What was the conclusion of the mark-syntax discussion?
> 
> Use the same as fast-import and fix fast-import. :)

I strongly disagree.

Also with the conclusion that this was the conclusion.

fast-import is a fundamentally different thing compared to rebase -i.  The 
former should be very easy to write importers for, and therefore have a 
very easy syntax from the _technical_ view, the latter should be usable by 
people, and therefore have a very easy syntax from the _usability_ point 
of view.

So I really hate the idea of introducing yet other marks when we already 
have unique identifiers: the (abbreviated) commit names.

I guess the only way to prove that I am not wrong is to do it myself. 
Sigh.

Ciao,
Dscho

--658432-916834090-1208860301=:4460--
