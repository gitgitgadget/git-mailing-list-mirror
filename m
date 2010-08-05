From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] Document -B<n>[/<m>], -M<n> and -C<n> variants of -B, -M and -C
Date: Thu, 05 Aug 2010 18:09:58 +0200
Message-ID: <vpqbp9hoxbd.fsf@bauges.imag.fr>
References: <7vk4ocrkfa.fsf@alter.siamese.dyndns.org>
	<1280747527-30444-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vsk2wlvxv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 18:11:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh32X-0008Ph-Od
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758881Ab0HEQLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:11:24 -0400
Received: from mx1.imag.fr ([129.88.30.5]:47953 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758863Ab0HEQLX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:11:23 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o75FxOTM011360
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 5 Aug 2010 17:59:24 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oh314-0004X3-Hc; Thu, 05 Aug 2010 18:09:58 +0200
In-Reply-To: <7vsk2wlvxv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 02 Aug 2010 11\:18\:52 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 05 Aug 2010 17:59:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o75FxOTM011360
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281628769.17917@f/yKBaCGn5QFYIXabz0MJw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152663>

Junio C Hamano <gitster@pobox.com> writes:

> After reading this, we know that with magic numbers given to -B, we can
> "break" changes into "pairs of delete and create".  What does it mean in
> the practical terms?  That is a lot more essential information than how
> the magic numbers affect the decision to break or not break.  The user
> does not get a motivation to help git "break" a pair from the above.
>
>     The -B option serves two purposes.
>     [...]

I like your version much more than mine. I took it with a bit of
asciidoc reformatting.

I detailed a bit more the -M<n> case, so that users do not have to
read the whole -B thing to understand -M<n>. I'm citing the expression
"similarity index" since it sometimes appears in the output of diff,
hence, can help the user to match what's happening and the doc.

New version follows.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
