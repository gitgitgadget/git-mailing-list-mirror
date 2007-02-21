From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] git-remote: support remotes with a dot in the name
Date: Wed, 21 Feb 2007 02:12:06 -0500
Message-ID: <20070221021206.8onspw0840gcs8ck@webmail.spamcop.net>
References: <20070221050336.26431.46485.stgit@dv.roinet.com>
	<7vwt2ct79x.fsf@assigned-by-dhcp.cox.net>
	<20070221004631.q4npyww808k88s0o@webmail.spamcop.net>
	<7vfy90t4mo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 21 08:12:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJleH-0001O3-Mx
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 08:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbXBUHMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 02:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932765AbXBUHMJ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 02:12:09 -0500
Received: from mailgate.cesmail.net ([216.154.195.36]:36652 "HELO
	mailgate.cesmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932367AbXBUHMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 02:12:08 -0500
Received: (qmail 5387 invoked from network); 21 Feb 2007 07:12:06 -0000
Received: from unknown (HELO gamma.cesmail.net) (192.168.1.20)
  by mailgate.cesmail.net with SMTP; 21 Feb 2007 07:12:06 -0000
Received: (qmail 24227 invoked by uid 99); 21 Feb 2007 07:12:06 -0000
Received: from c-71-230-131-166.hsd1.pa.comcast.net
	(c-71-230-131-166.hsd1.pa.comcast.net [71.230.131.166]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Wed, 21 Feb 2007 02:12:06 -0500
In-Reply-To: <7vfy90t4mo.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40285>

Quoting Junio C Hamano <junkio@cox.net>:

> Do you mean:
>
> 	[remote "wireless-2.6.url"]
> 		url = wire.less:/repo/sito/ry.git
>         	fetch = +refs/heads/*:refs/remotes/wireless-2.6.url/*

I was thinking of something like

[remote "wireless-2.6"]
url = http://foo/bar
url.push = ssh://foo/bar

But I think it's quite unlikely to be named like that.

> But my Perl is rusty, so please double check it.

The "(\S*?)" construct looks weird (you probably meant to use "(\S*)" for the
remote name), but the rest is probably OK.  I'll send the "double-checked"
patch tomorrow unless you beat me at that.

--
Regards,
Pavel Roskin
