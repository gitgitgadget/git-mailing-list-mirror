From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Thu, 26 Jun 2008 14:01:56 +0200
Message-ID: <vpqy74scsln.fsf@bauges.imag.fr>
References: <20080624222105.GA24549@dervierte>
	<1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
	<7vwskea2ik.fsf@gitster.siamese.dyndns.org>
	<48620C1A.6000509@panasas.com>
	<alpine.DEB.1.00.0806251109380.9925@racer>
	<486220CE.3070103@viscovery.net>
	<alpine.DEB.1.00.0806251334060.9925@racer>
	<20080625135100.GF20361@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 26 14:04:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBqDE-00061S-3f
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 14:04:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbYFZMDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 08:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbYFZMDc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 08:03:32 -0400
Received: from imag.imag.fr ([129.88.30.1]:34740 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754744AbYFZMDb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 08:03:31 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m5QC22Ld004398
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 26 Jun 2008 14:02:03 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KBqAm-0001Tb-JS; Thu, 26 Jun 2008 14:01:56 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KBqAm-0006ki-H2; Thu, 26 Jun 2008 14:01:56 +0200
In-Reply-To: <20080625135100.GF20361@mit.edu> (Theodore Tso's message of "Wed\, 25 Jun 2008 09\:51\:00 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 26 Jun 2008 14:02:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86441>

Theodore Tso <tytso@mit.edu> writes:

> for i in $*

Detail: you meant "$@", your version isn't whitespace-robust.

-- 
Matthieu
