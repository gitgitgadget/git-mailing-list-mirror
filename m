From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] reset: allow "-" short hand for previous commit
Date: Tue, 03 Mar 2015 23:10:54 +0100
Message-ID: <vpq4mq13f69.fsf@anie.imag.fr>
References: <1425415911-496-1-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 23:11:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSv1p-00010C-T3
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 23:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbbCCWK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 17:10:58 -0500
Received: from mx2.imag.fr ([129.88.30.17]:54264 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932332AbbCCWK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 17:10:57 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t23MApvU019485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Mar 2015 23:10:51 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t23MAsGg024103;
	Tue, 3 Mar 2015 23:10:54 +0100
In-Reply-To: <1425415911-496-1-git-send-email-sudshekhar02@gmail.com>
	(Sudhanshu Shekhar's message of "Wed, 4 Mar 2015 02:21:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 03 Mar 2015 23:10:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t23MApvU019485
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1426025452.14149@zl8TdE4FzNU3SJBhQdmtMQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264698>

Sudhanshu Shekhar <sudshekhar02@gmail.com> writes:

> From: SudShekhar <sudshekhar02@gmail.com>

Please, set your configuration to have the same identity for commit and
send-email. It seems your commiter ID (user.name) does not contain your
last name.

> builtin/reset.c | 2 ++

Doesn't this deserve a test?

+		if(!strcmp(argv[0],"-"))
+			argv[0]="@{-1}";

Wrong spacing (around = and after ,).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
