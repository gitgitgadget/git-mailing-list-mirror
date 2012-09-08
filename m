From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: Restore hostname logging in inetd mode
Date: Sat, 8 Sep 2012 21:18:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1209082112040.18369@frira.zrqbmnf.qr>
References: <1347124173-14460-1-git-send-email-jengelh@inai.de> <7v627ouyun.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 21:19:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAQZM-0000Zt-UD
	for gcvg-git-2@plane.gmane.org; Sat, 08 Sep 2012 21:19:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694Ab2IHTS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Sep 2012 15:18:59 -0400
Received: from seven.inai.de ([5.9.24.206]:40942 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174Ab2IHTS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2012 15:18:59 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id DA10F96A11C6; Sat,  8 Sep 2012 21:18:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id A35AD96A1084;
	Sat,  8 Sep 2012 21:18:56 +0200 (CEST)
In-Reply-To: <7v627ouyun.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205029>

On Saturday 2012-09-08 20:57, Junio C Hamano wrote:

>Please don't throw a pull request for a patch whose worth hasn't
>been justified in a discussion on the list.  Thanks.

Let me postulate that people like to get cover letters with the
git:// URL so they can fetch+look at it, a diffstat and shortlog.

And 'lo, that is exactly what git-request-pull thankfully generates.

In my defense: Just because the command is called "request-pull",
does not mean you absolutely have to merge/pull it. In fact, it does
not even mention merge/pull at all.

"
The following changes since commit [SHA]:
  [Commit Message]
are available in the git repository at:
  git://[...]
for you to fetch changes up to [SHA]:
  [Commit Message]
[diffstat,shortlog]
"

In contrast to many a LKML postings which explicitly state the pull
intent:

"
Hi [Maintainer],

Please pull from the git repository at
  [URL]
to receive [...]
  [SHA]
  [Commit Message]
on top of commit [SHA]
  [Commit Message]
[diffstat,shortlog]
"
