From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-svn rebase screwing up commit messages
Date: Sat, 28 Jul 2007 10:11:56 -0400
Message-ID: <20070728101156.20304d11.seanlkml@sympatico.ca>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
	<7v8x90sp25.fsf@assigned-by-dhcp.cox.net>
	<20070728083536.540e471d.seanlkml@sympatico.ca>
	<7vodhwptba.fsf@assigned-by-dhcp.cox.net>
	<20070728092914.48f6305c.seanlkml@sympatico.ca>
	<7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 16:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEn2p-0003BQ-Rx
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 16:13:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbXG1ONI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 10:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbXG1ONH
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 10:13:07 -0400
Received: from bay0-omc3-s13.bay0.hotmail.com ([65.54.246.213]:41794 "EHLO
	bay0-omc3-s13.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751674AbXG1ONF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 10:13:05 -0400
Received: from BAYC1-PASMTP07.bayc1.hotmail.com ([65.54.191.167]) by bay0-omc3-s13.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 28 Jul 2007 07:13:03 -0700
X-Originating-IP: [69.156.137.240]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.137.240]) by BAYC1-PASMTP07.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 28 Jul 2007 07:14:13 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IEn2U-0001rW-6Q; Sat, 28 Jul 2007 10:13:02 -0400
In-Reply-To: <7vk5skps1g.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 28 Jul 2007 14:14:13.0937 (UTC) FILETIME=[93562210:01C7D121]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54034>

On Sat, 28 Jul 2007 06:38:19 -0700
Junio C Hamano <gitster@pobox.com> wrote:


> Actually the patched behaviour actively encourages a bad (not in
> the sense that those oneline tools will not work well, but in
> the sense that these messages are reader unfriendly) practice; I
> do not think what the patch did deserves to be called "fixed".
> And that is one of the reasons, other than that we are in -rc
> freeze that we do not add anything but unarguable fixes, that I
> am not considering the patch for inclusion right now.
> 

First, i didn't read the patch and i have no stake at all in
non-conforming commit messages; i always follow the convention.
Having said that, the current behavior of Git crosses the line
from advocating the common commit message format into the realm
of not-working properly with non-conforming commit messages.

I would argue that you shouldn't try to have it both ways.  Either
Git supports non-conforming message formats, in which case the
current behavior seems buggy.  Or Git does not support commit
messages that deviate from the standard, in which case the
documentation should be updated to state so bluntly.

If handling email-mangled commit messages means that non-conforming
formats can no longer be fully supported (while discouraged) then
perhaps the time has come to explicitly state that people should
not expect Git to handle anything but the 1+empty+description
commit message format.

Sean
