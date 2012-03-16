From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Fri, 16 Mar 2012 10:43:56 +0100
Message-ID: <vpq1uosswwz.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120316085152.GA22273@ecki>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Mar 16 10:44:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Thp-0003hu-6t
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 10:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761121Ab2CPJoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 05:44:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50462 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761061Ab2CPJoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 05:44:04 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q2G9djPj011056
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 16 Mar 2012 10:39:45 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S8ThU-00089I-TO; Fri, 16 Mar 2012 10:43:57 +0100
In-Reply-To: <20120316085152.GA22273@ecki> (Clemens Buchacher's message of
	"Fri, 16 Mar 2012 09:51:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 16 Mar 2012 10:39:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2G9djPj011056
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332495587.7806@5YXNw9Jt8H6lIXBN0BUF/g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193248>

Clemens Buchacher <drizzd@aon.at> writes:

> If "current" and "upstream" disagree, git push errors out and asks the
> user to use an explicit refspec or change push.default according to
> their preferred workflow.

I actually like this idea. Or at least, much more than "current, but
only if the remote already exists". In most simple case, it will just
work, and it will error out with an explicit message in every case which
could have confused the user.

I'd count "upstream is not set" as "current and upstream agree on
'current'". IOW, use "current", but error out if there's a configured
upstream that is different.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
