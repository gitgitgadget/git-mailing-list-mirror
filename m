From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 4/8] branch: move 'current' check down to the presentation layer
Date: Sun, 13 Sep 2015 14:15:36 +0200
Message-ID: <vpq4miyv7kn.fsf@anie.imag.fr>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-5-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 13 14:15:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zb6CG-0005ll-0U
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 14:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbbIMMPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 08:15:43 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49995 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751516AbbIMMPm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 08:15:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t8DCFZKo011700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sun, 13 Sep 2015 14:15:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8DCFa4m003998;
	Sun, 13 Sep 2015 14:15:36 +0200
In-Reply-To: <1442129035-31386-5-git-send-email-Karthik.188@gmail.com>
	(Karthik Nayak's message of "Sun, 13 Sep 2015 12:53:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 13 Sep 2015 14:15:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8DCFZKo011700
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1442751336.49703@UG6Wfyk+phe4HT/uDw+53Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277776>

Karthik Nayak <karthik.188@gmail.com> writes:

> We check if given ref is the current branch in print_ref_list(). Move
> this check to print_ref_item() where it is checked right before
> printing.

You may want to add a sentence saying why this is good. Given the
context, it's relatively clear that this makes the code closer to the
shape expected by ref-filter, but if you imagine someone bisecting or
blaming and finding this commit in another context, that person may
appreciate more explanation.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
