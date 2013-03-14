From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [ANN] git-arr 0.11
Date: Thu, 14 Mar 2013 13:43:16 +0100
Message-ID: <vpqppz22luj.fsf@grenoble-inp.fr>
References: <20130313234143.GD14686@blitiri.com.ar>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alberto Bertogli <albertito@blitiri.com.ar>
X-From: git-owner@vger.kernel.org Thu Mar 14 13:43:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG7Vd-0006dN-4V
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 13:43:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757695Ab3CNMnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 08:43:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58959 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757681Ab3CNMnV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 08:43:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r2EChFAs016871
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 14 Mar 2013 13:43:15 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UG7V7-0000nr-0P; Thu, 14 Mar 2013 13:43:17 +0100
In-Reply-To: <20130313234143.GD14686@blitiri.com.ar> (Alberto Bertogli's
	message of "Wed, 13 Mar 2013 23:41:43 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 14 Mar 2013 13:43:15 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r2EChFAs016871
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363869796.70782@/6HrUiJbMUKxzkfFMy4ctg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218133>

Alberto Bertogli <albertito@blitiri.com.ar> writes:

> I wanted to let you know about git-arr, which is a git repository
> browser that can generate static HTML instead of having to run
> dynamically.

Can it run incrementally? I mean, if you have launched it for one
revision, does re-running it on the next revision regenerate the whole
set of pages, or does it only generate new pages?

If so, that could be a nice way to replace dynamic browsers for people
who do not have/want dynamic webpages, by just setting a hook or cron
job that generate the new pages when an update is made.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
