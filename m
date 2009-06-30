From: Unknown <borg@uu3.net>
Subject: Re: [PATCH] git status -q (similar to subversion)
Date: Tue, 30 Jun 2009 18:56:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0906301854320.17614@cube>
References: <Pine.LNX.4.64.0906272248570.11453@cube> <20090628224447.GB1951@gmail.com>
 <Pine.LNX.4.64.0906292131330.27727@cube> <20090630053325.GC29643@sigio.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:57:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLgdj-0003eM-Nk
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 18:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbZF3Q4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 12:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbZF3Q4w
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 12:56:52 -0400
Received: from borg.uu3.net ([87.99.63.19]:49911 "EHLO borg.uu3.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbZF3Q4w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 12:56:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by borg.uu3.net (Postfix) with ESMTP
	id 0C662633D1; Tue, 30 Jun 2009 18:56:54 +0200 (CEST)
X-X-Sender: borg@cube
In-Reply-To: <20090630053325.GC29643@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122523>

On Tue, 30 Jun 2009, Jeff King wrote:
> It exists, but is called showUntrackedFiles. See "git help config" for
> details.
Its not what I meant. showUntrackedFiles is used when you do not specify 
'-u' option. showUnrackedDefault (not so good name, someone have better 
idea?) would be used if you specify '-u' option without argument.
Currently argument 'all' is used.

-- 
Borg
