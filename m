From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 3/9] for-each-ref: add '--points-at' option
Date: Wed, 10 Jun 2015 09:39:50 +0200
Message-ID: <vpqeglkc8qh.fsf@anie.imag.fr>
References: <5573520A.90603@gmail.com>
	<1433621052-5588-1-git-send-email-karthik.188@gmail.com>
	<1433621052-5588-3-git-send-email-karthik.188@gmail.com>
	<xmqqzj4a9fpn.fsf@gitster.dls.corp.google.com>
	<5576D591.6030704@gmail.com>
	<xmqqvbew66q9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 09:40:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2acF-0006oJ-DB
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 09:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbbFJHj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 03:39:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34476 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbbFJHj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 03:39:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5A7doF8001219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Jun 2015 09:39:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5A7do9g013399;
	Wed, 10 Jun 2015 09:39:51 +0200
In-Reply-To: <xmqqvbew66q9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 09 Jun 2015 12:07:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 10 Jun 2015 09:39:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5A7doF8001219
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434526791.60789@cv6tZoXGf5W+Y9SOTAe3XA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271267>

Junio C Hamano <gitster@pobox.com> writes:

> Don't do that.  Always start your function like so:
>
> 	type funcname(args)
>         {
>         	declarations;
>
>                 first statement;
> 		...

Hint: create a file config.mak with this content:

$ cat config.mak
CFLAGS += -Wdeclaration-after-statement -Wall -Werror

and gcc will prevent you from doing this mistake again.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
