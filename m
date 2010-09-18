From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG, PATCH 0/3] Fix {blame,cat-file} --textconv for cases with symlinks
Date: Sat, 18 Sep 2010 20:08:59 +0200
Message-ID: <vpqhbhmx6tg.fsf@bauges.imag.fr>
References: <cover.1284830388.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Kirill Smelkov <kirr@landau.phys.spbu.ru>
X-From: git-owner@vger.kernel.org Sat Sep 18 20:10:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox1rY-0003d7-H8
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 20:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab0IRSKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 14:10:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46327 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887Ab0IRSKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 14:10:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8II4Xc3016591
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 18 Sep 2010 20:04:33 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Ox1qO-0007Za-8y; Sat, 18 Sep 2010 20:09:00 +0200
In-Reply-To: <cover.1284830388.git.kirr@landau.phys.spbu.ru> (Kirill Smelkov's message of "Sat\, 18 Sep 2010 21\:25\:03 +0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 18 Sep 2010 20:04:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8II4Xc3016591
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285437874.79682@eZwqP8RyFO/TFJD5O2TCqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156469>

Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:

> Recently I've spot a bug in git blame --textconv, which was wrongly
> calling pdftotext (my *.pdf conversion program) on a symlink.pdf,

No time for a detailed review now, but textconv is also called by diff
(that's the original implementation). Does "git diff" work properly on
symlinks in the same case?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
