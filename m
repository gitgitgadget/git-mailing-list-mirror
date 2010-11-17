From: Andi Kleen <andi@firstfloor.org>
Subject: groff .ft command use in asciidoc
Date: Wed, 17 Nov 2010 10:52:34 +0100
Message-ID: <20101117095233.GA23817@basil.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 17 10:52:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIeh3-0000C1-Gn
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 10:52:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab0KQJwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 04:52:39 -0500
Received: from one.firstfloor.org ([213.235.205.2]:57035 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab0KQJwi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 04:52:38 -0500
Received: from basil.firstfloor.org (p5B3C9449.dip0.t-ipconnect.de [91.60.148.73])
	by one.firstfloor.org (Postfix) with ESMTP id 825FA1A9805F
	for <git@vger.kernel.org>; Wed, 17 Nov 2010 10:52:34 +0100 (CET)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 18624B16AA; Wed, 17 Nov 2010 10:52:34 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161607>


Hi,

The git manpages on my opensuse 11.3 (git 1.7.1-1.14)
frequently use the .ft command the opensuse groff does not 
render.

For example from the final output of "man git-commit":

           .ft C
           $ edit hello.c
           $ git rm goodbye.c
           $ git add hello.c
           $ git commit
           .ft


So the .ft commands are visible.  It's really a cosmetic issue 
only, but looks ugly and irritates me every time I 
look something up in the man pages.

I double checked against current git.git and the problem 
is still there, because .ft C is configured in 
Documentation/asciidoc.conf

Not sure what the best solution is. Stop using .ft
and change asciidocs configuration?


-Andi 


-- 
ak@linux.intel.com -- Speaking for myself only.
