From: Rutger Nijlunsing <rutger@nospam.com>
Subject: gitk: bug report: invalid command name "contmergediff"
Date: Wed, 8 Mar 2006 19:37:18 +0100
Organization: M38c
Message-ID: <20060308183718.GA9855@nospam.com>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Mar 08 19:39:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FH3XJ-0004Kj-Uw
	for gcvg-git@gmane.org; Wed, 08 Mar 2006 19:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWCHShW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 13:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWCHShW
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 13:37:22 -0500
Received: from post-22.mail.nl.demon.net ([194.159.73.192]:61432 "EHLO
	post-22.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S932268AbWCHShV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 13:37:21 -0500
Received: from wingding.demon.nl ([82.161.27.36]:35967)
	by post-22.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FH3XC-000Dm0-Gu
	for git@vger.kernel.org; Wed, 08 Mar 2006 18:37:18 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FH3XC-0002k6-9G
	for git@vger.kernel.org; Wed, 08 Mar 2006 19:37:18 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17381>

Bug report on gitk, maybe already reported.

do:
   gitk HEAD~1000..

...select first commit (why is this not done automatically?), and keep
pressing down-arrow.

This gives me:
   Error: invalid command name "contmergediff"
with detail window:
   invalid command name "contmergediff"
   invalid command name "contmergediff"
       while executing
   "contmergediff $ids"
       (procedure "gettreediffline" line 14)
       invoked from within
   "gettreediffline file7 de84f99c12d1819479116685393afb1ebe99810b"


-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
