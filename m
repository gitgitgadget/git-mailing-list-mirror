From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 1 Jul 2008 00:09:15 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807010007010.9925@racer>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org> <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
 <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org> <7vod6k6zg4.fsf@gitster.siamese.dyndns.org> <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org> <7vwskjazql.fsf@gitster.siamese.dyndns.org> <7vk5ggipuw.fsf@gitster.siamese.dyndns.org> <7vej6l3lp7.fsf@gitster.siamese.dyndns.org> <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
 <1214834970.3382.4.camel@gaara.bos.redhat.com> <7vabh2vaav.fsf@gitster.siamese.dyndns.org> <20080630155147.009a24b7.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, krh@redhat.com,
	git@vger.kernel.org, sfr@canb.auug.org.au, pasky@suse.cz
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 01:12:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSXd-00041Y-Od
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbYF3XLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 19:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753313AbYF3XLL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:11:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:47368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753173AbYF3XLK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 19:11:10 -0400
Received: (qmail invoked by alias); 30 Jun 2008 23:11:08 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp039) with SMTP; 01 Jul 2008 01:11:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/PG919W4jPD576bY/L9InvIGUuaImXQo5xOsgv8n
	aq4fstgtbGQzMv
X-X-Sender: gene099@racer
In-Reply-To: <20080630155147.009a24b7.akpm@linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86962>

Hi,

On Mon, 30 Jun 2008, Andrew Morton wrote:

> - It's bad to have the same info in two places, and to have to
>   support two different ways of doing the same thing for ever.

It is actually worse: we have three places.

>   For me the biggest part of migrating would be working out what on
>   earth the format of the new files is.  Maybe it's documented
>   somewhere undiscoverable, dunno.

The easiest way is to

	git config remote.$NICKNAME.url $URL

where you said

	echo $URL > .git/branches/$NICKNAME

Actually, you might even like this command better:

	git remote add $NICKNAME $URL

Many ways to go to Rome,
Dscho
