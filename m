From: Sam Ravnborg <sam@ravnborg.org>
Subject: git reset --hard include/linux/config.h
Date: Wed, 5 Jul 2006 18:58:01 +0200
Message-ID: <20060705165801.GA11822@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 05 18:59:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyAhw-0004gQ-3G
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 18:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWGEQ6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 12:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964893AbWGEQ6c
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 12:58:32 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:59878 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964896AbWGEQ6b (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 12:58:31 -0400
Received: from mars.ravnborg.org (0x535d98d8.hrnxx9.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtp.tele.dk (Postfix) with ESMTP id 98C86800F26
	for <git@vger.kernel.org>; Wed,  5 Jul 2006 18:58:30 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 9726543C01E; Wed,  5 Jul 2006 18:58:01 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23355>

While working on something unrelated I just did a quick hack
in include/linux/config.h
When done I wanted to get rid of the changes so I did:
git reset --hard include/linux/config.h

And the changes made to include/linux/config.h was indeed gone, with
all the other changes I had in other files.

Now git reset is maybe supposed to work on commit level only, but it
would have been nice if it erroroed out when it saw an argument that
it did not know about. In this case I assume git reset used
"include/linux/config.h" as <commitish>.

Also what is the right command to bring back a file to the original
state after doing some modifications that was not needed anyway?

	Sam
