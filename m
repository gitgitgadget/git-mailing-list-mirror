From: Jean Delvare <khali@linux-fr.org>
Subject: [feature request] git: tags instead of commit IDs in blame output
Date: Sat, 21 Aug 2010 09:53:52 +0200
Message-ID: <20100821095352.604a2b85@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 09:54:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omitw-0002SA-CE
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 09:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab0HUHyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 03:54:00 -0400
Received: from zone0.gcu-squad.org ([212.85.147.21]:30097 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0HUHx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 03:53:59 -0400
Received: from jdelvare.pck.nerim.net ([62.212.121.182] helo=hyperion.delvare)
	by services.gcu-squad.org (GCU Mailer Daemon) with esmtpsa id 1Omisp-0002VF-7Z
	(TLSv1:AES256-SHA:256)
	(envelope-from <khali@linux-fr.org>)
	for git@vger.kernel.org; Sat, 21 Aug 2010 09:52:55 +0200
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154121>

Hi there,

I have a feature request for git. In the output of "git blame", I would
like to be able to see tags instead of commit IDs in front of each
line. Basically, I would like to know the first tag which was added
after the last change of every line. Icing on the cake would be the
possibility to filter out some tags (for example to ignore release
candidate tags) but I could easily live without that.

Does it make sense?
Would it be difficult to implement?

At the moment I am using a custom tool when I need to see this output,
but being backed-up by quilt, it's quite slow and disk-consuming. I
would love to be able to get rid of it and use only git.

Thanks,
-- 
Jean Delvare
