From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] status: display "doing what" information in git status
Date: Fri, 06 May 2011 20:40:04 +0200
Message-ID: <vpqei4bwu4b.fsf@bauges.imag.fr>
References: <7vr58c4sip.fsf@alter.siamese.dyndns.org>
	<1304667535-4787-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri May 06 20:40:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIPww-0004yI-6p
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 20:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510Ab1EFSkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 14:40:21 -0400
Received: from mx2.imag.fr ([129.88.30.17]:37938 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932468Ab1EFSkU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 14:40:20 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p46Ie2RB021433
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 6 May 2011 20:40:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QIPwb-0004B8-2m; Fri, 06 May 2011 20:40:05 +0200
In-Reply-To: <1304667535-4787-1-git-send-email-madcoder@debian.org> (Pierre
	Habouzit's message of "Fri, 6 May 2011 09:38:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 06 May 2011 20:40:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p46Ie2RB021433
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1305312003.31704@qSQfCqkeNQxW37+Q2pqZAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172998>

Pierre Habouzit <madcoder@debian.org> writes:

> +	const char * const merge_advice =
> +		_("use \"git reset --hard\" to abort, or resolve conflicts and commit");

I think that should be "git reset --merge" (which preserves files not
touched by the merge, and makes sure "git merge; git reset" doesn't
permanently loose data).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
