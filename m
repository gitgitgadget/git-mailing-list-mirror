From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Specifying revisions in the future
Date: Sun, 05 Feb 2012 23:58:39 +0100
Message-ID: <m2sjiox4yo.fsf@igel.home>
References: <jgjkk0$qrg$1@dough.gmane.org>
	<m3ehu9kknw.fsf@localhost.localdomain> <m2wr81vsdv.fsf@igel.home>
	<201202052324.59941.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, jpaugh@gmx.us,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 23:58:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuB2k-0004lb-F0
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 23:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475Ab2BEW6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 17:58:41 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:35772 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2BEW6k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 17:58:40 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id C91A11C0F561;
	Sun,  5 Feb 2012 23:58:39 +0100 (CET)
X-Auth-Info: rrXeO9wSngatpa2g4WsnXh9MLOyvcRDryeBck1wFazI=
Received: from igel.home (ppp-88-217-114-0.dynamic.mnet-online.de [88.217.114.0])
	by mail.mnet-online.de (Postfix) with ESMTPA id BC23C1C00045;
	Sun,  5 Feb 2012 23:58:39 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 74EB8CA29F; Sun,  5 Feb 2012 23:58:39 +0100 (CET)
X-Yow: Hydraulic pizza oven!!  Guided missile!  Herring sandwich!  Styrofoam!
 Jayne Mansfield!  Aluminum siding!  Borax!  Pedal pushers!  Jukebox!
In-Reply-To: <201202052324.59941.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 5 Feb 2012 23:24:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189983>

Jakub Narebski <jnareb@gmail.com> writes:

> Nope, still ambiguous:
>
>
>
>   ---X<---*<---.<---A<---.<---M<---
>            \                 /
>             \--.<---B<------/
>
> Is X+3 A or B?  Though '--first-parent + towards N' is I think unambiguous.
                                                   M

X+3->M is A, if A is the leftmost ancestor of M.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
