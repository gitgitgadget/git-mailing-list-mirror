From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] git-ls-files.txt: clarify what "other files" mean for --other
Date: Fri, 07 Aug 2009 10:15:01 +0200
Message-ID: <vpqprb8xcoq.fsf@bauges.imag.fr>
References: <1249571508-21897-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vmy6cfz9j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 10:15:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZKbp-0004hz-9E
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 10:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757230AbZHGIPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 04:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757200AbZHGIPP
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 04:15:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56859 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757212AbZHGIPL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 04:15:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n778E9m5021227
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Aug 2009 10:14:09 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZKbN-0000hK-6h; Fri, 07 Aug 2009 10:15:01 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZKbN-0006Wq-3g; Fri, 07 Aug 2009 10:15:01 +0200
In-Reply-To: <7vmy6cfz9j.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Thu\, 06 Aug 2009 13\:44\:40 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 07 Aug 2009 10:14:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n778E9m5021227
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1250237651.19214@2u2kXnnc6pTEZo+UycvBzQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125188>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>> Actually, if it was not about backward compatibility, I'd just replace
>> -o, --other with -u, --untracked and talk about "untracked" everywhere,
>> but compatibility matters more than consistancy for plumbing.
>
> "ls-files -u" talks about (u)nmerged files.

(forgot this, so -u is even less an option)

> What consistency did you have in mind?

I found no place outside git ls-files where Git talks about "other"
files. Everywhere else, it talks about Untracked files.

As for the -u option, git status/commit -u[mode] is for Untracked
files, not unmerged ones.

--
Matthieu
