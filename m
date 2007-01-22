From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: commit message columns
Date: Mon, 22 Jan 2007 23:19:27 +0100
Message-ID: <20070122221927.GA3746@moooo.ath.cx>
References: <20070122211902.GC6614@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 23:19:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H97Vn-0002J3-Bw
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 23:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbXAVWTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 17:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751744AbXAVWTc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 17:19:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:49368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751723AbXAVWTb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 17:19:31 -0500
Received: (qmail invoked by alias); 22 Jan 2007 22:19:29 -0000
Received: from pD9EBA6EE.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.166.238]
  by mail.gmx.net (mp044) with SMTP; 22 Jan 2007 23:19:29 +0100
X-Authenticated: #5358227
To: "J. Bruce Fields" <bfields@fieldses.org>
Mail-Followup-To: "J. Bruce Fields" <bfields@fieldses.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070122211902.GC6614@fieldses.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37462>

J. Bruce Fields <bfields@fieldses.org> wrote:
> Uh, I feel like I must be missing something simple here--when editing
> commit messages, you'd like the editor (vim in my case) to wrap text
> sooner than it normally would, since commit messages are displayed
> indented.  What's the easiest way to ensure this always happens?

You could add this to your .vimrc:
> autocmd BufNewFile,BufRead .git/COMMIT_EDITMSG setlocal tw=60 ft=human
Has anyone a good filetype for this?
