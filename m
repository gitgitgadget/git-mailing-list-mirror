From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git: make "git -C '' <cmd>" not to barf
Date: Tue, 03 Mar 2015 17:22:09 +0100
Message-ID: <vpq385mgifi.fsf@anie.imag.fr>
References: <1425397291-25435-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:22:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSpaQ-0004p0-5L
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 17:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183AbbCCQWQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 11:22:16 -0500
Received: from mx2.imag.fr ([129.88.30.17]:46709 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756993AbbCCQWN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 11:22:13 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t23GM7WY005243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Mar 2015 17:22:07 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t23GM9rD018223;
	Tue, 3 Mar 2015 17:22:09 +0100
In-Reply-To: <1425397291-25435-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 3 Mar 2015 21:11:31 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 03 Mar 2015 17:22:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t23GM7WY005243
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426004528.69548@XtTv5c8BSpUVojRuX+mkZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264670>

Karthik Nayak <karthik.188@gmail.com> writes:

> now it works like cd "" which silently succeeds

Missing "." at end of sentence.

>  git.c | 4 +++-

That would probably also deserve a test.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
