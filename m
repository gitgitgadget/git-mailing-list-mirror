From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 16:47:03 +0200
Message-ID: <vpq4oroqbvc.fsf@bauges.imag.fr>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
	<vpqskf8z0rj.fsf@bauges.imag.fr>
	<2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 16:47:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi8AD-0005lF-JC
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 16:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbZHaOrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 10:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZHaOrK
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 10:47:10 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39682 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbZHaOrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 10:47:09 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n7VEj2RW007509
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 31 Aug 2009 16:45:02 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mi89v-0006Zn-TG; Mon, 31 Aug 2009 16:47:03 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mi89v-0001YM-Rp; Mon, 31 Aug 2009 16:47:03 +0200
In-Reply-To: <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com> (Sitaram Chamarty's message of "Mon\, 31 Aug 2009 20\:00\:41 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 31 Aug 2009 16:45:02 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7VEj2RW007509
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252334704.41668@BjVS2bZtaAYY1GqIhrbUrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127485>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> To start with, this is Mandriva 2009.1, kernel 2.6.29, git built from
> scratch locally (not an RPM or something).  Should I try some other
> things like strace?

Setting $GIT_TRACE to 2 can help, too. The problem is that the git
instance you want to debug is the remote one, I don't know if there's
a better way to do that than putting a wrapper script for
git-upload-pack ...

-- 
Matthieu
