From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 29 Apr 2008 23:55:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804292355060.17469@eeepc-johanness>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness> <7viqy05mhp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:56:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqykO-0000Uk-KK
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 00:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbYD2Wzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 18:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755881AbYD2Wzl
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 18:55:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:34681 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755273AbYD2Wzj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 18:55:39 -0400
Received: (qmail invoked by alias); 29 Apr 2008 22:55:37 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp014) with SMTP; 30 Apr 2008 00:55:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/z2Ko0HKHzPNydPy1PhL6Dku5gs7AU1KMUXpR1vr
	cAP6RyJLRQ/6Cm
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7viqy05mhp.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80762>

hi,

On Tue, 29 Apr 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It is a simple matter of the word "acyclic" in the term "DAG".  It means 
> > that whenever you need to refer to a commit, it either comes before or 
> > after the commit you need it for, not both directions.
> 
> I fell in the same "acyclic" fallacy before I realized it was a mistake, 
> especially after thought about the "rewritten B needs to be used more 
> than twice as a merge source" issue.  That's why I earlier said the 
> beauty of your approach is attractive but it "unfortunately" breaks 
> down.

I do not understand.  The topological order assures that you have 
rewritten every commit that needs to be rewritten before rewriting the 
current commit.

Puzzled,
Dscho
