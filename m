From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git config error message
Date: Sat, 27 Oct 2012 10:25:44 +0200
Message-ID: <m2bofo9v93.fsf@linux-m68k.org>
References: <CAB9Jk9AQkSiv=F8NeYs+uspR5f4CeJS5L-hwZUXdq7dts1W5ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 10:26:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS1iU-0003EE-FN
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 10:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173Ab2J0IZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 04:25:49 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:59178 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681Ab2J0IZr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 04:25:47 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XpZs56Khvz3hhkH;
	Sat, 27 Oct 2012 10:25:45 +0200 (CEST)
X-Auth-Info: Luq9KHSXMTYaf46hVc7wgBxSRCFZx2Jkb14CwIC6hf8=
Received: from linux.local (ppp-93-104-148-157.dynamic.mnet-online.de [93.104.148.157])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XpZs55xCfzbbmg;
	Sat, 27 Oct 2012 10:25:45 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 173AE1E550C; Sat, 27 Oct 2012 10:25:44 +0200 (CEST)
X-Yow: I'm shaving!!  I'M SHAVING!!
In-Reply-To: <CAB9Jk9AQkSiv=F8NeYs+uspR5f4CeJS5L-hwZUXdq7dts1W5ng@mail.gmail.com>
	(Angelo Borsotti's message of "Sat, 27 Oct 2012 10:10:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208499>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> git config --get issues an error message when the specified value
> contains a section that does not exist, but does not issue any message
> when the value contains a key that does not exist while in both cases
> returning a status 1. E.g.
>
> $ git config --get xxx
> error: key does not contain a section: xxx
>
> $ git config --get xxx.yyy
>
> Proposal: to issue an error message also when the key does not exist.

The two cases are different: a key without a section is malformed,
whereas a nonexistent value is usually not an error (use the default
instead).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
