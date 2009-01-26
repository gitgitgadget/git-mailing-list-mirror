From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: rerere: how to remove an erroneous resolution?
Date: Mon, 26 Jan 2009 15:42:39 +0100
Message-ID: <20090126144239.GA494@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 15:45:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRShE-0001g5-FC
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 15:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbZAZOmo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jan 2009 09:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbZAZOmo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 09:42:44 -0500
Received: from francis.fzi.de ([141.21.7.5]:59673 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751431AbZAZOmn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 09:42:43 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 15:42:39 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 26 Jan 2009 14:42:39.0093 (UTC) FILETIME=[560F4A50:01C97FC4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107215>

Hi,

some time ago I mistakenly resolved a merge conflict incorrectly.  Of
course, rerere noted the erroneous conflict resolution, and whenever
the same merge conflict occurs rerere offers me that erroneous
conflict resolution, even though I correct it each time.

So, the question is how could I make rerere forget that particular
merge conflict resolution?  Is it at all possible?


Thanks,
G=E1bor
