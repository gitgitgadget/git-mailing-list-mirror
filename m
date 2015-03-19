From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Thu, 19 Mar 2015 14:35:49 +0100
Message-ID: <vpqy4mtrtxm.fsf@anie.imag.fr>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
	<1426662276-8728-4-git-send-email-pyokagan@gmail.com>
	<vpq3852dzry.fsf@anie.imag.fr>
	<CAPig+cTaQAnWoz7=v9tOPZoeE3LTV+H6KD_tAzmOXi3Tjay_WA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 14:36:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYacN-0001KQ-2q
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 14:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbbCSNgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 09:36:06 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48844 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381AbbCSNgE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 09:36:04 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t2JDZnTH032003
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Mar 2015 14:35:49 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t2JDZnfO003262;
	Thu, 19 Mar 2015 14:35:49 +0100
In-Reply-To: <CAPig+cTaQAnWoz7=v9tOPZoeE3LTV+H6KD_tAzmOXi3Tjay_WA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 18 Mar 2015 17:15:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 19 Mar 2015 14:35:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t2JDZnTH032003
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1427376951.88024@6RD/XYRsTBtRf8Ywoqk92Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265803>

Eric Sunshine <sunshine@sunshineco.com> writes:

> I also tend to favor adding "failure" tests which are flipped to
> "success" when appropriate, however, as this is an entirely new
> feature, this approach may be unsuitable (and perhaps overkill).

I can buy the "overkill", but not unsuitable. Even for new features, the
tests should fail before and pass after. Otherwise, the tests are not
testing the feature. Actually, this is a strong principle in test-driven
development: don't write code unless you have a failing test.

But I was just thinking out loudly, certainly not requesting a change.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
