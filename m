From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 0/7] Rewrite `git_config()` using config-set API
Date: Thu, 24 Jul 2014 17:39:53 +0200
Message-ID: <vpq1ttadauu.fsf@anie.imag.fr>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<xmqqiomnda1y.fsf@gitster.dls.corp.google.com>
	<53D12078.2070004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 17:40:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAL7m-00085I-W2
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 17:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759581AbaGXPkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 11:40:01 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59898 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759405AbaGXPj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 11:39:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6OFdps7013467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 Jul 2014 17:39:51 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6OFdrvo007560;
	Thu, 24 Jul 2014 17:39:53 +0200
In-Reply-To: <53D12078.2070004@gmail.com> (Tanay Abhra's message of "Thu, 24
	Jul 2014 20:34:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 24 Jul 2014 17:39:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6OFdps7013467
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406821192.42505@Qt0KknkF+i5nWlI2JBu7Hg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254163>

Tanay Abhra <tanayabh@gmail.com> writes:

> I am attaching the v12 with two new functions git_configset_get_string() &
> git_configset_get_string_const().

Didn't you intend to change git_config_get_string to let it die in case
of error instead of returning an error code?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
