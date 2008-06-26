From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: about c8af1de9 (git status uses pager)
Date: Thu, 26 Jun 2008 08:04:22 +0200
Message-ID: <vpq1w2klok9.fsf@bauges.imag.fr>
References: <alpine.LNX.1.10.0806212319410.22036@fbirervta.pbzchgretzou.qr>
	<20080621214241.GA3839@dualtron.vpn.rwth-aachen.de>
	<20080622072420.GA5161@dualtron.vpn.rwth-aachen.de>
	<g3v3s1$bok$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 08:06:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBkdB-0000bj-Je
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 08:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbYFZGF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 02:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbYFZGF6
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 02:05:58 -0400
Received: from harmonie.imag.fr ([147.171.130.40]:56776 "EHLO harmonie.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbYFZGF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 02:05:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by harmonie.imag.fr (8.13.8/8.13.8) with ESMTP id m5Q64nDZ008124;
	Thu, 26 Jun 2008 08:04:49 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KBkak-0003qp-Vs; Thu, 26 Jun 2008 08:04:23 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KBkak-0005qw-Sp; Thu, 26 Jun 2008 08:04:22 +0200
In-Reply-To: <g3v3s1$bok$1@ger.gmane.org> (Dan McGee's message of "Wed\, 25 Jun 2008 22\:53\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (harmonie.imag.fr [147.171.130.40]); Thu, 26 Jun 2008 08:04:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86401>

Dan McGee <dpmcgee@gmail.com> writes:

> That became impossible with 1.5.6 out of the box,

Actually, by default it does. It does not for you because you've set
$LESS. That said, I argee that a config option to enable/disable the
pager per-command would have been better that the change we're talking
about.

-- 
Matthieu
