From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 01/10] ref-filter: introduce 'ref_formatting_state'
Date: Tue, 28 Jul 2015 09:26:17 +0200
Message-ID: <vpqwpxk215y.fsf@anie.imag.fr>
References: <CAOLa=ZR6_2NBB4v0Ynq391=8Jk2RZON6R0YG=HKUNwKx249b7Q@mail.gmail.com>
	<1438065211-3777-1-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 09:26:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJzHP-0000aY-Ew
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 09:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbbG1H0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 03:26:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39424 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544AbbG1H0W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 03:26:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t6S7QGJ3021778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jul 2015 09:26:16 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6S7QHPM024990;
	Tue, 28 Jul 2015 09:26:17 +0200
In-Reply-To: <1438065211-3777-1-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Tue, 28 Jul 2015 12:03:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 28 Jul 2015 09:26:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6S7QGJ3021778
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438673177.41399@tymK1iFJ2bMFhbS5HLrn4w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274750>

Karthik Nayak <karthik.188@gmail.com> writes:

> -static void print_value(struct atom_value *v, int quote_style)
> +static void apply_formatting_state(struct ref_formatting_state *state,
> +				   struct atom_value *v, struct strbuf *value)
>  {
> -	struct strbuf sb = STRBUF_INIT;
> -	switch (quote_style) {
> +	/*  Eventually we'll formatt based on the ref_formatting_state */

s/formatt/format/

Also, we usually use a single space after /*.

(Neither is very important since it disapears in the next commit)

> +	/*
> +	 * Some (pesudo) atoms have no immediate side effect, but only

s/pesudo/pseudo/. But if you are to rename these atoms to "modifier
atoms", you should get rid of this "pseudo" here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
