From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/2] merge-recursive: point the user to commit when file would be overwritten.
Date: Sun, 22 Nov 2009 23:09:45 +0100
Message-ID: <vpqr5rqi53q.fsf@bauges.imag.fr>
References: <1258732767-12741-1-git-send-email-Matthieu.Moy@imag.fr>
	<1258732767-12741-2-git-send-email-Matthieu.Moy@imag.fr>
	<7vskc9vzqg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 22 23:12:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCKfU-0006hT-3W
	for gcvg-git-2@lo.gmane.org; Sun, 22 Nov 2009 23:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390AbZKVWMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Nov 2009 17:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752748AbZKVWMQ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Nov 2009 17:12:16 -0500
Received: from imag.imag.fr ([129.88.30.1]:48750 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbZKVWMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Nov 2009 17:12:16 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nAMM9kS9021074
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 22 Nov 2009 23:09:46 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NCKcr-0004FU-V7; Sun, 22 Nov 2009 23:09:46 +0100
In-Reply-To: <7vskc9vzqg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 20 Nov 2009 10\:05\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 22 Nov 2009 23:09:46 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133458>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> The commit-before-pull is well accepted in the DVCS community, but is
>> confusing some new users. This should get them back in the right way when
>> the problem occurs.
>>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> Don't these extra lines warrant "advice.*" option?

I was thinking this would be overkill for a one-line advice, but it
doesn't harm to provide the option. I'll resend the patch with it
(it's not _as_ straightforward as it seems to be since the initial
structure is static in the function, but still reasonable).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
