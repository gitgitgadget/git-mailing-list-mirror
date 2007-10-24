From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: UI and git-completion.sh
Date: Wed, 24 Oct 2007 02:46:20 +0200
Message-ID: <vpqbqapgx0j.fsf@bauges.imag.fr>
References: <20071023234617.45a4fc64@paolo-desktop>
	<471E6EF0.2060403@midwinter.com> <86ve8x9z1f.fsf@blue.stonehenge.com>
	<vpqir4xgzep.fsf@bauges.imag.fr> <86prz59y9s.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Wed Oct 24 02:47:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkUOk-000644-UF
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 02:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbXJXAqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 20:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753021AbXJXAqv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 20:46:51 -0400
Received: from imag.imag.fr ([129.88.30.1]:40378 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752454AbXJXAqv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 20:46:51 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l9O0kK6p027765
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Oct 2007 02:46:21 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IkUO4-00043n-Og; Wed, 24 Oct 2007 02:46:20 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IkUO4-0004ta-MF; Wed, 24 Oct 2007 02:46:20 +0200
In-Reply-To: <86prz59y9s.fsf@blue.stonehenge.com> (Randal L. Schwartz's message of "Tue\, 23 Oct 2007 17\:01\:03 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 24 Oct 2007 02:46:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62178>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Matthieu" == Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
> Matthieu> In zsh itself.
>
> Matthieu> Completion/Unix/Command/_git
>
> Not in my version of zsh.  Any chance I can add that to my 4.2.3
> installation?

http://zsh.cvs.sourceforge.net/zsh/zsh/Completion/Unix/Command/_git

Try adding it to your $fpath, hopefully, the new _git doesn't use the
other new zsh features, and it will work (I have a CVS _git with a
4.3.4 zsh, and it works like a charm).

-- 
Matthieu
