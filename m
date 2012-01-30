From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] completion: add new zsh completion
Date: Mon, 30 Jan 2012 09:39:00 +0100
Message-ID: <vpqwr89d1p7.fsf@bauges.imag.fr>
References: <1327881699-25461-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 09:39:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrmle-0008SG-3V
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 09:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab2A3IjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 03:39:08 -0500
Received: from mx2.imag.fr ([129.88.30.17]:55577 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753988Ab2A3IjH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 03:39:07 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q0U8aWGr024153
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 30 Jan 2012 09:36:32 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RrmlQ-0002fm-IY; Mon, 30 Jan 2012 09:39:00 +0100
In-Reply-To: <1327881699-25461-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 30 Jan 2012 02:01:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 30 Jan 2012 09:36:32 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q0U8aWGr024153
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1328517396.42855@tIf1CRPyLTqwaqcpZ6vYdQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189330>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +ZSH_VERSION='' . /usr/share/git/completion/git-completion.bash

Probably stating the obvious, but this path shouldn't be hardcoded.

Something along the lines of

ZSH_VERSION='' . $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash

should do it (mostly untested, and written by a non-ZSH expert).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
