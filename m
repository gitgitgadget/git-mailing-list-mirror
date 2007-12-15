From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git-send-email doesn't like me+git ML
Date: Sat, 15 Dec 2007 00:20:23 -0500
Message-ID: <20071215052023.GB9118@fawkes>
References: <20071214014753.GB8914@fawkes> <476244C5.2090205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Sat Dec 15 06:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3PSK-0005jG-OK
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 06:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbXLOFUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 00:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbXLOFUb
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 00:20:31 -0500
Received: from k2smtpout01-02.prod.mesa1.secureserver.net ([64.202.189.89]:51493
	"HELO k2smtpout01-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750811AbXLOFUa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 00:20:30 -0500
Received: (qmail 4733 invoked from network); 15 Dec 2007 05:20:30 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout01-02.prod.mesa1.secureserver.net (64.202.189.89) with ESMTP; 15 Dec 2007 05:20:30 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 63230100B60;
	Sat, 15 Dec 2007 05:20:30 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WXMgqhmJYTE7; Sat, 15 Dec 2007 00:20:24 -0500 (EST)
Received: from fawkes.hq.digizenstudio.com (ip70-187-196-88.dc.dc.cox.net [70.187.196.88])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 1E3EF100A37;
	Sat, 15 Dec 2007 00:20:24 -0500 (EST)
Received: by fawkes.hq.digizenstudio.com (Postfix, from userid 1000)
	id 5D37E9ACFB; Sat, 15 Dec 2007 00:20:23 -0500 (EST)
Mail-Followup-To: Andreas Ericsson <ae@op5.se>, git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <476244C5.2090205@op5.se>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68375>

On Fri, Dec 14, 2007 at 09:54:29AM +0100, Andreas Ericsson wrote:
>
> I've had similar problems. I think it's actually a filtering issue on the
> receiving end though, as some seem to see the mails on the list (while
> most don't). Looking at the headers, I see the hostname of my laptop as
> originating host when using git-send-email, which obviously will fail
> for any receiving host that tries to connect back to verify that the
> originating sender is indeed a real SMTP server.

Quite possibly so. What puzzles me is that when I compare the headers
between the one I sent from mutt (which made it to the list) and the one
from send-email (which made it to gmail), I can't find any differences
(other than message ids and timestamps of course).

Ah well...
-- 
Jing Xue
