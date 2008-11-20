From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [TopGit PATCH] Print help message when command is not proper
Date: Thu, 20 Nov 2008 14:18:07 +0100
Message-ID: <20081120131807.GE10491@machine.or.cz>
References: <1227182928-24916-1-git-send-email-madduck@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "martin f. krafft" <madduck@debian.org>
X-From: git-owner@vger.kernel.org Thu Nov 20 14:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L39Rc-0002Cq-Up
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 14:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYKTNSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 08:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755389AbYKTNSL
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 08:18:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:58098 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755246AbYKTNSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 08:18:09 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4C8CF393984F; Thu, 20 Nov 2008 14:18:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1227182928-24916-1-git-send-email-madduck@debian.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101424>

On Thu, Nov 20, 2008 at 01:08:48PM +0100, martin f. krafft wrote:
> When invoked with an unknown subcommand, or when --help is sought for
> a command that does not exist, TopGit prints the help message.
> 
> Signed-off-by: martin f. krafft <madduck@debian.org>

Acked-by: Petr Baudis <pasky@suse.cz>

Note that I think these changes are reasonable only as long as do_help
is just a short two-line usage help; in the event we also implement a
longer help, it certainly shouldn't be printed in these cases.
