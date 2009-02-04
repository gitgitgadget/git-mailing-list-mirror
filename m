From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git gtk+/GNOME gui application: gitg
Date: Wed, 04 Feb 2009 15:29:15 +0100
Message-ID: <4989A63B.4030103@drmicha.warpmail.net>
References: <1233432317.26364.5.camel@wren>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jesse van den Kieboom <jesse@icecrew.nl>
X-From: git-owner@vger.kernel.org Wed Feb 04 15:31:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUimN-0000X5-M5
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 15:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbZBDO3W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 09:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752126AbZBDO3W
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 09:29:22 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:32959 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751472AbZBDO3V (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Feb 2009 09:29:21 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 3EF6E27E6A6;
	Wed,  4 Feb 2009 09:29:20 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 04 Feb 2009 09:29:20 -0500
X-Sasl-enc: WhNYWguS2MTRLf+lY2IwNmknJ4tTB1dAkpoMg3UFg44r 1233757759
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8C0573AC44;
	Wed,  4 Feb 2009 09:29:19 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <1233432317.26364.5.camel@wren>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108365>

Jesse van den Kieboom venit, vidit, dixit 31.01.2009 21:05:
> Hi,
> 
> I have been developing a gui application for git for gtk+/GNOME based on
> GitX (which in turn is based on gitk). I feel that it's reaching the
> point where it might potentially be useful for other people to use. It
> currently features:
> 
> - Loading large repositories very fast
> - Show/browse repository history
> - Show highlighted revision diff
> - Browse file tree of a revision and export by drag and drop
> - Search in the revision history on subject, author or hash
> - Switch between history view of branches easily
> - Commit view providing per hunk stage/unstage and commit
> 
> The project is currently hosted on github:
> http://github.com/jessevdk/gitg
> 
> clone: git://github.com/jessevdk/gitg.git
> 
> Please let me know what you think,

OK, played with it, looks nice. Some feedback:

Bug:?
After unstaged a staged file it does not reappear under "unstaged". It
appears nowhere.

Build:
gitg can't run from the build dir, it needs to be installed.
Reconfiguring with different --prefix does not rebuild (one needs to
make clean manually).

Features:
Displaying the subject after the parent shas etc would be nice.
Maybe forward/back buttons for taking you forward/back in your *browsing
history*? Say, you click on a parent, and then you want to get back.
Can one stage hunks somehow?

Cheers,
Michael
