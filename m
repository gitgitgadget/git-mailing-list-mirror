From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: [PATCH 2/6] show: obey --textconv for blobs
Date: Mon, 22 Apr 2013 17:37:40 +0200 (CEST)
Message-ID: <1547528401.1826118.1366645060312.JavaMail.root@openwide.fr>
References: <20130422152905.GA11886@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:37:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUIoL-00080C-Vj
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754595Ab3DVPhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:37:42 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:46586 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754533Ab3DVPhl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:37:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id D9AFF28006;
	Mon, 22 Apr 2013 17:37:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mlffJg-2AfLX; Mon, 22 Apr 2013 17:37:40 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 6906C28002;
	Mon, 22 Apr 2013 17:37:40 +0200 (CEST)
In-Reply-To: <20130422152905.GA11886@sigill.intra.peff.net>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC26 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222029>

> > 	git show --textconv HEAD~4:binary-gob | less
> > 
> > but I doubt it is a good idea to turn it on by default this late in
> > the game.
> 
> Exactly. I certainly do not mind it as an option, and I am on the
> fence
> regarding it as a default (I think it might have been a sane thing to
> do
> from the start, but at this point the change-of-behavior makes me
> hesitate). So I am perfectly willing to go either way, depending on
> what
> others think.
> 


some features detect if they are piping to a terminal... couldn't we do
something like that ?
