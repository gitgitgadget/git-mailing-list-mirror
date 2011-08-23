From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Mark http-fetch without -a as deprecated
Date: Tue, 23 Aug 2011 09:02:02 +0200
Message-ID: <vpqvcto391x.fsf@bauges.imag.fr>
References: <1314060703-24265-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Aug 23 09:03:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvl0m-0001jF-VW
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 09:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589Ab1HWHC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 03:02:56 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48225 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725Ab1HWHCz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 03:02:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p7N71mi7024842
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 23 Aug 2011 09:01:48 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Qvkzq-0007TA-9p; Tue, 23 Aug 2011 09:02:02 +0200
In-Reply-To: <1314060703-24265-1-git-send-email-bwalton@artsci.utoronto.ca>
	(Ben Walton's message of "Mon, 22 Aug 2011 20:51:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 23 Aug 2011 09:01:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7N71mi7024842
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1314687715.69982@7MqIC/Mn74M5LPwu8Iu6FA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179924>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> +	if (get_all == 0)
> +	  warning("http-fetch: use without -a is deprecated; -a will become the default in a future release");

Bad indentation. Git indents with tabs, not spaces. Also, you can break
the line to make both the error message and the source code fit on 80
characters.

No opinion on whether the deprecation is sensible, though. If it is, add
something in the documentation, not just in the code.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
