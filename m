From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-rm isn't the inverse action of git-add
Date: Mon, 02 Jul 2007 22:54:17 +0200
Message-ID: <vpq7ipittl2.fsf@bauges.imag.fr>
References: <46893F61.5060401@jaeger.mine.nu>
	<20070702194237.GN7730@nan92-1-81-57-214-146.fbx.proxad.net>
	<46895EA4.5040803@jaeger.mine.nu>
	<20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Jaeger <christian@jaeger.mine.nu>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 22:55:02 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5SvF-0008G4-Lp
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 22:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbXGBUyl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 16:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754725AbXGBUyl
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 16:54:41 -0400
Received: from imag.imag.fr ([129.88.30.1]:39779 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754684AbXGBUyk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 16:54:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l62KsHZV011357
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 2 Jul 2007 22:54:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1I5SuX-0001J7-Gt; Mon, 02 Jul 2007 22:54:17 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1I5SuX-0003XO-EJ; Mon, 02 Jul 2007 22:54:17 +0200
Mail-Followup-To: Yann Dirson <ydirson@altern.org>, Christian Jaeger <christian@jaeger.mine.nu>,  git@vger.kernel.org
In-Reply-To: <20070702204051.GP7730@nan92-1-81-57-214-146.fbx.proxad.net> (Yann Dirson's message of "Mon\, 2 Jul 2007 22\:40\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 02 Jul 2007 22:54:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51403>

Yann Dirson <ydirson@altern.org> writes:

> That is, "git rm" will only ever remove the file without asking, when
> it is safe do so, in that you can retrieve your file from history.  Or
> do you think of another way, in which more safety would be needed ?

Defaulting to --cached would be an obvious way to avoid data-loss.
_At least_, mentionning --cached in the error message in case of
staged changes would be a considerable step forward.

At the moment, the non-expert user will have difficulties to unversion
the file without deleting it. I just see it as

$ git rm foo
error: 'foo' has changes staged in the index
(hint: to hang yourself, try -f)
$ _

-- 
Matthieu
