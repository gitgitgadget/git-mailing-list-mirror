From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Generate version file by hooks
Date: Tue, 17 Mar 2009 17:54:57 +0100
Message-ID: <49BFD5E1.60803@viscovery.net>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AF280@EXCHANGE.trad.tradestation.com> <200903171740.26575.bjoern01@nurfuerspam.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Dlugosz <JDlugosz@tradestation.com>,
	=?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
To: =?ISO-8859-1?Q?Bj=F6rn_Hendriks?= <bjoern01@nurfuerspam.de>
X-From: git-owner@vger.kernel.org Tue Mar 17 17:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljcal-0002mj-Bu
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 17:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbZCQQzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Mar 2009 12:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbZCQQzJ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:55:09 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:9700 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbZCQQzI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 12:55:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LjcZ7-0007EW-SC; Tue, 17 Mar 2009 17:54:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 983406C4; Tue, 17 Mar 2009 17:54:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200903171740.26575.bjoern01@nurfuerspam.de>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113505>

Bj=F6rn Hendriks schrieb:
> In fact my problem is not to find out the SHA1 of the last commit in =
a script=20
> but to have that script called automatically each time git changes th=
e=20
> commit. My idea was to use the git hooks for that, but as I explained=
 I=20
> couldn't find hooks for all cases in which a commit changes.

In fact there are so many situations where the current commit changes. =
You
won't find enough hooks to catch all cases.

You better modify your build system to look for the current commit when=
 it
is needed. That is *much* safer.

-- Hannes
