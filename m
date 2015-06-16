From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 05/11] ref-filter: add parse_opt_merge_filter()
Date: Tue, 16 Jun 2015 18:18:49 +0200
Message-ID: <vpqmvzz7hjq.fsf@anie.imag.fr>
References: <CAOLa=ZQeZ=6mZcntR_BS_Wp0LXDzSUx9WTLXCTLxemb0e3SS0w@mail.gmail.com>
	<1434464457-10749-1-git-send-email-karthik.188@gmail.com>
	<1434464457-10749-5-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 18:19:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4tZj-0005lD-6J
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 18:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754071AbbFPQSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 12:18:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37791 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057AbbFPQSy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 12:18:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t5GGIlS5014684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 16 Jun 2015 18:18:47 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t5GGInXj017784;
	Tue, 16 Jun 2015 18:18:49 +0200
In-Reply-To: <1434464457-10749-5-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Tue, 16 Jun 2015 19:50:51 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 16 Jun 2015 18:18:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t5GGIlS5014684
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1435076328.57418@cvZq2I+3bxmc7q/qq7lcsQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271775>

Karthik Nayak <karthik.188@gmail.com> writes:

> This is copied from 'builtin/branch.c' which will eventually be removed
> when we port 'branch.c' to use ref-filter APIs.

Earlier in the series you took code from tag.c.

I think you should focus on either merge or tag, get a ref-filter-based
replacement that passes the tests for it, and then consider the other.
The fact that the test pass for a rewritten command is important to
check the correctness of the these patches.

I'm not asking you to remove commits from this series though. Just
impatient to see one command fully replaced (actually, I see that you
have more commits than you sent in your branch, so I guess it will come
soon on the list) :-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
