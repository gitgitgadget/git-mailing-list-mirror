From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] commit: add commit.signoff config option
Date: Thu, 25 Jun 2015 20:56:42 +0200
Message-ID: <vpqvbebzket.fsf@anie.imag.fr>
References: <1435243807-32112-1-git-send-email-cmarcelo@gmail.com>
	<xmqqlhf725xy.fsf@gitster.dls.corp.google.com>
	<CADstYCamTxaLnZeYUma6t=KP3Fx2rQH3svqgCYP4WpAR9k_USg@mail.gmail.com>
	<xmqq4mlv22we.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Caio Marcelo de Oliveira Filho <cmarcelo@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 20:57:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8CKk-000514-GK
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jun 2015 20:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbbFYS5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 14:57:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58375 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752416AbbFYS4y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 14:56:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5PIueBS001624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Jun 2015 20:56:40 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5PIugYf024673;
	Thu, 25 Jun 2015 20:56:42 +0200
In-Reply-To: <xmqq4mlv22we.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Jun 2015 09:01:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 25 Jun 2015 20:56:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5PIueBS001624
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435863401.69813@7Tee3agJscBGn8fjUJemZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272713>

Junio C Hamano <gitster@pobox.com> writes:

> [commit]
>     signoff = "I certify that all my work is licenseable under DCO"

I like this one.

The paranoid version would be

    signoff = "I certify that all my work in /home/my/projects/foo are ..."

to avoid mistakenly have the config option applied to the wrong repo.
But that's probably overkill.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
