From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git push race condition?
Date: Mon, 24 Mar 2014 20:44:21 +0100
Message-ID: <vpq61n3bcve.fsf@anie.imag.fr>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Scott Sandler <scott.m.sandler@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 20:45:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSAnq-0002Gb-Cm
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 20:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbaCXToy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 15:44:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48435 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196AbaCXTo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 15:44:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s2OJiI6P000543
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 24 Mar 2014 20:44:18 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s2OJiL9N016397;
	Mon, 24 Mar 2014 20:44:21 +0100
In-Reply-To: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
	(Scott Sandler's message of "Mon, 24 Mar 2014 15:18:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 24 Mar 2014 20:44:18 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s2OJiI6P000543
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1396295062.0869@VjBIOVkIO/68SOhG0sP8pA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244863>

Scott Sandler <scott.m.sandler@gmail.com> writes:

> Both pushes are
> determined to be fast-forwards and both succeed, but B' overwrites B
> and B is no longer on origin/master. The server does have B in its
> .git directory but the commit isn't on any branch.

Is the reflog enabled on the server? If so, does it say anything about B
and B'?

What filesystem do you use on the server? Is there any kind of NFS, and
if so are you sure that there's only one machine accessing the
filesystem at the same time?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
