From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: SSL + mod_dav + Git
Date: Mon, 11 Aug 2008 11:44:57 +0200
Message-ID: <vpqsktbga1y.fsf@bauges.imag.fr>
References: <a7b96a640807290453l582c3f11w6a0f0c841063f07@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Chris Hart" <chris@christopherhart.ca>
X-From: git-owner@vger.kernel.org Mon Aug 11 11:48:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSU0j-0006Rb-NF
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 11:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbYHKJrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 05:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbYHKJrS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 05:47:18 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:60666 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbYHKJrR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 05:47:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m7B9ivAs019514;
	Mon, 11 Aug 2008 11:44:57 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KSTxR-0005MG-AD; Mon, 11 Aug 2008 11:44:57 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KSTxR-0004Ch-5O; Mon, 11 Aug 2008 11:44:57 +0200
In-Reply-To: <a7b96a640807290453l582c3f11w6a0f0c841063f07@mail.gmail.com> (Chris Hart's message of "Tue\, 29 Jul 2008 07\:53\:08 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Mon, 11 Aug 2008 11:44:58 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91922>

"Chris Hart" <chris@christopherhart.ca> writes:

> However, once authenticated to the .git folder (cadaver through
> https), basic commands give strange errors or 404s. Ls throws "Listing
> collection `/.git/': failed:

This one is not a git problem, as mentionned in another message.
You'll get better chance on an apache-related list I think.

> Trying git clone https://server/.git throws:

This actually uses plain http, not webdav itself. push will be the
next step, and will be the one using webdav.

> "warning: remote HEAD refers to nonexistent ref, unable to checkout"

That can mean you need a git update-server-info on the server.

-- 
Matthieu
