From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] log: add log.follow config option
Date: Wed, 08 Jul 2015 09:40:41 +0200
Message-ID: <vpq7fqbjdvq.fsf@anie.imag.fr>
References: <1436307137-18647-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 09:42:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCjzl-0001RO-9b
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 09:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932957AbbGHHmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 03:42:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42442 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934256AbbGHHkq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 03:40:46 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t687efZm008223
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 8 Jul 2015 09:40:41 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t687efOJ019090;
	Wed, 8 Jul 2015 09:40:41 +0200
In-Reply-To: <1436307137-18647-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 7 Jul 2015 18:12:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 08 Jul 2015 09:40:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t687efZm008223
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1436946043.02265@t2PFngrOCCoBuORm57gWCw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273647>

[ Note: as much as possible, Cc the reviewers of the previous rounds
  when you send a new version ]

David Turner <dturner@twopensource.com> writes:

> +test_expect_success  'git config log.follow is overridden by --no-follow' '

nitpick: two spaces after test_expect_success.

With or without the whitespace fix, the patch looks good to me. I'm not
sure it fully addresses Junio's concern about v2 though.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
