From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC v2 2/2] git-am: add am.threeWay config variable
Date: Tue, 02 Jun 2015 15:37:27 +0200
Message-ID: <vpqvbf6jko8.fsf@anie.imag.fr>
References: <1433251472-29460-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433251472-29460-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 02 15:38:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzmNs-000287-6B
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 15:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758907AbbFBNhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 09:37:32 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37416 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009AbbFBNhb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 09:37:31 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t52DbQqj020275
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Jun 2015 15:37:26 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t52DbRuw012427;
	Tue, 2 Jun 2015 15:37:27 +0200
In-Reply-To: <1433251472-29460-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Tue, 2 Jun 2015 15:24:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 02 Jun 2015 15:37:26 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t52DbQqj020275
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433857046.73439@TuDgJ9Yyi2g7xB6nv9hilQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270532>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> +if test "$(git config --bool --get am.threeWay)" = true
> +then
> +    threeway=t
> +fi

I think you missed Paul's remark on this:

http://article.gmane.org/gmane.comp.version-control.git/270150

Not terribly important since am will be rewritten soon, though.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
