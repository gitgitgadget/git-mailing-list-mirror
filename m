From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH 0/4] Move git-p4import into contrib directory.
Date: Sun, 15 Jul 2007 15:48:04 -0400
Message-ID: <20070715154804.2877361d.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 15 21:50:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAA6v-0006rG-1m
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 21:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbXGOTu0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 15:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbXGOTu0
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 15:50:26 -0400
Received: from bay0-omc3-s17.bay0.hotmail.com ([65.54.246.217]:53194 "EHLO
	bay0-omc3-s17.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750832AbXGOTuZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 15:50:25 -0400
Received: from BAYC1-PASMTP13.bayc1.hotmail.com ([65.54.191.186]) by bay0-omc3-s17.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 12:50:24 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP13.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 12:50:54 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IAA6p-00015U-7c
	for git@vger.kernel.org; Sun, 15 Jul 2007 15:50:23 -0400
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 15 Jul 2007 19:50:55.0141 (UTC) FILETIME=[74D27D50:01C7C719]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52580>


Hi Junio,

Having caught up on some list emails, it appears that Git now has a
much better option for importing from Perforce in the git-p4 front
end to fast-import.

Is there anyone out there actually even using git-p4import?  It was
written for a very specific case, by a git wannabe hacker who had
never used Perforce before, and not intended for inclusion in Git
proper...

My guess is that it could be removed outright without pain to anyone,
but as a first step, it could be moved into contrib for 1.5.3.

Sean
