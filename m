From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 2/2] builtin-merge: show user-friendly error messages for fast-forward too.
Date: Mon, 30 Nov 2009 09:42:49 +0100
Message-ID: <vpq3a3wtncm.fsf@bauges.imag.fr>
References: <1259497113-1393-1-git-send-email-Matthieu.Moy@imag.fr>
	<1259497113-1393-3-git-send-email-Matthieu.Moy@imag.fr>
	<7vy6lo7nu8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 09:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF1qa-0008Do-E3
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 09:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbZK3Imx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 03:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbZK3Imx
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 03:42:53 -0500
Received: from mx2.imag.fr ([129.88.30.17]:36730 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbZK3Imw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 03:42:52 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nAU8fNfS021585
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Nov 2009 09:41:23 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NF1qM-0008Cj-0f; Mon, 30 Nov 2009 09:42:50 +0100
In-Reply-To: <7vy6lo7nu8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun\, 29 Nov 2009 18\:23\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 30 Nov 2009 09:41:23 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nAU8fNfS021585
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1260175285.40694@Md2Ir2emKMcngT7HGIXLkA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134084>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> This is where I'm not 100% sure I'm not breaking some plumbing.
>
> I think this change is safe [...]
>
> Or did you have something a lot more subtle in mind?

Not at all. But since I found the place to add my code more or less
randomly with gdb, I feel safer with your comment ;-).

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
