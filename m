From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 3 Feb 2009 19:19:58 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902031918520.9822@pacific.mpi-cbg.de>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org> <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com> <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com>
 <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302> <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com> <alpine.DEB.1.00.0902031817260.6573@intel-tinevez-2-302> <5FE034E8-422F-4692-AD37-5633C91A4B98@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 19:20:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPtJ-0008Ku-Lm
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 19:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbZBCSTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 13:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbZBCSTc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 13:19:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:44957 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752205AbZBCSTb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 13:19:31 -0500
Received: (qmail invoked by alias); 03 Feb 2009 18:19:28 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 03 Feb 2009 19:19:28 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Xqk5YT3ZXotNFPRqh+pQk43jbOjDRSxuN8b95ix
	YTB2cN8roV8alS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <5FE034E8-422F-4692-AD37-5633C91A4B98@silverinsanity.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108235>

Hi,

On Tue, 3 Feb 2009, Brian Gernhardt wrote:

> On Feb 3, 2009, at 12:18 PM, Johannes Schindelin wrote:
> 
> >You did not look far.
> 
> If there's something I missed, could you perhaps say what it is instead 
> of being cryptic?

$ git grep -l test_commit junio/next -- t/
junio/next:t/README
junio/next:t/t1450-fsck.sh
junio/next:t/t3410-rebase-preserve-dropped-merges.sh
junio/next:t/t3411-rebase-preserve-around-merges.sh
junio/next:t/t3412-rebase-root.sh
junio/next:t/test-lib.sh

But I understood.  I will audit the code myself later this evening.

Ciao,
Dscho
