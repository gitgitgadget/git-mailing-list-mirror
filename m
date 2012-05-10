From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Equivalent of "fixup" for git filter-branch
Date: Thu, 10 May 2012 19:39:07 +0200
Message-ID: <m21umsylz8.fsf@igel.home>
References: <CAGK7Mr5D0WQn-Tc1B5=F7+3OgZd1uy54Be-ZrbyFv0CP8JY5bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Philippe Vaucher <philippe.vaucher@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 19:39:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSXKo-0005sp-9o
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 19:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760873Ab2EJRjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 13:39:13 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51648 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760796Ab2EJRjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 13:39:09 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VpMB40TXDz3hhY6;
	Thu, 10 May 2012 19:39:08 +0200 (CEST)
Received: from igel.home (ppp-88-217-121-16.dynamic.mnet-online.de [88.217.121.16])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VpMB40H1Nz4KK5M;
	Thu, 10 May 2012 19:39:08 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id AE15DCA2A0; Thu, 10 May 2012 19:39:07 +0200 (CEST)
X-Yow: I feel real SOPHISTICATED being in FRANCE!
In-Reply-To: <CAGK7Mr5D0WQn-Tc1B5=F7+3OgZd1uy54Be-ZrbyFv0CP8JY5bw@mail.gmail.com>
	(Philippe Vaucher's message of "Thu, 10 May 2012 18:30:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.96 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197608>

Philippe Vaucher <philippe.vaucher@gmail.com> writes:

> I know there is `skip_commit` for git filter branch with
> --commit-filter which squash the current commit with the next one,
> however I have trouble finding a "fixup" equivalent that'd squash the
> commit with the previous one (just like git rebase -i allows).

Probably doable with an index filter that updates the index for the
parent commit with the contents of the fixup commit and a commit filter
that skips the fixup commit.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
