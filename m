From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Deciding between Git/Mercurial
Date: Mon, 28 Sep 2009 10:42:48 +0200
Message-ID: <vpq7hvjfojb.fsf@bauges.imag.fr>
References: <h9nlhj$heq$1@ger.gmane.org>
	<94a0d4530909280136s1ff65004q1733bd4ef78bdc07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: newsgroups@catchall.shelter13.net, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 10:43:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsBp0-0005Ha-FC
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 10:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbZI1Imx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 04:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbZI1Imw
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 04:42:52 -0400
Received: from mx1.imag.fr ([129.88.30.5]:53870 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096AbZI1Imw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 04:42:52 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id n8S8c4wY020582
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Sep 2009 10:38:04 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MsBom-0002cf-6E; Mon, 28 Sep 2009 10:42:48 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1MsBom-00089a-4n; Mon, 28 Sep 2009 10:42:48 +0200
In-Reply-To: <94a0d4530909280136s1ff65004q1733bd4ef78bdc07@mail.gmail.com> (Felipe Contreras's message of "Mon\, 28 Sep 2009 11\:36\:49 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Sep 2009 10:38:04 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8S8c4wY020582
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254731885.66931@Zos0QVr6Bg+zUEM7TyJwZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129238>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> IMO the key difference between hg and git is the storage model: hg
> stores deltas, while git stores snapshots.

Mercurial stores regular snapshots, to make sure you never have to
apply too many deltas to get a snapshot. That's not so different from
what Git does with its packed format (the difference is that Git's
delta are not necessarily against the direct ancestor of the file).

AFAICT, both are snapshot-oriented, but both use a compression
algorithm based on delta.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
