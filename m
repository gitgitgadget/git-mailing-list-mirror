From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-gui: use textconv filter for diff and blame
Date: Fri, 30 Jul 2010 12:40:50 +0200
Message-ID: <vpqocdpdzgt.fsf@bauges.imag.fr>
References: <1280319830-20483-1-git-send-email-Matthieu.Moy@imag.fr>
	<871valstsi.fsf@fox.patthoyts.tk> <vpq8w4tpie2.fsf@bauges.imag.fr>
	<878w4tz2hi.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C. Hamano" <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Jul 30 12:45:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oen5H-0000sQ-Fq
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 12:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758227Ab0G3Kou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 06:44:50 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46532 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756287Ab0G3Kot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 06:44:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6UAcxxu003997
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Jul 2010 12:38:59 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Oen1G-00032k-LM; Fri, 30 Jul 2010 12:40:50 +0200
In-Reply-To: <878w4tz2hi.fsf@fox.patthoyts.tk> (Pat Thoyts's message of "Fri\, 30 Jul 2010 11\:30\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 30 Jul 2010 12:39:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6UAcxxu003997
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281091141.58646@EDZ7NXQFRG3dxYrGpwxJyg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152239>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> OK thanks. This works very nicely once configured. I've applied it and
> pushed this plus some outstanding git-gui patches from msysgit to the
> git-gui repository at git://repo.or.cz/git-gui.git

This is great: it also fixes the very long standing bug of "git gui
blame: Show History Context"
(http://mid.gmane.org/vpqzkxkorzr.fsf@bauges.imag.fr).

Junio: Can we get this merged into git.git?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
