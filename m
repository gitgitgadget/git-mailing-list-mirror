From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] rev-parse --show-prefix: add in trailing newline
Date: Tue, 10 Apr 2012 16:41:45 +0200
Message-ID: <m2vcl7ir86.fsf@igel.home>
References: <1333978076-29968-1-git-send-email-rosslagerwall@gmail.com>
	<7v1unwwwov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ross Lagerwall <rosslagerwall@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 16:42:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHcGe-0006bH-DN
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 16:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758836Ab2DJOlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 10:41:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:60287 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391Ab2DJOly (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 10:41:54 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VRrgG22hmz3hhVj;
	Tue, 10 Apr 2012 16:41:46 +0200 (CEST)
Received: from igel.home (ppp-93-104-144-197.dynamic.mnet-online.de [93.104.144.197])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VRrgG3Sgxz4KK2V;
	Tue, 10 Apr 2012 16:41:46 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id C9D76CA2A9; Tue, 10 Apr 2012 16:41:45 +0200 (CEST)
X-Yow: ..  So, if we convert SUPPLY-SIDE SOYBEAN FUTURES into
 HIGH-YIELD T-BILL INDICATORS, the PRE-INFLATIONARY risks
 will DWINDLE to a rate of 2 SHOPPING SPREES per EGGPLANT!!
In-Reply-To: <7v1unwwwov.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 09 Apr 2012 12:07:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195084>

Junio C Hamano <gitster@pobox.com> writes:

> Because the assignment will strip the trailing LF away

No, it doesn't.  Command substitution does.

> But it will break existing scripts if they expect the following to work:
>
> 	file="$(git rev-parse --show-prefix)/$1"
>         cd_to_toplevel
>         test -f "$file"

This is already broken because of the extra slash.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
