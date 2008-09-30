From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Implement a 'clone' subcommand
Date: Tue, 30 Sep 2008 12:53:30 -0700
Message-ID: <20080930195330.GA4413@spearce.org>
References: <1222793501-17997-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Petr Baudis <petr.baudis@novartis.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 30 21:54:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KklIw-00014Z-3X
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 21:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYI3Txb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 15:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753337AbYI3Txb
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 15:53:31 -0400
Received: from george.spearce.org ([209.20.77.23]:38266 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbYI3Txa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 15:53:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1899938360; Tue, 30 Sep 2008 19:53:30 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222793501-17997-1-git-send-email-pasky@suse.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97150>

Petr Baudis <pasky@suse.cz> wrote:
> This enables git-gui to be started with the clone dialog opened right
> away, possibly with the URL prefilled when it is passed as another
> argument. git-gui can then be e.g. registered as the git:// protocol
> handler.
> 
> This is just a simple implementation - we construct the front actions
> page, then throw it away immediately; I wanted to avoid unnecessary
> refactoring and complication of the code, though.
> 
> Signed-off-by: Petr Baudis <petr.baudis@novartis.com>
> 
> ---
>  Documentation/git-gui.txt         |    5 +++++
>  git-gui/git-gui.sh                |   21 ++++++++++++++++++---
>  git-gui/lib/choose_repository.tcl |   11 ++++++++++-
>  3 files changed, 33 insertions(+), 4 deletions(-)

This looks fine, except for the diffstat.  You can't patch
the docs and the code in the same patch as they are in two
different repositories...  :-|

Also, I don't know if you've noticed but I think tg is
sending duplicate "To" headers in the messages:

	From: Petr Baudis <pasky@suse.cz>
*	To: git@vger.kernel.org
	Cc: spearce@spearce.org, Petr Baudis <petr.baudis@novartis.com>
	Subject: [PATCH] git-gui: Implement a 'clone' subcommand
	Date: Tue, 30 Sep 2008 18:51:41 +0200
	Message-Id: <1222793501-17997-1-git-send-email-pasky@suse.cz>
	X-Mailer: git-send-email 1.5.6.3.392.g292f1
*	To: git@vger.kernel.org
	Sender: git-owner@vger.kernel.org
	Precedence: bulk
	List-ID: <git.vger.kernel.org>
	X-Mailing-List: git@vger.kernel.org
 
-- 
Shawn.
