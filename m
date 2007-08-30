From: Peter Baumann <waste.manager@gmx.de>
Subject: [StGit] How do I get colored diff output?
Date: Thu, 30 Aug 2007 14:32:22 +0200
Message-ID: <20070830123222.GG5050@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 14:33:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQjCo-0002EV-Vq
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 14:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbXH3Mc5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 08:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752720AbXH3Mc4
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 08:32:56 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:36108 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752462AbXH3Mc4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Aug 2007 08:32:56 -0400
Received: (qmail 32393 invoked by uid 0); 30 Aug 2007 12:32:53 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 30 Aug 2007 12:32:53 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57035>

Hi,

Is there a way to get colored diff output, preferable from the native
git diff without having to specify stg diff -O --color everytime?
It seems that stg doesn't honor color.diff config entry, so I am a
little lost.

(And yes I now that I could use the pager setting given in examples/gitconfig,

	stgit.pager = filterdiff --annotate | colordiff | less -FRX

 but I really prefere the native git coloring, which looks a loot nicer
 and does also highlight traling whitespace)

-Peter
