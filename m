From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 19:34:45 +0200
Message-ID: <vpqej8pnaru.fsf@bauges.imag.fr>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
	<20080427064250.GA5455@sigill.intra.peff.net>
	<739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>
	<slrng1be8l.25r.joerg@alea.gnuu.de>
	<86k5iib0g9.fsf@blue.stonehenge.com>
	<slrng1bqhb.25r.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 19:40:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqXKZ-0003al-SI
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 19:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934662AbYD1Ri7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 13:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934621AbYD1Ri7
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 13:38:59 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:60506 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933699AbYD1Ri6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 13:38:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m3SHbsbS026536;
	Mon, 28 Apr 2008 19:37:55 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JqXFV-0006IC-Sg; Mon, 28 Apr 2008 19:34:45 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JqXFV-0001aI-QU; Mon, 28 Apr 2008 19:34:45 +0200
In-Reply-To: <slrng1bqhb.25r.joerg@alea.gnuu.de> (=?iso-8859-1?Q?=22J=F6rg?=
 Sommer"'s message of "Mon\, 28 Apr 2008 15\:15\:55 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 28 Apr 2008 19:37:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80568>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

> And what about something like this: 'tac || rev || perl =E2=80=A6'

Be careful: rev and tac are different. tac reverses lines, while rev
reverses chars inside lines.

My 2 cents,

--=20
Matthieu
