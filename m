From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [ANNOUNCE] Git v1.8.2-rc3
Date: Fri, 08 Mar 2013 11:18:59 +0100
Message-ID: <vpqtxommbxo.fsf@grenoble-inp.fr>
References: <7v7glils5k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 11:19:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDuOl-0005Rn-91
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 11:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab3CHKTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 05:19:09 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37216 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab3CHKTH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 05:19:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r28AIxjJ025844
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Mar 2013 11:18:59 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UDuOC-0007Fn-8l; Fri, 08 Mar 2013 11:19:00 +0100
In-Reply-To: <7v7glils5k.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 07 Mar 2013 15:13:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 08 Mar 2013 11:18:59 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r28AIxjJ025844
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1363342741.02346@xsLpTM59UjkkFffmjM+zoA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217656>

A few suggestions on the release notes (you may safely ignore)

Junio C Hamano <gitster@pobox.com> writes:

> In the next major release Git 2.0 (not *this* one), we will change the
> behavior of the "git push" command.

It's not entirely clear from the formatting whether this sentenece
introduces the whole "Backward compatibility notes" section or just the
paragraph above. I'd merge this paragraph with the one below
(push.default).

It may make sense to split "Backward compatibility notes" in two
sections "Backward compatibility notes (this release)" and "Backward
compatibility notes (future Git 2.0 release)".

> At Git 2.0 (not *this* one), we plan to change these commands without
> pathspec to operate on the entire tree.  Forming a habit to type "."
> when you mean to limit the command to the current working directory
> will protect you against the planned future change, and that is the
> whole point of the new message (there will be no configuration
> variable to squelch this warning---it goes against the "habit forming"
> objective).

I think it will make sense to have a way to shut down the warning
starting from Git 2.0 (people who upgrade and don't look back aren't
interested in warnings about compatibility with previous versions).

So I'd say just "there is no configuration" instead of "there will be no
configuration".

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
