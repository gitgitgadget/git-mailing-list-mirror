From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Wed, 17 Jun 2015 09:05:21 +0200
Message-ID: <vpq1tha4xxq.fsf@anie.imag.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqy4jq2rjr.fsf@anie.imag.fr>
	<1155395826.552092.1434285546884.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<835646176.485512.1434310200681.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqoakh74fw.fsf@anie.imag.fr>
	<183774662.562924.1434489533064.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 09:05:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z57Pq-0008EH-Ur
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 09:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbbFQHFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 03:05:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42289 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458AbbFQHFh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 03:05:37 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5H75K7W018267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Jun 2015 09:05:20 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5H75Lso028275;
	Wed, 17 Jun 2015 09:05:21 +0200
In-Reply-To: <183774662.562924.1434489533064.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Tue, 16 Jun 2015 23:18:53 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 17 Jun 2015 09:05:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5H75K7W018267
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435129521.15669@Jv8omtdCNQ7gy7unYdReRQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271811>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>># terms_defined is 0 when the user did not define the terms explicitely
>># yet. This is the case when running 'git bisect start bad_rev good_rev'
>># before we see an explicit reference to a term.
>>terms_defined=0
>
> The thing is:
> 'git bisect reset
> git bisect new HEAD

"git bisect new" does not exist. Did you mean "git bisect start HEAD"?

> (autostart ?) y'
>
> is strictly equivalent to
>
> 'git bisect reset
> git bisect start
> git bisect new HEAD'
>
> In both case terms_defined value would be 0 while we kinda know that a
> term has been used.

I don't understand. The user didn't say either "bad" or "good", so in
both cases we haven't seen a term yet. Or I misunderstood what you meant
by "define a term".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
