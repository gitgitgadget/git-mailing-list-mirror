From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Single brackets matching in .gitignore rules
Date: Sun, 27 Sep 2015 10:58:06 +0200
Message-ID: <m2oagotf1d.fsf@linux-m68k.org>
References: <2606743.RipZrg6Xoz@pinguin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Andrey Loskutov <loskutov@gmx.de>
X-From: git-owner@vger.kernel.org Sun Sep 27 10:58:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zg7n6-0003dG-0F
	for gcvg-git-2@plane.gmane.org; Sun, 27 Sep 2015 10:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbbI0I6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2015 04:58:11 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:44905 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912AbbI0I6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2015 04:58:10 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3nP18v64kHz3hhxC;
	Sun, 27 Sep 2015 10:58:07 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3nP18v5Y12zvh21;
	Sun, 27 Sep 2015 10:58:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id S-1xE0ZOs4sH; Sun, 27 Sep 2015 10:58:06 +0200 (CEST)
X-Auth-Info: AT8Rx2wqX5yhP2k0/Xdy2ZdFwGTH9sagpk6xfGVB440ghIa/aqgy5CAQnVPlMd9d
Received: from linux.local (host-188-174-216-54.customer.m-online.net [188.174.216.54])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 27 Sep 2015 10:58:06 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 5EF781E538D; Sun, 27 Sep 2015 10:58:06 +0200 (CEST)
X-Yow: Yow!  I'm UNEMPLOYED!
In-Reply-To: <2606743.RipZrg6Xoz@pinguin> (Andrey Loskutov's message of "Sun,
	27 Sep 2015 00:01:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278700>

Andrey Loskutov <loskutov@gmx.de> writes:

> Next, the surprising table for ']':
> ----------------------
> rule  | file | match?
> ----------------------
> ]           ]          true
> ]*         ]          true
> *]         ]          true
> *]         a]        true
> ----------------------
>
> Here Git does not give up on parsing, treats unmatched ']' character literally, and doesn't dislike that it is an "unmatched" end of a broken character group.
> Why?

] by itself is not special in a glob.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
