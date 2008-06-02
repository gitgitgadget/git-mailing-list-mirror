From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 2 Jun 2008 16:17:05 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806021545340.13507@racer.site.net>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7vwso85qkf.fsf@gitster.siamese.dyndns.org> <7vwso5r87q.fsf@gitster.siamese.dyndns.org> <7v8x0992hy.fsf@gitster.siamese.dyndns.org> <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org> <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org> <7vbq4j748l.fsf@gitster.siamese.dyndns.org> <7vr6d8apjx.fsf@gitster.siamese.dyndns.org> <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org> <7vabjm1a0q.fsf@gitster.siamese.dyndns.org> <7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
 <7vmyn4hr8f.fsf@gitster.siamese.dyndns.org> <7vmymsjz6x.fsf@gitster.siamese.dyndns.org> <7vabijxhk4.fsf@gitster.siamese.dyndns.org> <7vwslhg8qe.fsf@gitster.siamese.dyndns.org> <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 17:19:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3Boa-000429-R3
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 17:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbYFBPSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 11:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbYFBPSY
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 11:18:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:51935 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752432AbYFBPSX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 11:18:23 -0400
Received: (qmail invoked by alias); 02 Jun 2008 15:18:20 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.2]) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 02 Jun 2008 17:18:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+eomNgS/2eKh6MMjJsqSAZJToLoWMXqeYLbz3Qv4
	gnyb8m1dkSeaEQ
X-X-Sender: gene099@racer.site.net
In-Reply-To: <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83530>

Hi,

On Mon, 2 Jun 2008, Junio C Hamano wrote:

> * sp/remote (Sun Jun 1 00:28:04 2008 -0400) 3 commits
>  + Make "git-remote rm" delete refs acccording to fetch specs
>  + Make "git-remote prune" delete refs according to fetch specs
>  + Remove unused remote_prefix member in builtin-remote
> 
> "git-remote" had an unwarranted assumption that everybody uses 
> refs/remotes/$it namespace to track remote repository called $it.  This 
> series is a reasonable fix to it.

AFAIR this limitation was already in the scripted version, and I tried to 
wrap my head around lifting it.  However, I did not end up with the 
brillian analysis of Shawn, and was almost sending a reply contradicting 
his logic.  However, I agree with Shawn that it is the same issue as 
contradicting fetches, so if it leads to problems, it is a pilot error.

_However_, I still try to come up with some attic for deleted refs.  It is 
not just a matter of moving the logs to a different namespace because of 
D/F conflicts.

Ciao,
Dscho
