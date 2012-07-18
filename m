From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/4] credential: convert "url" attribute into its parsed subparts
Date: Wed, 18 Jul 2012 14:24:01 +0200
Message-ID: <vpqeho9jlzy.fsf@bauges.imag.fr>
References: <20120718120307.GA6399@sigill.intra.peff.net>
	<20120718120626.GC6726@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 18 14:24:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrTIi-0005MS-8m
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 14:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753490Ab2GRMYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 08:24:16 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54376 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab2GRMYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 08:24:14 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6ICML7D013298
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2012 14:22:21 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SrTIQ-0004ti-IL; Wed, 18 Jul 2012 14:24:02 +0200
In-Reply-To: <20120718120626.GC6726@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Jul 2012 08:06:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 18 Jul 2012 14:22:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6ICML7D013298
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343218944.92492@unkTG9WFvsubaIwoPRlZpA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201682>

Jeff King <peff@peff.net> writes:

>   $ echo https://user@example.com | git credential ident
>   protocol=https
>   host=example.com
>   username=user
>
> since I had no use for it, but it would obviously be an easy one-liner
> to write (it's just "fill" without the actual fill call).

I was thinking the same, except I would have spelled it "git credential
parse" (but ident is fine too). On the perl side, that would allow
getting a credential hash very simply (but it was already simple in
perl, and made useless by your code).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
