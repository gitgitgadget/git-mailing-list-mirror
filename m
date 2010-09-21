From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2 2/3] blame,cat-file: Demonstrate --textconv is wrongly running converter on symlinks
Date: Tue, 21 Sep 2010 22:18:11 +0200
Message-ID: <vpqzkvaetq4.fsf@bauges.imag.fr>
References: <cover.1285013802.git.kirr@landau.phys.spbu.ru>
	<cover.1285013802.git.kirr@landau.phys.spbu.ru>
	<3c344d9b8f014ccb96dc37dc42668426fb5a3c30.1285013802.git.kirr@landau.phys.spbu.ru>
	<vpqvd6086fq.fsf@bauges.imag.fr>
	<20100921183959.GB4390@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Jeff King <peff@peff.net>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Tue Sep 21 22:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy9N7-0001LI-5p
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 22:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647Ab0IUUXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 16:23:19 -0400
Received: from imag.imag.fr ([129.88.30.1]:38552 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565Ab0IUUXS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 16:23:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o8LKIBJm020290
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 21 Sep 2010 22:18:11 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oy9I3-0003Lv-Jw; Tue, 21 Sep 2010 22:18:11 +0200
In-Reply-To: <20100921183959.GB4390@landau.phys.spbu.ru> (Kirill Smelkov's message of "Tue\, 21 Sep 2010 22\:39\:59 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 21 Sep 2010 22:18:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156749>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> I know about --- and that content after it and up to patch itself goes
> to /dev/null. The text here was intended to stay in the commit message,
> and ~~~~ served as a separator in that message (git commit hook merges
> several blank lines into one, so one can't separate text parts with
> several empty lines, that's why I used this separator).
>
> If it's ugly, let's omit it - I don't insist, but i don't understand why
> 'NOTE:' looks odd?

That was especially about the combination of both, but I don't really
care. Consider my remarks as food for thoughts, not real objections.

> This note clearly says "git diff is not affected, that's why we don't
> write new tests for it".

I disagree with the implication. Git diff is not affected because it
was done right, but behaving correctly doesn't mean you don't need
tests. Checking the behavior of diff with tests wouldn't harm (but
that's not serious not to do it).

>> Reviewed-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>
> Thanks :)
>
> Is it for this one patch, or does it apply to the whole series?

To the serie, yes.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
