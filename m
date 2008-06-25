From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Wed, 25 Jun 2008 14:20:52 +0200
Message-ID: <vpqtzfhr9i3.fsf@bauges.imag.fr>
References: <U-ySqQANiPRpld4kgzdXbovGgsj6LfOEdRmtTDU2yyvITSG3LnZAsQ@cipher.nrlssc.navy.mil>
	<willow-jeske-01l5PFjPFEDjCfzf-01l5uqS9FEDjCcuF>
	<willow-jeske-01l5xqJDFEDjCftd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: "David Jeske" <jeske@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 15:10:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBUlh-0007vc-Tv
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 15:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331AbYFYNJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 09:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754697AbYFYNJm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 09:09:42 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:61640 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753916AbYFYNJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 09:09:41 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m5PD8ALq010054;
	Wed, 25 Jun 2008 15:08:18 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KBTzY-0004fI-Nj; Wed, 25 Jun 2008 14:20:52 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KBTzY-0004as-LF; Wed, 25 Jun 2008 14:20:52 +0200
In-Reply-To: <willow-jeske-01l5xqJDFEDjCftd> (David Jeske's message of "Tue\, 24 Jun 2008 16\:41\:59 -0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Wed, 25 Jun 2008 15:08:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86275>

"David Jeske" <jeske@google.com> writes:

> - standardize all the potentially destructive operations (after gc) on "-f /
> --force" to override

Depending on the definition of "potentially destructive", most
commands are "potentially destructive".

git pull loses the point where the branch used to point when the
reflog expires.

git add loses the old content of the index.

...

And adding too many --force options removes its real value. Many
people type "rm -fr" any time they just want "rm", just because they
were annoyed by the multiple interactive confirmations of plain "rm"
(if aliased to "rm -i"). Asking people to type --force all the time
make one fingers type --force mechanically, and removes all its value.

-- 
Matthieu
