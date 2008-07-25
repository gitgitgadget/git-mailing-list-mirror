From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 2/2] editor.c: Libify launch_editor()
Date: Fri, 25 Jul 2008 19:16:12 +0200
Message-ID: <20080725171612.GF27172@leksak.fem-net>
References: <alpine.DEB.1.00.0807251636140.11976@eeepc-johanness> <1217003322-10291-1-git-send-email-s-beyer@gmx.net> <1217003322-10291-2-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 19:17:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMQuv-0005Dp-RU
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 19:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbYGYRQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 13:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbYGYRQW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 13:16:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:36458 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750974AbYGYRQV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 13:16:21 -0400
Received: (qmail invoked by alias); 25 Jul 2008 17:16:20 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp020) with SMTP; 25 Jul 2008 19:16:20 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18SC5h0k/ASY2piwjxsI1BUG2wYvP4nYN6xjCobd6
	JreslQDZyYc5hl
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KMQto-0001kw-Dx; Fri, 25 Jul 2008 19:16:12 +0200
Content-Disposition: inline
In-Reply-To: <1217003322-10291-2-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90076>

Hi,

Stephan Beyer wrote:
> This patch removes exit()/die() calls and builtin-specific messages
> from launch_editor(), so that it can be used as a general libgit.a
> function to launch an editor.
> 
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
>  builtin-commit.c |    6 +++++-
>  builtin-tag.c    |    6 +++++-
>  editor.c         |   24 ++++++++++++------------
>  foo              |    1 +

Ouch! Please exclude "foo"...
Sorry, for this maintainer-unfriendly patch again. *embarrassed*

Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
