From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: GIT get corrupted on lustre
Date: Mon, 24 Dec 2012 15:48:13 +0100
Message-ID: <m2bodjv74i.fsf@igel.home>
References: <50D861EE.6020105@giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Mon Dec 24 15:48:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn9KV-0005yr-GN
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 15:48:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab2LXOsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 09:48:18 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37438 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752597Ab2LXOsR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 09:48:17 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3YVNbf4fQfz4KKCB;
	Mon, 24 Dec 2012 15:48:14 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3YVNbf3lxszbbcq;
	Mon, 24 Dec 2012 15:48:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id dyP_WMG1xVnL; Mon, 24 Dec 2012 15:43:58 +0100 (CET)
X-Auth-Info: m0UsfqQCXcHS9k5XCUj1AwNOB2SI9fO2VE1VktksEi8=
Received: from igel.home (ppp-93-104-134-127.dynamic.mnet-online.de [93.104.134.127])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 24 Dec 2012 15:48:13 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 5CCE7CA2A2; Mon, 24 Dec 2012 15:48:13 +0100 (CET)
X-Yow: Thank god!!..  It's HENNY YOUNGMAN!!
In-Reply-To: <50D861EE.6020105@giref.ulaval.ca> (Eric Chamberland's message of
	"Mon, 24 Dec 2012 09:08:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212110>

Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:

> #1) However, how can we *test* the filesystem (lustre) compatibility with
> git? (Is there a unit test we can run?)

Have you considered running git's testsuite?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
