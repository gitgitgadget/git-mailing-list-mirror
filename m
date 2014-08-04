From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 07/11] builtin/gc.c: replace `git_config()` with `git_config_get_*()` family
Date: Mon, 04 Aug 2014 22:41:37 +0200
Message-ID: <vpq61i89eda.fsf@anie.imag.fr>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
	<1407177229-30081-8-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 22:41:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEP4j-0003Al-AY
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbaHDUll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:41:41 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53165 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232AbaHDUll (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:41:41 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s74KfZmM018253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 22:41:35 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74Kfbvr006222;
	Mon, 4 Aug 2014 22:41:37 +0200
In-Reply-To: <1407177229-30081-8-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Mon, 4 Aug 2014 11:33:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Aug 2014 22:41:35 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74KfZmM018253
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407789696.60645@FH6OcPceef5rEex5FkG7Ag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254779>

Tanay Abhra <tanayabh@gmail.com> writes:

> +			if (approxidate(prune_expire) >= now) {
> +				error(_("Invalid %s: '%s'"), "gc.pruneexpire", prune_expire);
> +				git_die_config("gc.pruneexpire");
> +			}

That is a case where the API looks suboptimal, see Junio's remark in the
other thread.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
