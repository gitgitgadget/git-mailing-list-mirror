From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 7/7] bisect: allows any terms set by user
Date: Mon, 15 Jun 2015 10:56:15 +0200
Message-ID: <vpq381t73kg.fsf@anie.imag.fr>
References: <1433962918-6536-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433962918-6536-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqy4jq2rjr.fsf@anie.imag.fr>
	<323480549.485629.1434310820944.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<771291489.485827.1434312326536.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 15 10:56:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4QC0-00074Y-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 10:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbbFOI4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 04:56:24 -0400
Received: from mx2.imag.fr ([129.88.30.17]:54672 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944AbbFOI4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 04:56:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5F8uEVh032441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 15 Jun 2015 10:56:14 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5F8uFsN011223;
	Mon, 15 Jun 2015 10:56:15 +0200
In-Reply-To: <771291489.485827.1434312326536.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Sun, 14 Jun 2015 22:05:26 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 15 Jun 2015 10:56:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5F8uEVh032441
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1434963375.89038@lrUSPThF/JvfjzzByocv2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271666>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> To submit a v3 I would need answer about how we rebase the commit 
> history and what do we do to simplify the life of the user with the 
> terms (see my last mails). 
> I was thinking of: 
> -a config variable that would say :"as long as I don't reset keep 
> the terms of the previous bisection" 
> or we could decided that this is the default behaviour of bisect. 
>
> -two config variables to choose default terms 

I'd say: keep it simple, try to close this series ASAP. It'll still be
time to send another series once this one has settled.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
