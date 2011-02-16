From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: non-empty index with git commit -a
Date: Wed, 16 Feb 2011 11:28:17 +0100
Message-ID: <vpqbp2cmfy6.fsf@bauges.imag.fr>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
	<20110216023645.GA7085@sigill.intra.peff.net>
	<20110216032047.GA2858@elie>
	<AANLkTinbcHW+ja7T=PiCEorNdnK6W2DvA_c9F8JTEMKB@mail.gmail.com>
	<20110216085114.GA9413@sigill.intra.peff.net>
	<AANLkTik_F=d1CjNVfj35wgv0pL1LefOMnttXjs=s2wCQ@mail.gmail.com>
	<20110216095415.GA12578@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:28:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppecc-0006HQ-4o
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758724Ab1BPK21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:28:27 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47650 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757837Ab1BPK20 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:28:26 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p1GASGDx017705
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Feb 2011 11:28:16 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PpecL-0006NY-HU; Wed, 16 Feb 2011 11:28:17 +0100
In-Reply-To: <20110216095415.GA12578@sigill.intra.peff.net> (Jeff King's message of "Wed\, 16 Feb 2011 04\:54\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Feb 2011 11:28:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p1GASGDx017705
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1298456897.79644@03MCp5ohRyLjb2DLQBM1IQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166950>

Jeff King <peff@peff.net> writes:

> So? Your question was whether index state is precious. If it's precious,
> shouldn't we be keeping a history of it?

If it's really precious, it probably means you should be commit
--amend instead. You'd get the reflog, and essentially the same
functionalities.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
