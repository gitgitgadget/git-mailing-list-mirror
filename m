From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: How to split a patch
Date: Mon, 28 Jan 2008 10:47:32 +0100
Message-ID: <vpqfxwi5ljf.fsf@bauges.imag.fr>
References: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com>
	<7vhcgyuwsx.fsf@gitster.siamese.dyndns.org>
	<4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"git mailing list" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 10:49:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJQc3-0003wm-Ls
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 10:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbYA1Jsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 04:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbYA1Jsj
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 04:48:39 -0500
Received: from imag.imag.fr ([129.88.30.1]:56829 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbYA1Jsi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 04:48:38 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m0S9lYkS010822
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Jan 2008 10:47:35 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JJQaS-0003vW-JD; Mon, 28 Jan 2008 10:47:32 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JJQaS-0005Hz-Go; Mon, 28 Jan 2008 10:47:32 +0100
In-Reply-To: <4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com> (Paolo Ciarrocchi's message of "Mon\, 28 Jan 2008 10\:32\:54 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 28 Jan 2008 10:47:36 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71870>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> Yes it helps but I still wonder whether thereis a "simpler" way to achive that.
> Is it possible to split a patch selecting the hunk in git gui or any
> other graphical
> tool?

You can apply the patch without commiting it, and them make several
partial commits, by right-click "stage hunk for commit" in git-gui.

-- 
Matthieu
