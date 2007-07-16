From: bdowning@lavos.net (Brian Downing)
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it ispossible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 10:50:28 -0500
Message-ID: <20070716155028.GE19073@lavos.net>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de> <20070716134529.GC26675@cip.informatik.uni-erlangen.de> <469B821E.85E5EDA9@eudaptics.com> <20070716154559.GD19073@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 17:51:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IASqi-0007wc-C7
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 17:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760680AbXGPPuj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 11:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754331AbXGPPui
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 11:50:38 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:4488 "EHLO
	asav06.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760684AbXGPPui (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 11:50:38 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav06.insightbb.com with ESMTP; 16 Jul 2007 11:50:37 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AigcAEgwm0ZKhvbzRmdsb2JhbACBSI1rAQEBNQ
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 7A313309F31; Mon, 16 Jul 2007 10:50:28 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20070716154559.GD19073@lavos.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52680>

On Mon, Jul 16, 2007 at 10:45:59AM -0500, Brian Downing wrote:
> http://www.opengroup.org/onlinepubs/007908799/xsh/unlink.html
> 
> | The path argument must not name a directory unless the process has
> | appropriate privileges and the implementation supports using unlink() on
> | directories.
> 
> The above seems to imply that implementations are free to do something
> with directories passed to unlink, and that it is the responsibility
> if the user not to do that unless they know what is going to happen.

Also, the HISTORY section of the FreeBSD manpages states:

| The unlink system call traditionally allows the super-user to unlink
| directories which can damage the filesystem integrity. This
| implementation no longer permits it.

Great.

-bcd
