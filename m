From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] fsck_commit: remove duplicate tests
Date: Mon, 4 Feb 2008 00:04:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802040003360.7372@racer.site>
References: <12020737593747-git-send-email-mkoegler@auto.tuwien.ac.at> <12020737601683-git-send-email-mkoegler@auto.tuwien.ac.at> <7v3as9r3r2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLoqO-00015I-CC
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 01:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687AbYBDAFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 19:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbYBDAFJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 19:05:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:34651 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753903AbYBDAFI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 19:05:08 -0500
Received: (qmail invoked by alias); 04 Feb 2008 00:05:06 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp021) with SMTP; 04 Feb 2008 01:05:06 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180gJ9+uSs0zG9rz7B7OOkUND+8K2i72jHxUcRs2U
	lnYwh9Ym71k3N1
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3as9r3r2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72426>

Hi,

On Sun, 3 Feb 2008, Junio C Hamano wrote:

> Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:
> 
> > All tests on the commit buffer in fsck_cmd are ready done by 
> > parse_commit_buffer.
> >
> > This patch rips out all redundant tests.
> 
> As I believe in belt-and-suspenders when it comes to validation, I am 
> somewhat uneasy with this change.

Besides, should we really change fsck?  It's not _that_ much of a 
performance-critical operation.  Accuracy is much more important.

fsck is the reason I trust git with my data.

Ciao,
Dscho
