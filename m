From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-am: add am.threeWay config variable
Date: Tue, 18 Aug 2015 11:36:36 +0200
Message-ID: <vpqfv3h9bvf.fsf@anie.imag.fr>
References: <1438697966-4958-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 11:36:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRdK7-0000hG-6G
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 11:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbbHRJgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 05:36:45 -0400
Received: from mx1.imag.fr ([129.88.30.5]:55237 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbbHRJgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 05:36:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t7I9aahd022215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 18 Aug 2015 11:36:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7I9aaov000609;
	Tue, 18 Aug 2015 11:36:36 +0200
In-Reply-To: <1438697966-4958-1-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Tue, 4 Aug 2015 22:19:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 18 Aug 2015 11:36:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7I9aahd022215
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440495398.01245@qAfa5PBd9YMLpGecnKiqOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276122>

Paul Tan <pyokagan@gmail.com> writes:

> From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
>
> Add the am.threeWay configuration variable to use the -3 or --3way
> option of git am by default. When am.threeway is set and not desired
> for a specific git am command, the --no-3way option can be used to
> override it.
>
> Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
> I tweaked Remi's patch so it is implemented on top of builtin/am.c. Hopefully
> there will be no regressions this time ;)

Thanks for doing this.

I don't remember the details of the regression we had with the shell
version, but that would probably deserve an additional test to enforce
the "Hopefully there will be no regressions" part of your message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
