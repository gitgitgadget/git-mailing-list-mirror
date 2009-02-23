From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Create leading directories in create-ignore
Date: Sun, 22 Feb 2009 20:34:56 -0800
Message-ID: <20090223043456.GB21136@dcvr.yhbt.net>
References: <1235066884-56575-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 05:36:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbSYN-0003w6-3p
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 05:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbZBWEe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 23:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbZBWEe5
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 23:34:57 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50911 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523AbZBWEe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 23:34:57 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82341F5FC;
	Mon, 23 Feb 2009 04:34:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1235066884-56575-1-git-send-email-benji@silverinsanity.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111080>

Brian Gernhardt <benji@silverinsanity.com> wrote:
> Since SVN tracks empty directories and git does not, we can not assume
> that the directory exists when creating .gitignore files.
> 
> Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>

Thanks Brian, applied with minor line wrapping adjustment
and pushed out to:

  git://git.bogomips.org/git-svn

-- 
Eric Wong
