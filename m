From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 0/4] add pre-auto-gc hook for git-gc --auto
Date: Mon, 31 Mar 2008 11:35:27 +0200
Message-ID: <cover.1206929014.git.vmiklos@frugalware.org>
References: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bj?rn Steinbrink <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 11:36:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgGR4-0002du-Ba
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 11:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886AbYCaJfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 05:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754856AbYCaJfb
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 05:35:31 -0400
Received: from virgo.iok.hu ([193.202.89.103]:11251 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754739AbYCaJfb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 05:35:31 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 246561B2586;
	Mon, 31 Mar 2008 11:35:28 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 845AB44696;
	Mon, 31 Mar 2008 11:32:19 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 9574F1190547; Mon, 31 Mar 2008 11:35:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803301645020.14670@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78574>

On Sun, Mar 30, 2008 at 04:46:51PM -0700, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> How about making it more akin to a pre-auto-gc "hook" - run a script
> instead of hardcoding something like this!

Something like this?

Miklos Vajna (4):
  git-gc --auto: add pre-auto-gc hook
  git-gc: add a --no-verify option to bypass the pre-auto-gc hook
  Documentation/hooks: add pre-auto-gc hook
  templates: add an example pre-auto-gc hook

 Documentation/git-gc.txt     |    4 ++++
 Documentation/hooks.txt      |   10 ++++++++++
 builtin-gc.c                 |   24 ++++++++++++++++++++++++
 templates/hooks--pre-auto-gc |   29 +++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 0 deletions(-)
 create mode 100644 templates/hooks--pre-auto-gc
