From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6b 5/8] branch: drop non-commit error reporting
Date: Fri, 25 Sep 2015 18:30:53 +0200
Message-ID: <vpq7fnebgw2.fsf@grenoble-inp.fr>
References: <1443031873-25280-1-git-send-email-Karthik.188@gmail.com>
	<1443118148-3470-1-git-send-email-Karthik.188@gmail.com>
	<vpqk2rfm4ag.fsf@grenoble-inp.fr>
	<xmqq4mii5w0m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 18:31:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfVtv-00054N-Ks
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 18:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbbIYQbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 12:31:01 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48430 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756344AbbIYQbA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 12:31:00 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t8PGUpBM026882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 25 Sep 2015 18:30:51 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t8PGUrq0018663;
	Fri, 25 Sep 2015 18:30:53 +0200
In-Reply-To: <xmqq4mii5w0m.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 25 Sep 2015 09:00:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Sep 2015 18:30:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t8PGUpBM026882
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1443803453.90879@ma7qEgd2Z3dk/+sOQarvRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278666>

Junio C Hamano <gitster@pobox.com> writes:

> While I was trying to address your "actually already report", I
> spotted a typo and then found that the early part of the second
> paragraph is a bit hard, so here is what I ended up with.

LGTM.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
