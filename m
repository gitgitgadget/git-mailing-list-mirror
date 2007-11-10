From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified
 submodules.
Date: Sat, 10 Nov 2007 20:55:09 +0100
Message-ID: <20071110195509.GI2261MdfPADPa@greensroom.kotnet.org>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqwQy-0001AV-90
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 20:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753793AbXKJTzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 14:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbXKJTzM
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 14:55:12 -0500
Received: from psmtp09.wxs.nl ([195.121.247.23]:64236 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604AbXKJTzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 14:55:11 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JRB000B23BY7W@psmtp09.wxs.nl> for git@vger.kernel.org; Sat,
 10 Nov 2007 20:55:10 +0100 (MET)
Received: (qmail 14158 invoked by uid 500); Sat, 10 Nov 2007 19:55:10 +0000
In-reply-to: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64372>

On Sun, Nov 11, 2007 at 03:27:43AM +0800, Ping Yin wrote:
> This commit teaches git status/commit to also show commits of user-cared

Does it?  It looks like you only changed git-commit.
Shouldn't this be put in wt_status_print, if anywhere?

Also, you have some typos:

> +	test -n "$modules" && echo -e "#\n# submodule modifiled: "$modules"\n#"
[..]
> +				echo "  Warn: $name dosn't contains commit $headone"

skimo
