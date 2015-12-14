From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git bisect with temporary commits
Date: Mon, 14 Dec 2015 19:08:48 +0100
Message-ID: <87si34hphr.fsf@igel.home>
References: <20151214163726.GY13519@tonks>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, r.seitz@beh.ch
To: Florian Bruhin <me@the-compiler.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 19:09:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8XYV-000606-K2
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 19:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753188AbbLNSI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 13:08:57 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:58719 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087AbbLNSIy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 13:08:54 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3pK9hL4JtPz3hpYd;
	Mon, 14 Dec 2015 19:08:50 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3pK9hL3DW5zvh1q;
	Mon, 14 Dec 2015 19:08:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id FdVcr7qZjD_m; Mon, 14 Dec 2015 19:08:49 +0100 (CET)
X-Auth-Info: jGWPb4viXR8hOPb6Ck9Gz/Dq9bRzQqvv5VRuwe60FC6QHmUYoOgzkUZNimhg/o99
Received: from igel.home (ppp-88-217-8-172.dynamic.mnet-online.de [88.217.8.172])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 14 Dec 2015 19:08:49 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id D4E172C1A2D; Mon, 14 Dec 2015 19:08:48 +0100 (CET)
X-Yow: I demand IMPUNITY!
In-Reply-To: <20151214163726.GY13519@tonks> (Florian Bruhin's message of "Mon,
	14 Dec 2015 17:37:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282374>

Florian Bruhin <me@the-compiler.org> writes:

> Now when trying to say it's good (and forgetting to remove the
> temporary commits), I get this:
>
>     $ git bisect good
>     Bisecting: a merge base must be tested
>     [981e1093dae24b37189bcba2dd848b0c3388080c] still good and does not compile
>
> Is this intended behaviour? Shouldn't git either do a reset to the
> commit we're currently bisecting, or warn the user as it was probably
> unintended to add new commits?

You should instead tell git that HEAD^ is good, since that is what git
asked you to test.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
