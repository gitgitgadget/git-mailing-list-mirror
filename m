From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/5] fast-export: do not export negative refs
Date: Tue, 26 Jul 2011 17:11:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1107261709070.1534@s15462909.onlinehome-server.info>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com> <1311517282-24831-5-git-send-email-srabbelier@gmail.com> <7v39hvts4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 17:11:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QljHu-0005UY-MF
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 17:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207Ab1GZPLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 11:11:11 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:33961 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751877Ab1GZPLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 11:11:08 -0400
Received: (qmail invoked by alias); 26 Jul 2011 15:11:06 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp071) with SMTP; 26 Jul 2011 17:11:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19o3/988fNoT5mNJjSwXg/Mo2OnQ5mzRUMEkofZ/V
	c5LYcuvDO09IqC
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <7v39hvts4i.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177890>

Hi Junio,

On Sun, 24 Jul 2011, Junio C Hamano wrote:

> Sverre Rabbelier <srabbelier@gmail.com> writes:
> 
> > ... In the next commit this will be changed in order to make sure that 
> > 'master..master' does export master.
> 
> Sorry, but you need to be much more clear why this could be a good 
> thing.

Maybe we should have written 'master^0..master' or 'blub..blah' where 
'blah' points to the same commit as 'blub'.

The problem is that we need to be able to tell which _ref_ is 
uninteresting, not which _commit_, since one and the same commit can be 
referenced by an uninteresting and an interesting ref.

Hopefully you will excuse our being a little incoherent after a codathon,
Dscho
