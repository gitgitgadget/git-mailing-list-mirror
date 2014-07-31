From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 6/7] config: add `git_die_config()` to the config-set API
Date: Thu, 31 Jul 2014 13:30:18 +0200
Message-ID: <vpq8un9epf9.fsf@anie.imag.fr>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
	<1406799857-28048-7-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:30:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCoZ4-0002jV-UV
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 13:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbaGaLa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 07:30:27 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50853 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbaGaLa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 07:30:26 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBUHQK003798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 13:30:17 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBUIqh024873;
	Thu, 31 Jul 2014 13:30:18 +0200
In-Reply-To: <1406799857-28048-7-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 31 Jul 2014 02:44:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 Jul 2014 13:30:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VBUHQK003798
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407411021.14463@/uhC5LU+ctJe+5YmekjFkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254553>

Tanay Abhra <tanayabh@gmail.com> writes:

> +	if (!kv_info->linenr)
> +		die("unable to parse '%s' from command-line config", key);
> +	else
> +		die("bad config variable '%s' at file line %d in %s",

And two more missing _(...).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
