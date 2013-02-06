From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 3/4] grep: allow to use textconv filters
Date: Wed, 06 Feb 2013 16:12:50 +0100
Message-ID: <vpqip65xyq5.fsf@grenoble-inp.fr>
References: <20130205201106.GA29248@sigill.intra.peff.net>
	<cover.1360162813.git.git@drmicha.warpmail.net>
	<da8c01b918c94c84ab61859b1b1453885bff5b06.1360162813.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 16:13:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36gn-0007CV-0v
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730Ab3BFPNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:13:11 -0500
Received: from mx1.imag.fr ([129.88.30.5]:53762 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572Ab3BFPNI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 10:13:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r16FCnJW028779
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Feb 2013 16:12:49 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U36g6-0002SB-L6; Wed, 06 Feb 2013 16:12:50 +0100
In-Reply-To: <da8c01b918c94c84ab61859b1b1453885bff5b06.1360162813.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Wed, 6 Feb 2013 16:08:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 06 Feb 2013 16:12:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r16FCnJW028779
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360768372.77434@Yl/P2npW84I/Q/PuSd3C4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215588>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Introduce an option "--textconv" which makes git grep use any configured
> textconv filters for grepping and output purposes. It is off by default.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/grep.c |   2 ++
>  grep.c         | 100 +++++++++++++++++++++++++++++++++++++++++++++++++--------
>  grep.h         |   1 +

Don't forget to update Documentation/git-grep.txt too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
