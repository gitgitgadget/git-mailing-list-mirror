From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v2 5/5] send-email: refactor address list process
Date: Mon, 08 Jun 2015 18:21:38 +0200
Message-ID: <vpqmw0a2mst.fsf@anie.imag.fr>
References: <1433609976-1868-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433609976-1868-5-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpqk2ve9tfm.fsf@anie.imag.fr>
	<1247043051.275297.1433780082550.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:22:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1zoD-0005E4-W1
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbbFHQVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 12:21:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54245 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753269AbbFHQVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:21:42 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t58GLanp009714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Jun 2015 18:21:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t58GLcrL008555;
	Mon, 8 Jun 2015 18:21:38 +0200
In-Reply-To: <1247043051.275297.1433780082550.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Mon, 8 Jun 2015 18:14:42 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 08 Jun 2015 18:21:37 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t58GLanp009714
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434385297.38636@V/IO1gaci0FauKz3neRuKg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271066>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>> 
>> > Simplify code by creating a function to transform list of email lists
>> > (comma separated, with aliases ...)  into a simple list of valid email
>> > addresses.
>> 
>> I would have found the series easier to read if this refactoring came
>> earlier (and then PATCH 2/5 would fix the bug as a positive side effect
>> of the refactoring). I think it's too late to change this, though.
>
> Why is it to late? I can still change it if necessary.

To me, the series is ready now, and I don't think re-rolling it would be
a good time investment. Plus, I spent time reviewing this series and
with my proposal I'd need to review a relatively different one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
