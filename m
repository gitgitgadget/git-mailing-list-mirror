From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] Rework strbuf API and semantics.
Date: Thu, 6 Sep 2007 15:09:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061506330.28586@racer.site>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org>
 <118907761140-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 16:09:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITI3J-0005AU-4N
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 16:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbXIFOJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 10:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbXIFOJo
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 10:09:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:36859 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750755AbXIFOJn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 10:09:43 -0400
Received: (qmail invoked by alias); 06 Sep 2007 14:09:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 06 Sep 2007 16:09:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19tnw9+vTxtP00C/zfGnUI+RF3NT9MK9mHkqA+C9W
	Uta4dHDzWIq1OT
X-X-Sender: gene099@racer.site
In-Reply-To: <118907761140-git-send-email-madcoder@debian.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57880>

Hi,

let me thank you for this very nicely done patch series.  Except for 5/7, 
they look pretty much obvious changes to me.  I'll review that in detail 
later.

On Thu, 6 Sep 2007, Pierre Habouzit wrote:

> +#define STRBUF_INIT  { 0, 0, 0, NULL }

Would not "struct strbuf sb = { 0 };" have the same effect?  (I am not so 
standards-keen as other people, who I have no doubt will gladly answer 
this one.)

Ciao,
Dscho
