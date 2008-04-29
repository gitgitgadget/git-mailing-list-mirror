From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 04/13] Teach rebase interactive the mark command
Date: Tue, 29 Apr 2008 22:25:59 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804292220120.13650@eeepc-johanness>
References: <7vabkoufzq.fsf@gitster.siamese.dyndns.org> <1208132469-26471-1-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-2-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-3-git-send-email-joerg@alea.gnuu.de> <1208132469-26471-4-git-send-email-joerg@alea.gnuu.de>
 <7vabjm78v2.fsf@gitster.siamese.dyndns.org> <20080422095549.GB3752@alea.gnuu.de> <alpine.DEB.1.00.0804221127360.4460@eeepc-johanness> <7vy775ygjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804221810180.4460@eeepc-johanness> <7v3ap5a4ny.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0804290138170.27457@eeepc-johanness> <7vk5ih8ckp.fsf@gitster.siamese.dyndns.org> <4816CA72.8070405@viscovery.net> <alpine.DEB.1.00.0804291147450.27457@eeepc-johanness> <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	=?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:26:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxLS-0006C5-4a
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbYD2VZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbYD2VZu
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:25:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:44224 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751007AbYD2VZt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:25:49 -0400
Received: (qmail invoked by alias); 29 Apr 2008 21:25:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp046) with SMTP; 29 Apr 2008 23:25:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YnTxgNnaY5UJ6oYuh2f6zZmxzCFydR7CI3F6K0p
	P9uYFRPbRtb6/F
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vk5ig745b.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80739>

Hi,

On Tue, 29 Apr 2008, Junio C Hamano wrote:

> The problem is that both of you stopped reading after the part you 
> quoted.

I did not.  But I assumed that Hannes' example showed that it is always 
possible to reorder the commands such that you there is no problem with 
interpreting a short commit name as the original commit _until_ that 
commit is rewritten, and _then_ as the rewritten commit.

It is a simple matter of the word "acyclic" in the term "DAG".  It means 
that whenever you need to refer to a commit, it either comes before or 
after the commit you need it for, not both directions.

And I tried to make clear that I thought deeply about the issue by 
mentioning that you can always use "edit" to stop somewhere and mark (even 
by a lightweight tag), should you need to split a commit such that you 
need to reference both the original and the rewritten commit.

I think the balance to cut here is that of usability.  You can cater for 
the obscure cases, but that just does not make sense.  With some recipe -- 
as illustrated by Hannes -- it is very easy to see what it does, and as 
easy to modify it, should that be necessary.

The alternative is obviously easier for the cases that next to nobody will 
need.

So no, your argument does not convince me, and I still think that I 
understood it correctly from the start.

Ciao,
Dscho
