From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: difftool / mergetool waiting
Date: Sat, 14 Jan 2012 09:38:54 +0100
Message-ID: <m239biadb5.fsf@igel.home>
References: <CAG=s6FnG=3hO5jykc8s40SrCPfvJSvtEMVNBSihX5Y7T3b9SMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jonathan Seng <nekenyu@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 09:39:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlz95-0002DQ-6X
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 09:39:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154Ab2ANIi7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 03:38:59 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:44954 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab2ANIi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 03:38:58 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 6A48F18001F7;
	Sat, 14 Jan 2012 09:38:55 +0100 (CET)
X-Auth-Info: dX/tsBCTNP2UdsS8vc86VJIvsaCt9Fhy4+OI0UpTUo0=
Received: from igel.home (ppp-88-217-118-21.dynamic.mnet-online.de [88.217.118.21])
	by mail.mnet-online.de (Postfix) with ESMTPA id 62A071C0008E;
	Sat, 14 Jan 2012 09:38:55 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id E297DCA29E; Sat, 14 Jan 2012 09:38:54 +0100 (CET)
X-Yow: The PILLSBURY DOUGHBOY is CRYING for an END to BURT REYNOLDS movies!!
In-Reply-To: <CAG=s6FnG=3hO5jykc8s40SrCPfvJSvtEMVNBSihX5Y7T3b9SMg@mail.gmail.com>
	(Jonathan Seng's message of "Fri, 13 Jan 2012 21:13:44 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.92 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188555>

Jonathan Seng <nekenyu@gmail.com> writes:

> If wait is false, git would fire off the tool command and proceed to
> the next then exit cleanly.

That doesn't work for git mergetool, it wouldn't be able to postprocess
the result of calling the tool command.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
