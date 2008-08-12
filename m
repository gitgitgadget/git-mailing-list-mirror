From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: How to edit commit messages?
Date: Tue, 12 Aug 2008 14:49:49 +0200
Message-ID: <vpqd4kepfde.fsf@bauges.imag.fr>
References: <g7s088$o1p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: dr.chiarello@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 12 14:53:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KStN6-0002xW-SA
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 14:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbYHLMv3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2008 08:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754184AbYHLMv2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 08:51:28 -0400
Received: from imag.imag.fr ([129.88.30.1]:61328 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbYHLMv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 08:51:27 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m7CCnrvn015944
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Aug 2008 14:49:53 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KStJt-0000FM-47; Tue, 12 Aug 2008 14:49:49 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KStJt-0008Bt-1i; Tue, 12 Aug 2008 14:49:49 +0200
In-Reply-To: <g7s088$o1p$1@ger.gmane.org> (dr chiarello's message of "Tue\, 12 Aug 2008 14\:38\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 12 Aug 2008 14:49:53 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92094>

dr.chiarello@gmail.com writes:

> Hi all,
> =A0 what are the best solution to:
> 1) interactively edit commit's messages (some or all)

  git rebase -i

can help.

> 2) batch edit commit's messages (for example using sed)

  git filter-branch --msg-filter sed 's/foo/bar/'

should do it.

--=20
Matthieu
