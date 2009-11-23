From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] user-manual: Document that "git merge" doesn't like uncommited changes.
Date: Mon, 23 Nov 2009 08:51:07 +0100
Message-ID: <vpqd439he6s.fsf@bauges.imag.fr>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
	<1258732767-12741-3-git-send-email-Matthieu.Moy@imag.fr>
	<7vk4xlvtib.fsf@alter.siamese.dyndns.org>
	<vpqljhyi4oi.fsf@bauges.imag.fr>
	<7vy6lyaz9b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 08:55:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCTly-0000SX-0r
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 08:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbZKWHze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 02:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbZKWHze
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 02:55:34 -0500
Received: from imag.imag.fr ([129.88.30.1]:46512 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbZKWHze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 02:55:34 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAN7p8mB000255
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 23 Nov 2009 08:51:08 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NCThU-000800-01; Mon, 23 Nov 2009 08:51:08 +0100
In-Reply-To: <7vy6lyaz9b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 22 Nov 2009 15\:57\:52 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 23 Nov 2009 08:51:08 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133488>

Junio C Hamano <gitster@pobox.com> writes:

> 	The work tree is overwritten by the result of the
>         merge when this combining is done cleanly, and the result is
>         committed. Otherwise it is
> 	overwritten by a half-merged results when this combining results

I thought of something like this, but this is slightly incorrect in
case of fast-forward (Git doesn't "commit", but "reuses" a commit), so
I prefered making a separate paragraph.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
