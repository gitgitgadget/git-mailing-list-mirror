From: "MichaelTiloDressel@t-online.de" <MichaelTiloDressel@t-online.de>
Subject: cogito remote branch
Date: Fri, 09 Nov 2007 14:16:47 +0100
Message-ID: <1IqTj5-24rt3I0@fwd33.aul.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 14:17:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqTjZ-0006ks-Gk
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:17:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757856AbXKINRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 08:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757092AbXKINRB
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:17:01 -0500
Received: from mailout10.sul.t-online.de ([194.25.134.21]:47881 "EHLO
	mailout10.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754494AbXKINRA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Nov 2007 08:17:00 -0500
Received: from fwd33.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1IqTjG-0004Uo-00; Fri, 09 Nov 2007 14:16:58 +0100
Received: from localhost (JbOVq6Z18hnPpDKaZ6rdnj9-NIng2CVqcw7KZ1mjpcApIYcyLFGRky8-3PBdemNglO@[172.20.101.250]) by fwd33.aul.t-online.de
	with esmtp id 1IqTj5-24rt3I0; Fri, 9 Nov 2007 14:16:47 +0100
X-UMS: email
X-Mailer: TOI Kommunikationscenter V9-0-8
X-ID: JbOVq6Z18hnPpDKaZ6rdnj9-NIng2CVqcw7KZ1mjpcApIYcyLFGRky8-3PBdemNglO@t-dialin.net
X-TOI-MSGID: cf25fba5-1e82-484e-93dc-134166c073c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64174>

Hi,

I just saw the scripts cg-update, cg-push ..  scripts try to guess a
branch name functioning as origin if no argument is given. These scripts
seam to use a branch named <branchname>-origin if it exists and the
current
branch is named <branchname> and is not the branch named master.

I like that feature. Is it anywhere documented?

In case there is no branch named <branchname>-origin the scripts just
use origin even if the current branch is not master. I would prefer the
scripts to fail in this case and to print a message asking the user to
specifically name a branch.

Cheers,
Michael
