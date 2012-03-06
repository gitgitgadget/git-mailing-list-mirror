From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] config: Introduce --patience config variable
Date: Tue, 06 Mar 2012 14:38:16 +0100
Message-ID: <vpqr4x5hmt3.fsf@bauges.imag.fr>
References: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com>
	<20120306114914.GB6733@sigill.intra.peff.net>
	<87pqcp6fyh.fsf@thomas.inf.ethz.ch> <4F5611F1.4020309@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@inf.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, gitster@pobox.com
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 14:39:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4ubk-0004H6-O3
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 14:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758258Ab2CFNjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 08:39:11 -0500
Received: from mx2.imag.fr ([129.88.30.17]:35293 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030406Ab2CFNjK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 08:39:10 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q26DYcC2023041
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 6 Mar 2012 14:34:38 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S4uan-00085J-0T; Tue, 06 Mar 2012 14:38:17 +0100
In-Reply-To: <4F5611F1.4020309@redhat.com> (Michal Privoznik's message of
	"Tue, 06 Mar 2012 14:32:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 06 Mar 2012 14:34:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q26DYcC2023041
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1331645681.39458@xzvxrKWWMAwrmh6SYwa36A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192348>

Michal Privoznik <mprivozn@redhat.com> writes:

> Okay guys. I'll got with diff.algorithm = [patience | minimal |
> histogram | myers] then. What I am not sure about is how to threat case
> when user have say algorithm = patience set in config but want to use
> myers. I guess we need --myers option then, don't we?

At this point, maybe it's time to have
--diff-algorithm=[patience|minimal|histogram|myers], and keep
--patience, --minimal and --histogram just as compatibility aliases.

Having one option per algorithm feels wrong ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
