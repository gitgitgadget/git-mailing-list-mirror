From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 05/14] txt-to-pot.sh: use the $( ... ) construct for command substitution
Date: Wed, 23 Apr 2014 16:44:14 +0200
Message-ID: <vpq4n1kw1fl.fsf@anie.imag.fr>
References: <1398260646-2660-1-git-send-email-gitter.spiros@gmail.com>
	<1398260646-2660-5-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 16:44:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcyPV-0000AV-3g
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 16:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbaDWOoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 10:44:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43759 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756214AbaDWOoV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 10:44:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3NEiDif011356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Apr 2014 16:44:13 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3NEiEBZ029261;
	Wed, 23 Apr 2014 16:44:14 +0200
In-Reply-To: <1398260646-2660-5-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Wed, 23 Apr 2014 06:43:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 23 Apr 2014 16:44:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3NEiDif011356
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1398869057.70308@y7KZ7HQltzQB2PxkfaGZ5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246844>

Elia Pinto <gitter.spiros@gmail.com> writes:

>  git-gui/po/glossary/txt-to-pot.sh |    4 ++--

git-gui is a separate project, patches are normally applied to git-gui
first, and then pulled by Junio.

I'd suggest dropping this patch, it's probably not worth the trouble
(although the patch is correct).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
