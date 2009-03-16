From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: adding files in .git?
Date: Mon, 16 Mar 2009 17:56:32 +0100
Message-ID: <vpqr60x76f3.fsf@bauges.imag.fr>
References: <3a69fa7c0903160814u42fbb461qf03a37176546357d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 18:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjGDN-00079W-2b
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 18:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbZCPRB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 13:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbZCPRB0
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 13:01:26 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:56824 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbZCPRBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 13:01:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id n2GGufwk011822;
	Mon, 16 Mar 2009 17:56:41 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LjG76-0005Hj-V1; Mon, 16 Mar 2009 17:56:32 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LjG76-0007Fg-Pt; Mon, 16 Mar 2009 17:56:32 +0100
In-Reply-To: <3a69fa7c0903160814u42fbb461qf03a37176546357d@mail.gmail.com> (E. R.'s message of "Mon\, 16 Mar 2009 10\:14\:58 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 16 Mar 2009 17:56:42 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113344>

E R <pc88mxer@gmail.com> writes:

> 1) Use another file in .git similar to the "description" file (such as
> .git/short-description)
> 2) Use a setting in the .git/config file.
>
> Any comments on the advantages/disadvantages of these approaches?

Neither of them will propagate through clone. Depending on your
use-case, this is an advantage or not.

-- 
Matthieu
