From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH 1/3] git-help: add -i|--info option to display info page.
Date: Mon, 03 Dec 2007 19:45:57 +0100
Organization: Home - http://www.obry.net
Message-ID: <47544EE5.1050707@obry.net>
References: <20071202060740.269e54ad.chriscool@tuxfamily.org> <475272CF.40602@obry.net> <7vodd9zbvt.fsf@gitster.siamese.dyndns.org> <200712030653.15694.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:46:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzGJH-0001au-CU
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbXLCSqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 13:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbXLCSqG
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:46:06 -0500
Received: from smtp2b.orange.fr ([80.12.242.146]:63899 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbXLCSqF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:46:05 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b22.orange.fr (SMTP Server) with ESMTP id DBBE970000AB
	for <git@vger.kernel.org>; Mon,  3 Dec 2007 19:46:01 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-88-105.w86-205.abo.wanadoo.fr [86.205.126.105])
	by mwinf2b22.orange.fr (SMTP Server) with ESMTP id 00CF9700008A;
	Mon,  3 Dec 2007 19:46:00 +0100 (CET)
X-ME-UUID: 20071203184601338.00CF9700008A@mwinf2b22.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <200712030653.15694.chriscool@tuxfamily.org>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66947>

Christian Couder a =C3=A9crit :
> So if someone has information about how "woman" or other web or man o=
r info=20

Ok about woman. Woman is an Emacs mode to display man pages. To send ma=
n
page to display in Emacs from the command line one can use emacsclient
for example. I'm already doing this for standard man pages with a bash
function. This function does something like this:

   $ emacsclient -e '(woman "git")'

-e is for eval and the argument is the Emacs Lisp string to evaluate.

Let me know if you need more information about woman.

I think it would be nice to be able to define a Git alias. In the strin=
g
some %x could be replaced by the man page requested. We could define
multiple replacements:

   %n  -  the man entry (git-commit)
   %s  -  the simple name of the man page (git-commit.1)
   %f  -  the full pathname of the man page (/usr/man/man1/git-commit.1=
)
   %i  -  the full pathname of the info page

With this I think it should be possible to define and configure any
external tool to display the man page.

This would be more versatile and could be used to display info or man
using whatever tool.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
