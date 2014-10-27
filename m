From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Editing git changelog automatically
Date: Mon, 27 Oct 2014 19:58:51 +0100
Message-ID: <87zjch9w5w.fsf@igel.home>
References: <CAM_iQpWNQbv_GTT+H5KNCqqRS3qWfBuBge4+ZTAS_WiaREku4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Cong Wang <xiyou.wangcong@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 19:59:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XipVM-0001Iq-Ah
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 19:59:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbaJ0S64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 14:58:56 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52900 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbaJ0S6z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 14:58:55 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jRQLj17XFz3hjH2;
	Mon, 27 Oct 2014 19:58:53 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jRQLj0dCNzvjDv;
	Mon, 27 Oct 2014 19:58:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id coSbQVlQOEgN; Mon, 27 Oct 2014 19:58:52 +0100 (CET)
X-Auth-Info: GO9M7rU65kbigoVDeszgCIxQJwH5qtsz1JRe+NIJYqEvMphv0WdaGnuObpG7/o1d
Received: from igel.home (ppp-93-104-153-35.dynamic.mnet-online.de [93.104.153.35])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon, 27 Oct 2014 19:58:52 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 1716B2C37A8; Mon, 27 Oct 2014 19:58:52 +0100 (CET)
X-Yow: I am having FUN...  I wonder if it's NET FUN or GROSS FUN?
In-Reply-To: <CAM_iQpWNQbv_GTT+H5KNCqqRS3qWfBuBge4+ZTAS_WiaREku4w@mail.gmail.com>
	(Cong Wang's message of "Sun, 26 Oct 2014 22:27:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Cong Wang <xiyou.wangcong@gmail.com> writes:

> Let's say I want to fix a stupid typo in all of these commits, as
> simply as s/foo/bar/. Usually I use`git rebase -i` and `git commit
> --amend`, but both of them are interactive, apparently I don't want to
> edit them one by one. :)

Both can be scripted, though.

> I know I can change $EDITOR to something like `sed -e 's/foo/bar/'`,
> but this seems pretty ugly. Is there a clean way to do that?

I don't see the ugliness.  There is no requirement that $EDITOR is
interactive.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
