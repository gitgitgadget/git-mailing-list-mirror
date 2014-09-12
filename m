From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/2] make config --add behave correctly for empty and NULL values
Date: Fri, 12 Sep 2014 10:15:14 +0200
Message-ID: <vpqegvhfe5p.fsf@anie.imag.fr>
References: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>
	<xmqqvbppwtir.fsf@gitster.dls.corp.google.com>
	<20140819051732.GA13765@peff.net>
	<xmqqmwb1vwvs.fsf@gitster.dls.corp.google.com>
	<20140819062000.GA7805@peff.net>
	<xmqqy4tpbuii.fsf@gitster.dls.corp.google.com>
	<54129F66.9080905@gmail.com> <54129FE1.6020303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 10:15:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSM17-0000jz-KD
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 10:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbaILIPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 04:15:34 -0400
Received: from mx1.imag.fr ([129.88.30.5]:39811 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbaILIPc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 04:15:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s8C8FEFs013464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 12 Sep 2014 10:15:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s8C8FE2D027301;
	Fri, 12 Sep 2014 10:15:14 +0200
In-Reply-To: <54129FE1.6020303@gmail.com> (Tanay Abhra's message of "Fri, 12
	Sep 2014 12:55:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 12 Sep 2014 10:15:14 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s8C8FEFs013464
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1411114516.51202@SvW/BOXl9rqbqN2BhUBPtg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256913>

Tanay Abhra <tanayabh@gmail.com> writes:

> +const char CONFIG_REGEX_NONE[] = "a^";

I have a slight preference for this version (no magic (void *)1 value,
and belts-and-suspenders solution since someone actually using the regex
should still get a correct behavior.

But I'm fine with both Junio/Peff's version or this one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
