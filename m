From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: How can I get full filenames from Git difftool (for Microsoft
 Word =?utf-8?Q?=E2=80=9CCompare_Documents=E2=80=9D?= feature)?
Date: Mon, 14 Dec 2009 08:55:53 +0100
Message-ID: <vpqd42i56ra.fsf@bauges.imag.fr>
References: <b507cb050912132222x7e1daa9cw73b13f3db0ee22c6@mail.gmail.com>
	<b507cb050912132225j1bdc39c2v42a3bf6bddf1cb1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Doug Ireton <dougireton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 08:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK5mu-0002dC-Gb
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 08:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755051AbZLNH4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 02:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890AbZLNH4B
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 02:56:01 -0500
Received: from mx1.imag.fr ([129.88.30.5]:33700 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754848AbZLNH4B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 02:56:01 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id nBE7thtS006600
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 14 Dec 2009 08:55:43 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NK5mc-0007x7-7t; Mon, 14 Dec 2009 08:55:54 +0100
In-Reply-To: <b507cb050912132225j1bdc39c2v42a3bf6bddf1cb1a@mail.gmail.com> (Doug Ireton's message of "Sun\, 13 Dec 2009 22\:25\:30 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 14 Dec 2009 08:55:43 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nBE7thtS006600
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1261382143.48267@NeDDQdmTtdHkVHI0LFc27A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135170>

Doug Ireton <dougireton@gmail.com> writes:

> I am using the latest version of=A0Git (1.6.6)=A0on a Mac. My wife wa=
nts
> to use Git to manage her fiction writing as long as she can still use
> Microsoft Word 2008=A0(Mac). Instead of pushing her into saving
> everything as plain text, I would like to use Git Difftool to pass th=
e
> files to Word and use Word's Compare Documents feature. She wouldn't
> be able to use Git Diff since Word docs are binary files but she coul=
d
> still use Git Difftool.

If you're interested in diff-ing the _text_ itself, you can use the
textconv filter of Git, together with antiword (or catdoc, which does
the same thing, but I think antiword works better).

See this:

http://git.or.cz/gitwiki/GitTips#HowtousegittotrackOpenDocument.28OpenO=
ffice.2CKoffice.29files.3F

and adapt by replacing "OpenOffice" with MS Word, and odt2txt with
antiword.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
