From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix git rebase --continue to work with touched files
Date: Tue, 27 Jul 2010 12:16:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1007271215420.2983@bonsai2>
References: <1280225198-4539-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Tue Jul 27 12:16:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdhCy-0002iE-ML
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 12:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755746Ab0G0KQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 06:16:07 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:39159 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754108Ab0G0KQG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 06:16:06 -0400
Received: (qmail invoked by alias); 27 Jul 2010 10:16:02 -0000
Received: from pD9EB1EF1.dip0.t-ipconnect.de (EHLO noname) [217.235.30.241]
  by mail.gmx.net (mp064) with SMTP; 27 Jul 2010 12:16:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jpABoqeSjQIOAhXdW/1sMKXOhRHGZZOEeLZ08ZN
	WL1wMYMvuMWtZJ
X-X-Sender: gene099@bonsai2
In-Reply-To: <1280225198-4539-1-git-send-email-ddkilzer@kilzer.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151924>

Hi,

On Tue, 27 Jul 2010, David D. Kilzer wrote:

> When performing a non-interactive rebase, sometimes
> "git rebase --continue" will fail if an unmodified file is
> touched in the working directory:
> 
>     You must edit all merge conflicts and then
>     mark them as resolved using git add
> 
> This is caused by "git diff-files" reporting a difference
> between the index and the filesystem:
> 
>     :100644 100644 d00491...... 000000...... M	file
> 
> The fix is to run "git update-index --refresh" before
> "git diff-files" as is done in git-rebase--interactive.
> 
> Signed-off-by: David D. Kilzer <ddkilzer@kilzer.net>

ACK!

... and thanks!
Dscho
