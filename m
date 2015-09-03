From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v15 07/13] ref-filter: add support for %(contents:lines=X)
Date: Thu, 03 Sep 2015 17:05:08 +0200
Message-ID: <vpqoahjfsrf.fsf@anie.imag.fr>
References: <1441131994-13508-1-git-send-email-Karthik.188@gmail.com>
	<1441131994-13508-8-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRJG7t1M-FyrB84UG4Ar_NBW3J+wFvFeLg599sAEAweHw@mail.gmail.com>
	<CAPig+cS9mBNhCm2Ea9jkAK7ME9U1QJ=xYgF_zWzThTVsZCHmdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 17:05:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXW4t-0000Kc-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 17:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632AbbICPFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 11:05:19 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51877 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573AbbICPFS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 11:05:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t83F57KX006156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 3 Sep 2015 17:05:07 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t83F58XG018668;
	Thu, 3 Sep 2015 17:05:08 +0200
In-Reply-To: <CAPig+cS9mBNhCm2Ea9jkAK7ME9U1QJ=xYgF_zWzThTVsZCHmdQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 3 Sep 2015 10:47:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Sep 2015 17:05:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t83F57KX006156
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441897510.72254@Hu7oG7+zl4eEgrGWPOaF9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277210>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Also, if 'buf' is indeed unconditionally NUL-terminated, then the (sp
> <= buf + size) check is wasted code since the result of strstr() will
> always be either NULL or pointing somewhere within the NUL-terminated
> string.

The null character is there, but after the signature. buf + size points
before the signature.

Anyway, all this should go away if Karthik applies my suggestion, which
I like even more after this discussion ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
