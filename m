From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 2/3] Show items of interactive git-clean in columns
Date: Fri, 03 May 2013 14:54:59 +0200
Message-ID: <vpqfvy4b4v0.fsf@grenoble-inp.fr>
References: <6e795640952cad0eb25cb0db4243b2712f11e957.1367500374.git.worldhello.net@gmail.com>
	<vpq38u6n397.fsf@grenoble-inp.fr>
	<3b80db3d2e8f31b1d9373406cce3cbdee2094a29.1367500374.git.worldhello.net@gmail.com>
	<vpqppx9fmpu.fsf@grenoble-inp.fr>
	<CANYiYbGsMbJ=Ra6_fv12fnC_-Y5YfdWMgnROFWxo+Y=mkPKsiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 14:55:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYFW9-0006j0-T7
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 14:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761770Ab3ECMzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 08:55:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43656 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761668Ab3ECMzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 08:55:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r43CswaV009803
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 3 May 2013 14:54:58 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UYFVr-0003jz-Rs; Fri, 03 May 2013 14:54:59 +0200
In-Reply-To: <CANYiYbGsMbJ=Ra6_fv12fnC_-Y5YfdWMgnROFWxo+Y=mkPKsiA@mail.gmail.com>
	(Jiang Xin's message of "Fri, 3 May 2013 09:26:21 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 03 May 2013 14:54:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r43CswaV009803
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1368190500.35704@P+WJegL7rl3qtolEN8bc0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223311>

Jiang Xin <worldhello.net@gmail.com> writes:

> Rewrite the log as following:

That's probably more than needed ;-). Thanks,

> Show items of interactive git-clean in columns
>
> When there are lots of items to be cleaned, it is hard to see them all
> in one screen. Show them in columns instead of in one column will solve
> this problem.
>
> Since no longer show items to be cleaned using the "Would remove ..."

"Since _we_ no longer ..."?

> Will honors column.ui config variable only, not introduce new config variable.
> So no more documentations needed ;-)

I don't think it's a good idea. Usually, the *.ui variables are
shortcuts for "set all the individual variables", and having things
customizeable by column.ui and not by anything else breaks this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
