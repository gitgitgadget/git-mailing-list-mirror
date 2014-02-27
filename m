From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: An idea for "git bisect" and a GSoC enquiry
Date: Thu, 27 Feb 2014 13:09:52 +0100 (CET)
Message-ID: <239563375.177900.1393502992014.JavaMail.zimbra@imag.fr>
References: <CAL0uuq0=Zo0X8mYRD6q-Q+QAcZhfmxOwKiRegDrRm3O_i0Q+EA@mail.gmail.com> <530F1F11.7060403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>,
	git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 27 13:32:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ08Q-0001sE-J2
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 13:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbaB0McN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 07:32:13 -0500
Received: from mx2.imag.fr ([129.88.30.17]:38211 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbaB0McL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 07:32:11 -0500
X-Greylist: delayed 1330 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2014 07:32:11 EST
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s1RC9oGk030787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Feb 2014 13:09:50 +0100
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1RC9p9X001506;
	Thu, 27 Feb 2014 13:09:51 +0100
In-Reply-To: <530F1F11.7060403@alum.mit.edu>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.6_GA_5922 (ZimbraWebClient - FF27 (Linux)/8.0.6_GA_5922)
Thread-Topic: An idea for "git bisect" and a GSoC enquiry
Thread-Index: d08UKGHnPU+sN9Naj6jCDVgW6tCRXg==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 27 Feb 2014 13:09:50 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1RC9oGk030787
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1394107793.20235@kShTAd21QCPiew+ys5GYhA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242815>

----- Original Message -----
> I don't understand the benefit of adding a new command "mark" rather
> than continuing to use "good", "bad", plus new commands "unfixed" and
> "fixed".  Does this solve any problems?

I think it could be interesting to allow arbitrary words here. For example, I recently walked through history to find a performance regression, it would have been natural to use slow/fast instead of bad/good (bad/good would actually do the job, but slightly less naturally). One can look for a change which is neither a fix nor a bug (e.g. when did command foo start behaving like that? when did we start using such or such feature in the code).

I wouldn't fight for it, but I think it makes sense.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
