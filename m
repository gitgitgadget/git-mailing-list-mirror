From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: git-email automatic --to detection?
Date: Tue, 26 Feb 2008 10:23:56 +0100
Message-ID: <vpqve4c136b.fsf@bauges.imag.fr>
References: <slrnfs3rv4.aqm.jgoerzen@katherina.lan.complete.org>
	<20080225183413.GA15131@sigill.intra.peff.net>
	<vpqoda43lva.fsf@bauges.imag.fr>
	<slrnfs67lp.lsg.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 10:26:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTw4y-0004L0-9a
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 10:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762120AbYBZJZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 04:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762114AbYBZJZt
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 04:25:49 -0500
Received: from imag.imag.fr ([129.88.30.1]:49524 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762029AbYBZJZp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 04:25:45 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m1Q9O2gw012108
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 26 Feb 2008 10:24:03 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JTw2W-00033N-QR; Tue, 26 Feb 2008 10:23:56 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JTw2W-0006ds-NX; Tue, 26 Feb 2008 10:23:56 +0100
In-Reply-To: <slrnfs67lp.lsg.jgoerzen@katherina.lan.complete.org> (John Goerzen's message of "Mon\, 25 Feb 2008 14\:02\:01 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 26 Feb 2008 10:24:03 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75115>

John Goerzen <jgoerzen@complete.org> writes:

> On 2008-02-25, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> You can have a maintainer A advertizing for A@domain.com, and a
>> "sub-maintainer" B advertizing for B@domain.com. If A merges from B,
>> he doesn't want his advertized adress to become the one of B.
>
> Right.  That's why this would be a per-repo setting.  It wouldn't be
> pulled or cloned, just looked up when needed.

I think it should. Not versionned, but initialized by "clone" based on
the cloned repo.

The advantage of a clone-time initialization compared to a submit-time
look up is that the local user can very easily change the value
manually after a clone.

-- 
Matthieu
