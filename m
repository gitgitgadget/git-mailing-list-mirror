From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] show alias definitions in help
Date: Sun, 24 Feb 2008 17:23:31 -0500
Message-ID: <20080224222331.GA6712@coredump.intra.peff.net>
References: <20080224221559.GA31309@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:24:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTPGU-0004dc-NT
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 23:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802AbYBXWXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 17:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbYBXWXf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 17:23:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4106 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbYBXWXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 17:23:34 -0500
Received: (qmail 2449 invoked by uid 111); 24 Feb 2008 22:23:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Feb 2008 17:23:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Feb 2008 17:23:31 -0500
Content-Disposition: inline
In-Reply-To: <20080224221559.GA31309@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74971>

On Sun, Feb 24, 2008 at 05:16:00PM -0500, Jeff King wrote:

>  Makefile |    3 +-
>  alias.c  |   22 +++++++++
>  cache.h  |    2 +
>  git.c    |   17 +------
>  help.c   |  152 ++++++++++++++++++++++++++++++++++++--------------------
>  5 files changed, 118 insertions(+), 78 deletions(-)
>  create mode 100644 alias.c

BTW, Daniel, I have used your --cover-letter work several times today,
and it is terrific. It has saved me a lot of error-prone cutting and
pasting of message-ids and commit titles. Thanks.

-Peff
