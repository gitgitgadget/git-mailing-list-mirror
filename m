From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 1/2] add `config_set` API for caching config files
Date: Fri, 04 Jul 2014 11:43:26 +0200
Message-ID: <vpqsimhtq69.fsf@anie.imag.fr>
References: <1404280905-26763-1-git-send-email-tanayabh@gmail.com>
	<1404280905-26763-2-git-send-email-tanayabh@gmail.com>
	<vpqoax8m8bh.fsf@anie.imag.fr> <53B63461.2040300@gmail.com>
	<vpq1tu1xz2g.fsf@anie.imag.fr> <53B67322.1080408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 04 11:43:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X301m-0000RS-HX
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 11:43:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbaGDJna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2014 05:43:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56021 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbaGDJn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2014 05:43:29 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s649hPOI021489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Jul 2014 11:43:25 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s649hQqK029301;
	Fri, 4 Jul 2014 11:43:26 +0200
In-Reply-To: <53B67322.1080408@gmail.com> (Tanay Abhra's message of "Fri, 04
	Jul 2014 14:55:54 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 04 Jul 2014 11:43:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s649hPOI021489
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1405071806.12079@Xb233wxHgYNu15+NIWgSAw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252893>

Tanay Abhra <tanayabh@gmail.com> writes:

> One more doubt, does <filename,linenr> for every value has any use other than
> raising semantic error in typespecific API functions.

I don't see any other. My suggestion would be: ignore this for now, it's
not needed to get a new API that has at least as many features as the
existing one.

It's easy to add to the data-structure afterwards (although a bit less
easy to add to the code that fills-in the data structure).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
