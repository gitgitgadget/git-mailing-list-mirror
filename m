From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [WIP/PATCH v4 6/8] for-each-ref: rename some functions and make them public
Date: Mon, 01 Jun 2015 08:38:57 +0200
Message-ID: <vpqoal0hr0e.fsf@anie.imag.fr>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-6-git-send-email-karthik.188@gmail.com>
	<CAP8UFD080Yuv-CYcDzAG0u6OV7Sqry=0s1HKoJbt5wfKjTNO3Q@mail.gmail.com>
	<CAP8UFD1TTMfruCE-+GT-LzhK5C9LorStPbn64tZ-hhAkC=8Bdw@mail.gmail.com>
	<556AD1B2.3080502@gmail.com>
	<CAP8UFD117bJotFQSGjGnSub_0Xq=3wH2o3Du4c49xvmMxAyFDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 08:39:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzJNN-0001hL-3H
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 08:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbbFAGjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 02:39:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54534 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbbFAGjB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 02:39:01 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t516cudR025198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 1 Jun 2015 08:38:56 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t516cvQM006732;
	Mon, 1 Jun 2015 08:38:57 +0200
In-Reply-To: <CAP8UFD117bJotFQSGjGnSub_0Xq=3wH2o3Du4c49xvmMxAyFDQ@mail.gmail.com>
	(Christian Couder's message of "Sun, 31 May 2015 16:03:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 01 Jun 2015 08:38:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t516cudR025198
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433745537.62016@LDWHDZbhC2xsYbRrgMutMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270376>

Christian Couder <christian.couder@gmail.com> writes:

> sort_refs() -> ref_array_sort()
> struct ref_sort -> struct ref_sort_criteria
> default_sort() -> ref_default_sort_criteria()
> opt_parse_sort() -> opt_parse_ref_sort_criteria()

BTW, having such summary in the log message would help review: we could
think and discuss the naming by looking just at the summary, and then
check that you did it correctly (easy).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
