From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Add completion for 'git grep'
Date: Mon, 4 Aug 2008 07:52:10 -0700
Message-ID: <20080804145210.GD27666@spearce.org>
References: <20080804040634.GC2963@spearce.org> <1217827608-5143-1-git-send-email-lee.marlow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Lee Marlow <lee.marlow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:53:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1Qw-0007tI-6r
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107AbYHDOwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 10:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753701AbYHDOwL
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:52:11 -0400
Received: from george.spearce.org ([209.20.77.23]:38619 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056AbYHDOwL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 10:52:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9569038420; Mon,  4 Aug 2008 14:52:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1217827608-5143-1-git-send-email-lee.marlow@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91366>

Lee Marlow <lee.marlow@gmail.com> wrote:
> This updated patch removes the __git_has_doublehash line.  However, I
> just noticed that d773c631 added __git_has_doublehash to prevent
> completions of long options after --.  So, maybe it's not too
> redundant and my first patch might be better.

Heh.  I forgot about that.  You're right, your first patch is better.

-- 
Shawn.
