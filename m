From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy config option is not set
Date: Wed, 29 Feb 2012 10:55:34 +0100
Message-ID: <vpqlinmq7zd.fsf@bauges.imag.fr>
References: <4F4CCE8A.4010800@seap.minhap.es>
	<20120228191514.GD11260@sigill.intra.peff.net>
	<4F4D2AAD.3040107@vilain.net>
	<20120228193443.GB11725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sam Vilain <sam@vilain.net>,
	Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	sam.vilain@catalyst.net.nz
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 10:56:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2gHC-0004Bg-1B
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 10:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245Ab2B2J4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 04:56:38 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47643 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965538Ab2B2J4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 04:56:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q1T9pqUi001561
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 29 Feb 2012 10:51:52 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S2gFz-0000p2-RR; Wed, 29 Feb 2012 10:55:35 +0100
In-Reply-To: <20120228193443.GB11725@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 28 Feb 2012 14:34:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 29 Feb 2012 10:51:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1T9pqUi001561
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331113913.85111@wWHBK5aSSi3hyfiUfpBeqA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191831>

Jeff King <peff@peff.net> writes:

> Good point. We sometimes follow this order:
>
>   1. git-specific environment variables (i.e., $GIT_HTTP_PROXY, if
>      it existed)
>   2. git config files (i.e., http.proxy)
>   3. generic system environment (i.e., $http_proxy).

Yes, just like $EDITOR << core.editor << $GIT_EDITOR.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
