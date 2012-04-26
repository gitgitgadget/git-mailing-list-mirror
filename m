From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] docs: stop using asciidoc no-inline-literal
Date: Thu, 26 Apr 2012 11:09:11 +0200
Message-ID: <vpqehra97wo.fsf@bauges.imag.fr>
References: <20120426085156.GB22819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 11:10:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNKiH-000256-4K
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 11:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754362Ab2DZJJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 05:09:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58003 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827Ab2DZJJb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 05:09:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3Q92hIm010617
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Apr 2012 11:02:43 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SNKhM-0002OE-8m; Thu, 26 Apr 2012 11:09:12 +0200
In-Reply-To: <20120426085156.GB22819@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 Apr 2012 04:51:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 26 Apr 2012 11:02:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3Q92hIm010617
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1336035768.58534@xvC9/uxw9bYK71bgAg5F6g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196360>

Jeff King <peff@peff.net> writes:

> The patch is below. I'm slightly nervous because it means topics in
> flight will need to have their documentation tweaked, too.

... or, at worse, they will be broken for a while, and we can grep again
the tip of pu after a few weeks to fix them. Plus, the possible breakage
due to your patch are compensated by the existing breakage you
fixed ;-). So, I'd say this is a valid concern, but the benefit seem
clearly greater than the drawbacks.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
