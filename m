From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 6/7] send-email: suppress leading and trailing whitespaces in addresses
Date: Wed, 10 Jun 2015 10:17:20 +0200
Message-ID: <vpqr3pk9dv3.fsf@anie.imag.fr>
References: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 10:17:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2bCf-00040o-2q
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 10:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214AbbFJIRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 04:17:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51073 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754168AbbFJIRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 04:17:25 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5A8HKEV015974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 10:17:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5A8HK67014449;
	Wed, 10 Jun 2015 10:17:20 +0200
In-Reply-To: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Tue, 9 Jun 2015 20:50:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 10 Jun 2015 10:17:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5A8HKEV015974
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434529041.00793@5lUjSawtn6oJyIANTTCgow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271275>

Nothing serious, but you did something weird while sending. This message
does not have a References: or an In-reply-to: field, so it breaks
threading. See how it's displayed on

  http://thread.gmane.org/gmane.comp.version-control.git

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Remove leading and trailing whitespaces when sanitizing addresses so
> that git send-email give the same output when passing arguments like
> " jdoe@example.com   " or "\t jdoe@example.com " as with
> "jdoe@example.com".
>
> The next commit will introduce a test for this aswell.

s/aswell/as well/

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
