From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Building git-1.5.3.7 on HP-UX 11.00
Date: Tue, 4 Dec 2007 22:46:30 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712042245440.27959@racer.site>
References: <20071204130922.731c407a@pc09.procura.nl>
 <Pine.LNX.4.64.0712041343040.27959@racer.site> <20071204140326.14d9e7a0@pc09.procura.nl>
 <Pine.LNX.4.64.0712041439590.27959@racer.site> <20071204150102.7f3ec3e9@pc09.procura.nl>
 <47556EE2.6040105@op5.se> <20071204152240.6cb6018e@pc09.procura.nl>
 <Pine.LNX.4.64.0712041536180.27959@racer.site> <20071204155655.053f4fb4@pc09.procura.nl>
 <7vve7e49or.fsf@gitster.siamese.dyndns.org> <20071204232542.425d2ead@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Dec 04 23:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzgYO-00039g-Fo
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 23:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbXLDWr2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 17:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbXLDWr2
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 17:47:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:60932 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751957AbXLDWr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 17:47:27 -0500
Received: (qmail invoked by alias); 04 Dec 2007 22:47:25 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp011) with SMTP; 04 Dec 2007 23:47:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Z0YIFwF6ZlbH5cTx3XKUJJTbHZrz+QBUXXoO7Kg
	Fykyy94eN+eKwC
X-X-Sender: gene099@racer.site
In-Reply-To: <20071204232542.425d2ead@pc09.procura.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67096>

Hi,

On Tue, 4 Dec 2007, H.Merijn Brand wrote:

> * FAIL 17: non-match
>         git config --get nextsection.nonewline !for
> * FAIL 18: non-match value
>         test wow = $(git config --get nextsection.nonewline !for)

Can you investigate further with "-i -v" and/or "-x"?  Could be the 
exclamation mark...

Ciao,
Dscho
