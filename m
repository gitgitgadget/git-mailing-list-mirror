From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 000/142] Use the $( ... ) construct for command substitution instead of using the back-quotes
Date: Wed, 26 Mar 2014 08:02:27 +0100
Message-ID: <vpqlhvx8mt8.fsf@anie.imag.fr>
References: <1395768283-31135-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqy4zyktng.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 08:02:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WShrI-0007x2-72
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 08:02:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbaCZHCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 03:02:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33575 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793AbaCZHCk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 03:02:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s2Q72X7p017912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Mar 2014 08:02:33 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2Q72RfZ005126;
	Wed, 26 Mar 2014 08:02:27 +0100
In-Reply-To: <xmqqy4zyktng.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 25 Mar 2014 11:41:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 26 Mar 2014 08:02:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2Q72X7p017912
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396422154.18358@bv+uw9FVSDwlPJ4MKGX9Yw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245160>

Junio C Hamano <gitster@pobox.com> writes:

>  - Nobody has time or energy to go through 140+ patches in one go,
>    with enough concentration necessary to do so without making
>    mistakes (this applies to yourself, too---producing mechanical
>    replacement is a no-cost thing, finding mistakes in mechanical
>    replacement takes real effort).

It's a bit less bad than it seems:

 142 files changed, 609 insertions(+), 609 deletions(-)

The first pass I did was a very quick one, but I already went through
the patches I received (apparently not the whole series) and it wasn't
that long.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
