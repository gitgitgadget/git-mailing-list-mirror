From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 05/19] ref-filter: add parse_opt_merge_filter()
Date: Mon, 22 Jun 2015 13:13:05 +0200
Message-ID: <vpq381kc7y6.fsf@anie.imag.fr>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
	<1434919705-4884-1-git-send-email-karthik.188@gmail.com>
	<1434919705-4884-5-git-send-email-karthik.188@gmail.com>
	<CAPc5daUkHb5sQ_d-g0EeFwXTkFUf4=PVV=QcV-nekObKSJL27g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 13:13:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6zfC-0000s6-AY
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 13:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbbFVLNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 07:13:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45191 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbbFVLNN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 07:13:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5MBD4Ih007007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Jun 2015 13:13:04 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5MBD5kW010226;
	Mon, 22 Jun 2015 13:13:05 +0200
In-Reply-To: <CAPc5daUkHb5sQ_d-g0EeFwXTkFUf4=PVV=QcV-nekObKSJL27g@mail.gmail.com>
	(Junio C. Hamano's message of "Sun, 21 Jun 2015 17:55:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 22 Jun 2015 13:13:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5MBD4Ih007007
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435576387.18514@vMPjYRLaTuipPsSQJ61+VQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272332>

Junio C Hamano <gitster@pobox.com> writes:

>> This is copied from 'builtin/branch.c' which will eventually be removed
>> when we port 'branch.c' to use ref-filter APIs.
>
> Hmph. I somehow thought Matthieu's instruction was to finish tag.c
> side first

I would call in "advice" rather than "instruction". I still think we
should prioritize the tag.c side, but if this patch is ready, it makes
sense to keep it in the series.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
