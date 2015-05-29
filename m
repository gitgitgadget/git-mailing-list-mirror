From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Fri, 29 May 2015 19:55:59 +0200
Message-ID: <vpqh9qvp8sw.fsf@anie.imag.fr>
References: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1432809733-4321-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<xmqq382giokd.fsf@gitster.dls.corp.google.com>
	<87oal32wuj.fsf@ensimag.grenoble-inp.fr>
	<xmqqa8wne50t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 29 19:56:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyOVv-0003bH-CB
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 19:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756681AbbE2R4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 13:56:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:48710 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756149AbbE2R4G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 13:56:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t4THtvm3019604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 29 May 2015 19:55:57 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4THtxrJ005977;
	Fri, 29 May 2015 19:55:59 +0200
In-Reply-To: <xmqqa8wne50t.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 29 May 2015 09:13:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 May 2015 19:55:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4THtvm3019604
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433526959.49066@HOe1aT14Py4tAUPq5D9wZA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270260>

Junio C Hamano <gitster@pobox.com> writes:

> Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>
>> Yes, that works if Foo is in an alias file, so that's clearly a bad
>> example, I added quotes:
>>
>> 	git send-email --to='"Foo, Bar" <foobar@example.com>'
>
> I'd further suggest replacing ", Bar" with something a bit more
> realistic that people use in real life, e.g. ", Esq." or ", PhD"
> (e.g. "Jane Doe, Esq.")

Why not, but it's also not uncommon to see "Last, First", like
"Moy, Matthieu" <Matthieu.Moy@imag.fr>.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
