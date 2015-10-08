From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 02/10] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date: Thu, 08 Oct 2015 20:51:08 +0200
Message-ID: <vpqpp0pmbxf.fsf@grenoble-inp.fr>
References: <1444295885-1657-1-git-send-email-Karthik.188@gmail.com>
	<1444295885-1657-3-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 20:51:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkGHh-0001Np-8e
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 20:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138AbbJHSvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 14:51:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:44072 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbbJHSvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 14:51:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t98Ip6ss011723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 8 Oct 2015 20:51:07 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t98Ip8C1009539;
	Thu, 8 Oct 2015 20:51:08 +0200
In-Reply-To: <1444295885-1657-3-git-send-email-Karthik.188@gmail.com> (Karthik
	Nayak's message of "Thu, 8 Oct 2015 14:47:57 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 08 Oct 2015 20:51:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t98Ip6ss011723
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1444935067.57884@JT7d2pJ7dViu9ztxKycK4g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279259>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -309,11 +319,19 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
>  	if (if_then_else->then_atom)
>  		die(_("format: %%(then) atom used more than once"));
>  	if_then_else->then_atom = 1;
> +
>  	/*

Useless new blank line.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
