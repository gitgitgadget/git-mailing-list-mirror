From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 3 Feb 2009 21:38:45 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902032132130.9822@pacific.mpi-cbg.de>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org> <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com> <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com>
 <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302> <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com> <alpine.DEB.1.00.0902031817260.6573@intel-tinevez-2-302> <5FE034E8-422F-4692-AD37-5633C91A4B98@silverinsanity.com>
 <alpine.DEB.1.00.0902031918520.9822@pacific.mpi-cbg.de> <34FE2049-0A81-4615-AE3D-46DE35A44011@silverinsanity.com> <7vy6wn9wdj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 21:40:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUS3a-0003vu-TL
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 21:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbZBCUiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 15:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbZBCUiQ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 15:38:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:59185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751050AbZBCUiP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 15:38:15 -0500
Received: (qmail invoked by alias); 03 Feb 2009 20:38:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 03 Feb 2009 21:38:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19By5U1WCBBG/v7cHfNwTApVV8NgNkwuGrqQzRBWh
	QSr0FcSaGhrs3j
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vy6wn9wdj.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108248>

Hi,

On Tue, 3 Feb 2009, Junio C Hamano wrote:

> I'll try to find time myself to triple check if you two want to, even 
> though it is known that I often get tripped by the same kind of 
> brain-slippage as Dscho when Dscho does get tripped, so my auditing 
> might not add much to the collective confidence level ;-).

Thanks ;-)

I inspected all files that git grep -p showed me, and I see that t3412 
uses the file names, but passes explicit parameters to test_commit for 
them.  So that is fine, too.

Just as a matter of preference, I'd not downcase, but instead append a 
".file" in test_commit, but that's not a strong preference.  (I'd not 
downcase, because that was done only to prevent the tag to have the same 
name as the file, but that did not work...)

Ciao,
Dscho
