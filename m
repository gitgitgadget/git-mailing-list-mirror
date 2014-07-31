From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 4/7] rewrite git_config() to use the config-set API
Date: Thu, 31 Jul 2014 13:28:55 +0200
Message-ID: <vpqegx1ephk.fsf@anie.imag.fr>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>
	<1406799857-28048-5-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:29:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCoXg-0001IF-Qq
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 13:29:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382AbaGaL3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 07:29:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50822 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151AbaGaL27 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 07:28:59 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBSseQ003497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 31 Jul 2014 13:28:54 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6VBStWF024864;
	Thu, 31 Jul 2014 13:28:55 +0200
In-Reply-To: <1406799857-28048-5-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 31 Jul 2014 02:44:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 31 Jul 2014 13:28:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6VBSseQ003497
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407410935.79176@JF4SOwQl2575TxC1YyYTrQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254552>

Tanay Abhra <tanayabh@gmail.com> writes:

> +			if (!kv_info->linenr)
> +				die("unable to parse '%s' from command-line config", entry->key);
> +			else
> +				die("bad config variable '%s' at file line %d in %s",

Also two missing _("...") here.

Note that there are missing _("...") in config.c before your patch too.
I'll send a patch to fix this regardless of your series.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
