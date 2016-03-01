From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] builtin/receive-pack.c: use parse_options API
Date: Tue, 01 Mar 2016 21:39:43 +0100
Message-ID: <vpqvb56yltc.fsf@anie.imag.fr>
References: <1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
	<1456846560-9223-1-git-send-email-tigerkid001@gmail.com>
	<1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: "Sidhant Sharma \[\:tk\]" <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:39:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aar5I-0006Ip-Bt
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 21:39:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423AbcCAUjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 15:39:52 -0500
Received: from mx2.imag.fr ([129.88.30.17]:38376 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119AbcCAUjv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 15:39:51 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u21KdfFS010188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 1 Mar 2016 21:39:41 +0100
Received: from anie (ensi-vpn-229.imag.fr [129.88.57.229])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u21KdhHW020721;
	Tue, 1 Mar 2016 21:39:44 +0100
In-Reply-To: <1456863661-22783-1-git-send-email-tigerkid001@gmail.com>
	(Sidhant Sharma's message of "Wed, 2 Mar 2016 01:51:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Mar 2016 21:39:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u21KdfFS010188
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457469584.54789@DY6EJzXRk68MNW/3bP+aVQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288062>

"Sidhant Sharma [:tk]" <tigerkid001@gmail.com> writes:

> Make receive-pack use the parse_options API,
> bringing it more in line with send-pack and push.

Thanks. This version looks good to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
