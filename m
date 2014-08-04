From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 01/11] daemon.c: replace `git_config()` with `git_config_get_bool()` family
Date: Mon, 04 Aug 2014 22:23:37 +0200
Message-ID: <vpq38dcatrq.fsf@anie.imag.fr>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
	<1407177229-30081-2-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:23:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEOnM-0003cv-Pa
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551AbaHDUXp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:23:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52833 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417AbaHDUXo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:23:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s74KNZ2n015923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 22:23:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74KNbkD005301;
	Mon, 4 Aug 2014 22:23:37 +0200
In-Reply-To: <1407177229-30081-2-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 4 Aug 2014 11:33:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Aug 2014 22:23:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74KNZ2n015923
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407788619.54614@yLhC2B9i5IhG6fU+FSb28Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254775>

Tanay Abhra <tanayabh@gmail.com> writes:

> @@ -354,12 +338,11 @@ static int run_service(const char *dir, struct daemon_service *service)
[...]
>  	}
> +
>  	if (!enabled) {
>  		logerror("'%s': service not enabled for '%s'",
>  			 service->name, path);

Avoid whitespace-only change like this one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
