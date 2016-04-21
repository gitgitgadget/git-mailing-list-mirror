From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 15:24:43 +0200
Message-ID: <87lh473xic.fsf@linux-m68k.org>
References: <20160421113004.GA3140@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Thu Apr 21 15:24:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atEbI-0002gF-8d
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 15:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbcDUNYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 09:24:52 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40292 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbcDUNYv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 09:24:51 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3qrKH16BfMz3hp37;
	Thu, 21 Apr 2016 15:24:44 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3qrKH06KFgzvk8B;
	Thu, 21 Apr 2016 15:24:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id 8qIEHvxA5kvS; Thu, 21 Apr 2016 15:24:44 +0200 (CEST)
X-Auth-Info: ITykyRHJb04ZLN5M4g9fpWsMcdIQlDUm5tTrNgCFRcLoVwE8WhJxYHW1dSEHOkWR
Received: from igel.home (ppp-88-217-12-87.dynamic.mnet-online.de [88.217.12.87])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu, 21 Apr 2016 15:24:44 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id E2BFB2C3424; Thu, 21 Apr 2016 15:24:43 +0200 (CEST)
X-Yow: Everywhere I look I see NEGATIVITY and ASPHALT...
In-Reply-To: <20160421113004.GA3140@aepfle.de> (Olaf Hering's message of "Thu,
	21 Apr 2016 13:30:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292110>

Olaf Hering <olaf@aepfle.de> writes:

> How can I find out whats going on? Is my git(1) 2.8.1 broken, or did
> Linus just pull some junk tree (and does he continue to do so)?

The branches recently pulled by Linus contain commits with rather old
author dates, eg 8cad489261c564d4ee1db4de4ac365af56807d8a or
281baf7a702693deaa45c98ef0c5161006b48257.  That will probably cause git
describe --contains to take a different path through the history.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
