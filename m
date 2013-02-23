From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git checkout problem
Date: Sat, 23 Feb 2013 09:19:07 +0100
Message-ID: <m238wn5tok.fsf@igel.home>
References: <51280DA5.800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 09:19:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9AKd-0000lt-AG
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 09:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311Ab3BWITM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 03:19:12 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:36814 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab3BWITL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 03:19:11 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3ZCj4Y5lYgz4KK2w;
	Sat, 23 Feb 2013 09:19:09 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3ZCj4Y5Xd7zbdcV;
	Sat, 23 Feb 2013 09:19:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id urvj9KXfAMPA; Sat, 23 Feb 2013 09:19:09 +0100 (CET)
X-Auth-Info: iAzP4+R3Xpk1BDmzKMpKykXyk5i9/ofQitXU8UEZfVI=
Received: from igel.home (ppp-88-217-122-171.dynamic.mnet-online.de [88.217.122.171])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sat, 23 Feb 2013 09:19:09 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 822B8CA2A1; Sat, 23 Feb 2013 09:19:08 +0100 (CET)
X-Yow: Quick, sing me the BUDAPEST NATIONAL ANTHEM!!
In-Reply-To: <51280DA5.800@gmail.com> (J. V.'s message of "Fri, 22 Feb 2013
	17:30:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216892>

"J.V." <jvsrvcs@gmail.com> writes:

> Now am trying to go back to my master branch and get:
>
> error: The following untracked working tree files would be overwritten by
> checkout:
>         lib/derbyclient.jar
> Please move or remove them before you can switch branches.
> Aborting

When in doubt, try running "git status".  What does it say?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
