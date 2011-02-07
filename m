From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 07 Feb 2011 21:57:43 +0100
Message-ID: <vpqtygfa7g8.fsf@bauges.imag.fr>
References: <4D4DEDC4.4080708@hartwork.org>
	<20110206051333.GA3458@sigill.intra.peff.net>
	<4D4EF7E4.7050303@hartwork.org> <vpq1v3kopn3.fsf@bauges.imag.fr>
	<7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
	<20110207055314.GA5511@sigill.intra.peff.net>
	<7vhbcguytf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:58:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmY9s-0006yl-3a
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:58:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab1BGU56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:57:58 -0500
Received: from mx1.imag.fr ([129.88.30.5]:35726 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754036Ab1BGU56 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:57:58 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p17KvfP4031833
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Feb 2011 21:57:41 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PmY9X-0007Nm-Ie; Mon, 07 Feb 2011 21:57:43 +0100
In-Reply-To: <7vhbcguytf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 06 Feb 2011 22\:46\:20 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 07 Feb 2011 21:57:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p17KvfP4031833
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297717063.60627@tdpL+145e/9SjMUMYdFYWA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166291>

Junio C Hamano <gitster@pobox.com> writes:

> I would say so; "add -p" was an ill-executed afterthought.  The codepath
> was originally meant to be used from "-i" as the top-level interface that
> was a fully interactive way to prepare for the next commit, which is an
> operation that is inherently full-tree.

I agree that "git add -i" is a way to prepare the next commit, but you
seem to imply that "git add -u" is not and then I have to disagree.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
