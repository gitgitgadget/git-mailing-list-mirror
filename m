From: linux@horizon.com
Subject: As long as you're hacking on git-daemon...
Date: 13 Jul 2006 16:12:48 -0400
Message-ID: <20060713201248.25353.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 22:13:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G17YO-0001UK-N4
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 22:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWGMUMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 16:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030348AbWGMUMy
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 16:12:54 -0400
Received: from science.horizon.com ([192.35.100.1]:2605 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030344AbWGMUMx
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 16:12:53 -0400
Received: (qmail 25354 invoked by uid 1000); 13 Jul 2006 16:12:48 -0400
To: matled@gmx.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23846>

Is it possible to make it capable of running from /etc/inetd.conf?
That's nicer for little-used personal servers, and also nicer if you
want to use tcp wrappers or one of the inetd replacements that
offers sophisticated load control.  (Refuse connections if
load average is too high, different nice level for internal vs.
external clients, etc. etc.)

Thanks.
