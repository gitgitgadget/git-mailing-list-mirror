From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH] add: warn when -u or -A is used without filepattern
Date: Mon, 21 Jan 2013 21:10:51 +0100
Message-ID: <vpqzk02nvp0.fsf@grenoble-inp.fr>
References: <7v1udfn0tm.fsf@alter.siamese.dyndns.org>
	<1358769611-3625-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vwqv6fiz7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:11:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxNiJ-0007E3-RZ
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 21:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753259Ab3AUULF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 15:11:05 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49503 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699Ab3AUULE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 15:11:04 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0LKAnia019010
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2013 21:10:49 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TxNhj-00058w-Hd; Mon, 21 Jan 2013 21:10:51 +0100
In-Reply-To: <7vwqv6fiz7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 21 Jan 2013 11:12:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Jan 2013 21:10:49 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0LKAnia019010
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359403851.4643@AwLJILkRwIpJrSMHNWUHcw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214161>

Junio C Hamano <gitster@pobox.com> writes:

> Wouldn't we achieve the same consistency across modes of
> "add" if we made them relative to the current directory?

As other people already said, it would be nice to have consistency
accross most if not all commands. AFAICT, the only exceptions to
"tree-wide by default, say '.' to restrict to subdirectory" are git add
-u|-A, git grep and git clean.

Arguably, the "subtree by default" is a safety feature of "git clean",
and should be kept.

I don't care too deepely about "git grep". From previous discussions,
IIRC, other people didn't care either.

On the other hand, I can think of at least "git log", "git diff", "git
status" and to some extend "git commit" as tree-wide by default with
optional path restriction. I'd like "git add" to be on the same side.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
