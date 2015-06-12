From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: strange result of `git describe` while bisecting
Date: Fri, 12 Jun 2015 15:17:40 +0200
Message-ID: <87ioatvzez.fsf@igel.home>
References: <20150612130027.GA19711@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Philippe De Muyter <phdm@macq.eu>
X-From: git-owner@vger.kernel.org Fri Jun 12 15:17:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3OqD-0006Il-7g
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 15:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390AbbFLNRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 09:17:44 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58546 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633AbbFLNRn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 09:17:43 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3m7Mzn5Cpfz3hjNm;
	Fri, 12 Jun 2015 15:17:41 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3m7Mzn4SRkzvjDK;
	Fri, 12 Jun 2015 15:17:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id rkCqWpDcCCF0; Fri, 12 Jun 2015 15:17:40 +0200 (CEST)
X-Auth-Info: +Y2zi77mboBlwztCCXT8ojgfXomwqMGKeRwTgGgAXwdH8/rVZ9pgCG2HdV26Dy9M
Received: from igel.home (ppp-46-244-170-253.dynamic.mnet-online.de [46.244.170.253])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 12 Jun 2015 15:17:40 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 8FC252C2480; Fri, 12 Jun 2015 15:17:40 +0200 (CEST)
X-Yow: Are you selling NYLON OIL WELLS??  If so, we can use TWO DOZEN!!
In-Reply-To: <20150612130027.GA19711@frolo.macqel> (Philippe De Muyter's
	message of "Fri, 12 Jun 2015 15:00:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271486>

Philippe De Muyter <phdm@macq.eu> writes:

> I am bisecting the kernel tree between v3.17 and v3.18, and 'git describe'
> is used by the kernel compilation process.  Why do I get a version
> v3.17-rc7-1626-ga4b4a2b, that seems outside of [v3.17..v3.18] ?

Because your are testing a side branch that is based on v3.17-rc7.

3.17-rc7 --- 3.17 ------- 3.18
           \           /
            \----- * -/
                   ^
You are here ------^

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
