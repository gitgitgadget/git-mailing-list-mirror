From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Mon, 31 Aug 2015 10:30:11 +0200
Message-ID: <vpq37yzhncc.fsf@anie.imag.fr>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 10:30:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWKU4-0002dW-8F
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 10:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbbHaIa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 04:30:28 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53638 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbbHaIa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 04:30:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7V8UAHt013139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 31 Aug 2015 10:30:11 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V8UBkF010162;
	Mon, 31 Aug 2015 10:30:11 +0200
In-Reply-To: <1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sat, 29 Aug 2015 19:42:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 31 Aug 2015 10:30:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7V8UAHt013139
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441614614.24088@L3IRxOga5YKSaHBcC5LkBQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276855>

Hi,

Just a remark on the way iterations are going on with this series: I do
agree that each version gets better than the previous one, which is
good. However, I have the feeling that we're turning a simple and easy
to review series into a monster one (reading "v14 .../13" with a
non-trivial interdiff is a bit scary for reviewers).

Karthik: I think you could (should?) have splitted the work again.
You're integrating other people's idea in the series, and sometimes I
think at some point, a better way would have been: "OK, good idea, I'll
implement it in on top of this series" (and possibly implement it on top
before you resend, to make sure that the series is ready to welcome the
new feature). For example, %(contents:lines=X) is good, but could have
waited for the next series IMHO. This way, you get a shorter series to
converge faster (straightforward interdiff for the last iterations), and
then reviewers can focus on the next, short, series.

The opposite is Zeno paradox kind of series, where you add something new
every time you get close to getting merged, and you actually never reach
a stable state ;-).

That said, this particular series was a tough one for this, so I'm not
even sure my advice would have been applicable ^^.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
