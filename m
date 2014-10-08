From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously set variables
Date: Wed, 08 Oct 2014 20:37:27 +0200
Message-ID: <vpq61fujtlk.fsf@anie.imag.fr>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<xmqqvbo2meg5.fsf@gitster.dls.corp.google.com>
	<5433CBC3.5010202@gmail.com>
	<xmqq1tqjkexe.fsf@gitster.dls.corp.google.com>
	<vpqzjd7kta6.fsf@anie.imag.fr>
	<xmqqy4sqbi12.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Jakub =?utf-8?Q?Nar=C4=99bs?= =?utf-8?Q?ki?= <jnareb@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 20:37:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbw7V-0003Tt-OV
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 20:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753639AbaJHSht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 14:37:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55559 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751460AbaJHShs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 14:37:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s98IbPC8031485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 8 Oct 2014 20:37:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s98IbRlj009763;
	Wed, 8 Oct 2014 20:37:27 +0200
In-Reply-To: <xmqqy4sqbi12.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 08 Oct 2014 10:14:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 08 Oct 2014 20:37:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s98IbPC8031485
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1413398246.90862@bV3A6wQiXKepJot6CKTG/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I do not offhand think of a good example of an variable that we may
> want to allow overriding but still want to limit its values myself.

I just thought of a semi-realistic use-case : diff.*.{command,textconv}.

One may want to allow per-project sets of diff drivers, but these
variables contain actual commands, so clearly we can't allow any
value for these variables.

"semi-realistic" only because I never needed a per-project diff driver,
I have my per-user preference and I'm happy with it.

Anyway, the feature does not seem vital to me, but if someone comes up
with a clever way to keep room for it in the namespace, that would be
cool.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
