From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 3/8] git-remote-mediawiki: make mediafiles export optional
Date: Mon, 16 Jul 2012 21:40:35 +0200
Message-ID: <vpqbojfv6j0.fsf@bauges.imag.fr>
References: <1342440053-3058-1-git-send-email-Matthieu.Moy@imag.fr>
	<1342440053-3058-4-git-send-email-Matthieu.Moy@imag.fr>
	<7v7gu3373x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Asheesh Laroia <asheesh@asheesh.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 21:42:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqrBO-0003ZV-2k
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jul 2012 21:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752660Ab2GPTmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 15:42:08 -0400
Received: from mx2.imag.fr ([129.88.30.17]:55473 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752293Ab2GPTmH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 15:42:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q6GJclrW014225
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 16 Jul 2012 21:38:47 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Sqr9o-0001Ns-Mb; Mon, 16 Jul 2012 21:40:36 +0200
In-Reply-To: <7v7gu3373x.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 16 Jul 2012 11:15:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 16 Jul 2012 21:38:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6GJclrW014225
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1343072328.79281@LnfCqu3HKhYOJgsOfrF2Cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201554>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> It would have been nicer to hint why people may want to omit
> mediafiles from their export under what condition somewhere in the
> documentation or at least in the proposed commit log message.

The real use-case for which I implemented is a bit particular (described
below), but I'll resend with a more general explanation.

For the curious: I have a wiki with ~2Gb of mediafiles, and I want to
secure it without particular access to the server. I import the wiki on
a desktop machine with a large disk, and re-export it to another
webserver with a small disk quota. Importing mediafiles is good because
it gives me a backup, but exporting them is not an option as my quota on
the webserver is too small.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
