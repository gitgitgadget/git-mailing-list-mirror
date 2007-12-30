From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-filter-branch could be confused by similar names
Date: Sun, 30 Dec 2007 17:03:32 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712301700580.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1198593316-7712-1-git-send-email-dpotapov@gmail.com>
 <Pine.LNX.4.64.0712292334080.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <20071230103146.GU13968@dpotapov.dyndns.org>
 <Pine.LNX.4.64.0712301145360.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <20071230135428.GW13968@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 30 17:04:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J90dt-0002CR-UV
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 17:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbXL3QDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2007 11:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbXL3QDf
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Dec 2007 11:03:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:57493 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751212AbXL3QDe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2007 11:03:34 -0500
Received: (qmail invoked by alias); 30 Dec 2007 16:03:33 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp038) with SMTP; 30 Dec 2007 17:03:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18rRzB6+EQrB1pR1L5vhECdvyGOqWW+mzQovXH1bQ
	/KwR6JMfanE14d
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20071230135428.GW13968@dpotapov.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69370>

Hi,

On Sun, 30 Dec 2007, Dmitry Potapov wrote:

> How about this:
> 
> +			grep '^refs/\([^/]\+/\)\?'"$ref"'$')"

Maybe.  I wonder whether just adding a "$" (which I obviously forgot) 
would not be enough...

Ciao,
Dscho
