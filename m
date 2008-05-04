From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 5/6] fn_out_diff_words_aux: Handle common diff line
 more carefully
Date: Sun, 4 May 2008 10:54:19 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805041053380.30431@racer>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com> <1209874815-14411-1-git-send-email-pkufranky@gmail.com> <1209874815-14411-2-git-send-email-pkufranky@gmail.com> <1209874815-14411-3-git-send-email-pkufranky@gmail.com>
 <1209874815-14411-4-git-send-email-pkufranky@gmail.com> <1209874815-14411-5-git-send-email-pkufranky@gmail.com> <1209874815-14411-6-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 11:55:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsaw3-00047K-Rn
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 11:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbYEDJyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 05:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753934AbYEDJyY
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 05:54:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:45888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752447AbYEDJyY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 05:54:24 -0400
Received: (qmail invoked by alias); 04 May 2008 09:54:22 -0000
Received: from dslb-088-067-220-031.pools.arcor-ip.net (EHLO dslb-088-067-220-031.pools.arcor-ip.net) [88.67.220.31]
  by mail.gmx.net (mp024) with SMTP; 04 May 2008 11:54:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182G3A0hXQ2ozbIqfuNVVUtCLLYW+M8Bsh26uMrAZ
	BuiELtFQ4vsXRs
X-X-Sender: gene099@racer
In-Reply-To: <1209874815-14411-6-git-send-email-pkufranky@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81161>

Hi,

On Sun, 4 May 2008, Ping Yin wrote:

> Before feeding minus and plus lines into xdi_diff, we replace non word
> characters with '\n'. So we need recover the replaced character (always
> the last character) in the callback fn_out_diff_words_aux.
> 
> Therefore, a common diff line beginning with ' ' is not always a real
> common line.

Umm, why?

> And we should check the last characters of the common diff line. If they 
> are different, we should output the first len-1 characters as the common 
> part and then the last characters in minus and plus separately.

Umm, why?

Ciao,
Dscho
