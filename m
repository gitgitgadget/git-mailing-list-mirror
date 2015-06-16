From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 04/11] for-each-ref: add '--points-at' option
Date: Tue, 16 Jun 2015 18:00:09 +0200
Message-ID: <vpqeglb8wza.fsf@anie.imag.fr>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
	<1434464457-10749-1-git-send-email-karthik.188@gmail.com>
	<1434464457-10749-4-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 18:00:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4tHl-0006OK-RR
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 18:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863AbbFPQAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 12:00:20 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58423 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752973AbbFPQAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 12:00:18 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t5GG07SG031252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Jun 2015 18:00:07 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5GG09Gp017268;
	Tue, 16 Jun 2015 18:00:09 +0200
In-Reply-To: <1434464457-10749-4-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 16 Jun 2015 19:50:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 16 Jun 2015 18:00:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5GG07SG031252
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435075209.32703@fFTZGNdgcGxW2Kvaojro7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271772>

Karthik Nayak <karthik.188@gmail.com> writes:

> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -62,6 +63,8 @@ OPTIONS
>  	the specified host language.  This is meant to produce
>  	a scriptlet that can directly be `eval`ed.
>  
> +--points-at <object>::
> +	Only list refs of the given object.

I would find "Only list refs pointing to the given object" clearer.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
