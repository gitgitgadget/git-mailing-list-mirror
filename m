From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] push: point to 'git pull' and 'git push --force' in case of non-fast forward
Date: Fri, 07 Aug 2009 22:22:28 +0200
Message-ID: <vpqeirnv0fv.fsf@bauges.imag.fr>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v7hxgk8c9.fsf@alter.siamese.dyndns.org>
	<vpqvdkzwh3j.fsf@bauges.imag.fr>
	<7vd477v17r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 22:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZW2h-0006Vg-BD
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 22:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933770AbZHGU0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 16:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933768AbZHGU0o
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 16:26:44 -0400
Received: from imag.imag.fr ([129.88.30.1]:33050 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933750AbZHGU0n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 16:26:43 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n77KMSed021368
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Aug 2009 22:22:29 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZVxM-0007Nx-Nh; Fri, 07 Aug 2009 22:22:28 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZVxM-0003tF-MQ; Fri, 07 Aug 2009 22:22:28 +0200
In-Reply-To: <7vd477v17r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 07 Aug 2009 13\:05\:44 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 07 Aug 2009 22:22:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125219>

Junio C Hamano <gitster@pobox.com> writes:

> I actually do not think it is appropriate to teach --force in an example
> that involves more than one person (iow, in the context of the example in
> my patch).

Right, that is the point. A more accurate example would be "oops, I
rewrote history after a push, shall I still push it?". But your
proposal is already long, let's not over-document it.

-- 
Matthieu
