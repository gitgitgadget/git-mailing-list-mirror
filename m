From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] gitk: UTF-8 support
Date: Thu, 24 Nov 2005 02:12:31 -0500
Message-ID: <20051124021231.nrg8448gk8w4owk8@webmail.spamcop.net>
References: <1132719301.12227.5.camel@dv>
	<7v64qi50sw.fsf@assigned-by-dhcp.cox.net>
	<20051123235315.oht0zjidc4ccg8gs@webmail.spamcop.net>
	<7v1x16y36r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 08:12:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfBHb-00034f-Sg
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 08:12:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVKXHMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 02:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVKXHMd
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 02:12:33 -0500
Received: from mailgate.cesmail.net ([216.154.195.36]:26831 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP
	id S1750809AbVKXHMd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 02:12:33 -0500
Received: (qmail 29508 invoked from network); 24 Nov 2005 07:12:32 -0000
Received: from unknown (HELO gamma.cesmail.net) (192.168.1.20)
  by mailgate.cesmail.net with SMTP; 24 Nov 2005 07:12:32 -0000
Received: (qmail 18779 invoked by uid 99); 24 Nov 2005 07:12:31 -0000
Received: from static-68-161-241-229.ny325.east.verizon.net
	(static-68-161-241-229.ny325.east.verizon.net [68.161.241.229]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Thu, 24 Nov 2005 02:12:31 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x16y36r.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12680>

Quoting Junio C Hamano <junkio@cox.net>:

> That is not the point.  Point is that I think the user can use
> LANG and LC_ALL (I suspect LC_CTYPE is what matters) to get what
> you want, and I suspect hardcoding utf8 robs users the
> possibility to deal with a repository that uses something else.

Not to argue with you, but it's worth pointing out that git is heavily multiuser
software, and interoperability should not be ranked below local configurability.

> And as I suggested in another message (in the died-out thread
> about gitweb), we could have i18n.commitEncoding in the
> configuration to help gitk and gitweb.  I think that is the same
> as your "other option".

Yes.  Then my patch needs to be changed to set encoding to that setting and only
if it's present.

--
Regards,
Pavel Roskin
