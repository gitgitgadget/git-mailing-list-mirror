From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/5] status: show the ref that is checked out, even if it's detached
Date: Tue, 05 Mar 2013 13:18:59 +0100
Message-ID: <vpqd2ve9gzw.fsf@grenoble-inp.fr>
References: <1362303681-6585-1-git-send-email-pclouds@gmail.com>
	<1362303681-6585-5-git-send-email-pclouds@gmail.com>
	<7vy5e49l3i.fsf@alter.siamese.dyndns.org>
	<20130305113958.GA26236@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 13:19:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCqqE-0003Se-EA
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 13:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab3CEMTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 07:19:07 -0500
Received: from mx1.imag.fr ([129.88.30.5]:36063 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367Ab3CEMTG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 07:19:06 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r25CIxTq006017
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Mar 2013 13:18:59 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UCqpg-0003br-6t; Tue, 05 Mar 2013 13:19:00 +0100
In-Reply-To: <20130305113958.GA26236@lanh> (Duy Nguyen's message of "Tue, 5
	Mar 2013 18:39:58 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 05 Mar 2013 13:18:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r25CIxTq006017
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363090739.99918@gz7+VrtknY/sSN1asO0cWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217447>

Duy Nguyen <pclouds@gmail.com> writes:

> -	# Not currently on any branch.
> +	# Detached at $ONTO

Without the context, I don't think "Detached" alone says something to
the user. "Detached HEAD at ..." would IMHO be clearer and at least give
the user enough keywords to search the web/doc for an explanation.

Actually, in the case of "Detached HEAD at $branch", you may even add an
advice saying something like:

  (run "git checkout $branch" to switch to branch $branch)

or so. But that's not the common case, so maybe it's not that useful.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
