From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v2 5/5] send-email: refactor address list process
Date: Mon, 08 Jun 2015 16:16:29 +0200
Message-ID: <vpqk2ve9tfm.fsf@anie.imag.fr>
References: <1433609976-1868-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433609976-1868-5-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 16:16:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1xrA-0000R5-0E
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 16:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbbFHOQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 10:16:37 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35448 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236AbbFHOQc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 10:16:32 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t58EGRDA004559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 16:16:27 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58EGTJx005882;
	Mon, 8 Jun 2015 16:16:29 +0200
In-Reply-To: <1433609976-1868-5-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Sat, 6 Jun 2015 18:59:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 08 Jun 2015 16:16:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58EGRDA004559
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434377788.40444@VityLrWgDJXqxmxOELGnrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271033>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Simplify code by creating a function to transform list of email lists
> (comma separated, with aliases ...)  into a simple list of valid email
> addresses.

I would have found the series easier to read if this refactoring came
earlier (and then PATCH 2/5 would fix the bug as a positive side effect
of the refactoring). I think it's too late to change this, though.

>  I'm not sure about the name of the function...

process_address_list() sounds good to me.

The whole series looks good to me now.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
