From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-gui: use textconv filter for diff and blame
Date: Fri, 30 Jul 2010 08:56:37 +0200
Message-ID: <vpq8w4tpie2.fsf@bauges.imag.fr>
References: <1280319830-20483-1-git-send-email-Matthieu.Moy@imag.fr>
	<871valstsi.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Clemens Buchacher <drizzd@aon.at>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Jul 30 08:57:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OejWf-0007ev-Rb
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 08:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab0G3G4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 02:56:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59994 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634Ab0G3G4x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 02:56:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o6U6sl9W025061
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 30 Jul 2010 08:54:49 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OejWI-00085m-CS; Fri, 30 Jul 2010 08:56:38 +0200
In-Reply-To: <871valstsi.fsf@fox.patthoyts.tk> (Pat Thoyts's message of "Fri\, 30 Jul 2010 01\:22\:05 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 30 Jul 2010 08:54:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o6U6sl9W025061
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1281077692.71616@cxc/iBFOW4W8Z8zGS61LrA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152221>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> This looks generally fine but can you suggest some test that I can use
> to ensure it is actually doing something. I tried committing some test
> files containing cyrillic characters but I see no difference between
> using an unpatched git-gui and your patched version with git 1.7.2

textconv has not much to do with encoding. It's a way to tell git the
name of a command that converts a file into plain text. Typical usages
would be to use odt2txt, catdoc/antiword, or meta-information
extraction (like exiftags).

Have a look here:

  https://git.wiki.kernel.org/index.php/Textconv

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
