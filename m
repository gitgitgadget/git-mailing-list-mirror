From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 08/10] tag.c: use 'ref-filter' APIs
Date: Thu, 09 Jul 2015 15:43:41 +0200
Message-ID: <vpqvbdt5tv6.fsf@anie.imag.fr>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
	<1436437671-25600-1-git-send-email-karthik.188@gmail.com>
	<559E5333.7080901@gmail.com> <vpqa8v58pka.fsf@anie.imag.fr>
	<CAOLa=ZSp-X0Mo5BGWghdk56sM2AEAmnXZt7Y3VkfXWvf8rh96w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 15:43:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDC7C-00033Y-Og
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 15:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbbGINnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 09:43:47 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38967 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbbGINnq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 09:43:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t69DhdXP011665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 9 Jul 2015 15:43:39 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t69DhfUP018509;
	Thu, 9 Jul 2015 15:43:41 +0200
In-Reply-To: <CAOLa=ZSp-X0Mo5BGWghdk56sM2AEAmnXZt7Y3VkfXWvf8rh96w@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 9 Jul 2015 18:25:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 09 Jul 2015 15:43:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t69DhdXP011665
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1437054221.98496@j0gyFted8B2Flw5m+ap6SQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273753>

Karthik Nayak <karthik.188@gmail.com> writes:

> If anyone can help, this is what it's saying.
> "[Net::SMTP::SSL] Connection closed at

Perhaps your SMTP server thought you were sending too many emails to too
many people and closed the connection thinking you were a spammer.

If you're having this kind of issues, it may make sense to run
"format-patch" and "send-email" as two separate steps. This way, you can
re-run "send-email" on the pieces which failed manually (adjusting
--in-reply-to).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
