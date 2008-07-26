From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Modify mingw_main() workaround to avoid link errors
Date: Sat, 26 Jul 2008 22:37:35 +0200
Message-ID: <1217104655.488b8b0f5ca48@webmail.nextra.at>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 22:38:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMqXI-00039g-LA
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 22:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbYGZUhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 16:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755037AbYGZUhk
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 16:37:40 -0400
Received: from smtp2.srv.eunet.at ([193.154.160.116]:33370 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbYGZUhk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 16:37:40 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp2.srv.eunet.at (Postfix) with ESMTPS id 5FA02BEE7D;
	Sat, 26 Jul 2008 22:37:36 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6QKbZ0W005821;
	Sat, 26 Jul 2008 22:37:35 +0200
Received: from 77.116.24.199 ([77.116.24.199]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Sat, 26 Jul 2008 22:37:35 +0200
In-Reply-To: <1217065304-27815-1-git-send-email-prohaska@zib.de>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.116.24.199
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90283>

Zitat von Steffen Prohaska <prohaska@zib.de>:
> With MinGW's
>
>    gcc.exe (GCC) 3.4.5 (mingw special)
>    GNU ld version 2.17.50 20060824
>
> the old define caused link errors:
>
>    git.o: In function `main':
>    C:/msysgit/git/git.c:500: undefined reference to `mingw_main'
>    collect2: ld returned 1 exit status
>
> The modified define works.

I have the same tools, but not this error. ???

-- Hannes
