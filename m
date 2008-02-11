From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Fix --unset for continuation lines
Date: Mon, 11 Feb 2008 01:14:45 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802110114220.3870@racer.site>
References: <1202689383-9450-1-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 02:15:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JONGP-0006v9-5X
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 02:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360AbYBKBOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 20:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbYBKBOl
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 20:14:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:37267 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbYBKBOl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 20:14:41 -0500
Received: (qmail invoked by alias); 11 Feb 2008 01:14:38 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp025) with SMTP; 11 Feb 2008 02:14:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PHw9n9d1PK8ZiA+zDv3RAt1hrr5owiyogW+eKwl
	me+ifFqLpQNjk1
X-X-Sender: gene099@racer.site
In-Reply-To: <1202689383-9450-1-git-send-email-frank@lichtenheld.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73446>

Hi,

On Mon, 11 Feb 2008, Frank Lichtenheld wrote:

> find_beginning_of_line didn't take into account that the previous line 
> might have ended with \ in which case it shouldn't stop but continue its 
> search.

Good catch.

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
