From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 15:03:55 +0100
Message-ID: <vpqhaocqx4k.fsf@grenoble-inp.fr>
References: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
	<1353935441-ner-9639@calvin> <vpqr4ngsdjl.fsf@grenoble-inp.fr>
	<CAO1Khk9mzJjnysnc1iDFeMgqnRq0z35t0kgC-8nrsjJ-oOvdOg@mail.gmail.com>
	<vpqehjgscv3.fsf@grenoble-inp.fr>
	<CAO1Khk8=nrKknfqY-k6XaGPDbLrHyrK-8fxfB7XXUWeB7L4EUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tomas Carnecky <tomas.carnecky@gmail.com>, git@vger.kernel.org
To: Igor Lautar <igor.lautar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 15:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TczIH-0001xe-07
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 15:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab2KZOEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 09:04:00 -0500
Received: from mx2.imag.fr ([129.88.30.17]:59789 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745Ab2KZOEA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 09:04:00 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id qAQDsW0X001671
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 26 Nov 2012 14:54:32 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TczHv-0006Jc-UR; Mon, 26 Nov 2012 15:03:55 +0100
In-Reply-To: <CAO1Khk8=nrKknfqY-k6XaGPDbLrHyrK-8fxfB7XXUWeB7L4EUA@mail.gmail.com>
	(Igor Lautar's message of "Mon, 26 Nov 2012 14:58:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 26 Nov 2012 14:54:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: qAQDsW0X001671
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1354542874.80907@0LfNrOJdcSjiAYk/TF/DZw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210448>

Igor Lautar <igor.lautar@gmail.com> writes:

> Yes, change is shown in commit^2, but actual file after merge does not have it.

Your initial message was about the output of "git log". Do you mean that
the file, on the filesystem, does not have the line introduced by the
commit?

If so, check the content registered in the repository too:

git show <merge-commit>:<file-name>

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
