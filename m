From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Port to 12 other Platforms.
Date: Sun, 08 Jun 2008 18:21:06 +0200
Message-ID: <vpqve0j3nkd.fsf@bauges.imag.fr>
References: <Pine.LNX.4.64.0806080926240.18454@xenau.zenez.com>
	<m3prqsvsiq.fsf@localhost.localdomain>
	<Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 18:22:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Nex-0000Hs-Ah
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 18:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755475AbYFHQVV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 12:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755467AbYFHQVV
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 12:21:21 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:64166 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755380AbYFHQVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 12:21:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m58GL6h3028968;
	Sun, 8 Jun 2008 18:21:06 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1K5Ndi-0003WT-7j; Sun, 08 Jun 2008 18:21:06 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1K5Ndi-0001wx-5U; Sun, 08 Jun 2008 18:21:06 +0200
In-Reply-To: <Pine.LNX.4.64.0806080959390.18454@xenau.zenez.com> (Boyd Lynn Gerber's message of "Sun\, 8 Jun 2008 10\:04\:21 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Sun, 08 Jun 2008 18:21:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84290>

Boyd Lynn Gerber <gerberb@zenez.com> writes:

> This was from my own copy of the master archive.  It is my proposal. =
 I=20
> thought you had to get an OK from this list before you do a push to t=
he=20
> main archive.

You won't do a push, the maintainer will apply the patch if it seems
OK.

> What am I missing?

The format used to send patches. git format-patch and git send-email
would do that for you, but in particular : what comes after =AB=A0---=A0=
=BB
and before the patch itself is ignored by the tools, just an
informative message for people reading your email. What comes before
this =AB=A0---=A0=BB is the commit message.

--=20
Matthieu
