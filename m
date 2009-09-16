From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Behavior of 'git add \*.txt': bug or feature?
Date: Wed, 16 Sep 2009 23:26:12 +0200
Message-ID: <vpqr5u637kb.fsf@bauges.imag.fr>
References: <vpqljke7jv8.fsf@bauges.imag.fr>
	<7vbplazl7s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 23:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo21W-0005Zy-1F
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 23:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759989AbZIPV0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 17:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757543AbZIPV0h
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 17:26:37 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48732 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753737AbZIPV0g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 17:26:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8GLNNLR001274
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Sep 2009 23:23:23 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mo20y-0006Rp-B4; Wed, 16 Sep 2009 23:26:12 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mo20y-0001G7-9c; Wed, 16 Sep 2009 23:26:12 +0200
In-Reply-To: <7vbplazl7s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Wed\, 16 Sep 2009 13\:30\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 16 Sep 2009 23:23:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8GLNNLR001274
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253741004.56731@fGLltR5337QmfH6JG3mceA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128678>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> It this the intended behavior? If so, what's the rationale for this?
>
> I strongly suspect that it comes from the fact that we have two
> definitions and three implementations of pathspec-aware tree traversal.
> One family is unaware of shell-glob wildcards (they only do leading
> directory path match) while the other know both leading directory path and
> shell-glob.
>
> It is on the list of long-term items to fix, as the change required is
> quite involved.

OK, that answers my question.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
