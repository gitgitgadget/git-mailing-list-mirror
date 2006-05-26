From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 0/4] fix tests so they run without needing bash
Date: Thu, 25 May 2006 19:06:14 -0700
Message-ID: <1148609178788-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
X-From: git-owner@vger.kernel.org Fri May 26 04:06:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjRig-00077O-0Z
	for gcvg-git@gmane.org; Fri, 26 May 2006 04:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWEZCGZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 22:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWEZCGY
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 22:06:24 -0400
Received: from hand.yhbt.net ([66.150.188.102]:6806 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030212AbWEZCGU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 22:06:20 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 84C8F2DC01A; Thu, 25 May 2006 19:06:18 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.3.2.g7d11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20780>

I've tested these patches with bash, pdksh, and dash.  dash seems
to be 7s faster than bash (28s vs 35s) when running `make test',
and just a hair faster than pdksh.

Herbert:
patches #2 and #4 are required for dash, but not for pdksh.
I'm not sure about #2, but I'm pretty certain the problem #4 works
around is a bug in dash.

[PATCH 1/4] t3300-funny-names: shell portability fixes
[PATCH 2/4] tests: Remove heredoc usage inside quotes
[PATCH 3/4] t5500-fetch-pack: remove local (bashism) usage.
[PATCH 4/4] t6000lib: workaround a possible dash bug

-- 
Eric Wong
