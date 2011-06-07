From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2] Add a remote helper to interact with mediawiki, pull & clone handled
Date: Tue, 07 Jun 2011 13:20:58 +0200
Message-ID: <vpq1uz5khut.fsf@bauges.imag.fr>
References: <1307440754-3697-1-git-send-email-jeremie.nikaes@ensimag.imag.fr>
	<BANLkTik--BAqZxCYQ-ApUn2yKmcr_-hubg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	git@vger.kernel.org, jrnieder@gmail.com,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Sylvain =?iso-8859-1?Q?Boulm=E9?= <sylvain.boulme@imag.fr>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Tue Jun 07 13:21:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTuLZ-0000PB-2z
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 13:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968Ab1FGLVQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 07:21:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59794 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903Ab1FGLVP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 07:21:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p57BKv2U031376
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 7 Jun 2011 13:20:57 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QTuLD-0007fj-1E; Tue, 07 Jun 2011 13:20:59 +0200
In-Reply-To: <BANLkTik--BAqZxCYQ-ApUn2yKmcr_-hubg@mail.gmail.com> (Thomas
	Adam's message of "Tue, 7 Jun 2011 11:16:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 07 Jun 2011 13:20:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p57BKv2U031376
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1308050462.72924@9A5tioH7eZ1f7YvcHT158w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175196>

Thomas Adam <thomas@xteddy.org> writes:

>> + =A0 =A0 =A0 print STDOUT "? refs/heads/master\n";
>> + =A0 =A0 =A0 print STDOUT '@'."refs/heads/master HEAD\n";
>> + =A0 =A0 =A0 print STDOUT "\n";
>
> Hmm.  Why not just:
>
> print STDOUT '@'."refs/heads/master HEAD\n\n";

To replace the last two lines, yes, but the

? refs/heads/master

is still needed to show "git pull" that a branch master exists.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
