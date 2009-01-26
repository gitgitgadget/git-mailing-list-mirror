From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Reintegrate script
Date: Mon, 26 Jan 2009 12:18:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901261218070.14855@racer>
References: <7vd4ea8mnf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 12:19:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRPV3-0005eW-JU
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbZAZLSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbZAZLSC
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:18:02 -0500
Received: from mail.gmx.net ([213.165.64.20]:45236 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750768AbZAZLSB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:18:01 -0500
Received: (qmail invoked by alias); 26 Jan 2009 11:17:59 -0000
Received: from pD9EB294D.dip0.t-ipconnect.de (EHLO noname) [217.235.41.77]
  by mail.gmx.net (mp006) with SMTP; 26 Jan 2009 12:17:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cX1k6MgYce+90JIaHn/64uSZYahQ395dBiP2Kz7
	jrliyO/11YlyzA
X-X-Sender: gene099@racer
In-Reply-To: <7vd4ea8mnf.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107190>

Hi,

On Mon, 26 Jan 2009, Junio C Hamano wrote:

> In a workflow that uses topic branches heavily, you would need to keep 
> updating test integration branch(es) all the time.  If they are managed 
> like my 'next' by merging the tips of topics that have grown since the 
> last integration, it is not so difficult.  You only need to review 
> output from "git branch --no-merged next" to see if there are topics 
> that can and needs to be merged to 'next'.
> 
> But sometimes it is easier to rebuild a test integration branch from
> scratch all the time, especially if you do not publish it for others to
> build on.

FWIW that is exactly what I am aiming at with my rebase -i -p work.

Ciao,
Dscho
