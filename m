From: "Todd A. Jacobs" <nospam@codegnome.org>
Subject: What does the 100 in R100 mean?
Date: Fri, 14 May 2010 04:21:45 -0700
Message-ID: <20100514112145.GQ12846@penguin.codegnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 14 13:58:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCtWs-0000Ub-Is
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 13:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757730Ab0ENL6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 07:58:01 -0400
Received: from que11.charter.net ([209.225.8.21]:56109 "EHLO que11.charter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754290Ab0ENL57 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 07:57:59 -0400
X-Greylist: delayed 1600 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 May 2010 07:57:59 EDT
Received: from imp10 ([10.20.200.15]) by mta21.charter.net
          (InterMail vM.7.09.02.04 201-2219-117-106-20090629) with ESMTP
          id <20100514112147.GXLG75.mta21.charter.net@imp10>
          for <git@vger.kernel.org>; Fri, 14 May 2010 07:21:47 -0400
Received: from penguin.codegnome.org ([71.83.124.90])
	by imp10 with smtp.charter.net
	id HPMm1e0011x8DgP05PMmf9; Fri, 14 May 2010 07:21:47 -0400
X-Authority-Analysis: v=1.0 c=1 a=ge45WnWFqjUA:10 a=mI6YO6ZdSLUA:10
 a=kj9zAlcOel0A:10 a=MQcGYD3nGAUvkubrX70A:9 a=a6UAOH6QQrF1UY6GrM-laZoJO9YA:4
 a=CjuIK1q_8ugA:10
Received: by penguin.codegnome.org (Postfix, from userid 1000)
	id CEDDF37CB2; Fri, 14 May 2010 04:21:45 -0700 (PDT)
Received: by penguin.codegnome.org (tmda-sendmail, from uid 1000);
	Fri, 14 May 2010 04:21:45 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
Mail-Followup-To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147083>

When I'm looking at the output for renamed files in git-log or
git-whatchanged, renamed files always seem to say "R100." So, I looked
in the man page, followed the internal references to --diff-filter, and
remain stumped as to what the digits stand for. I couldn't even find an
explanatory comment in the git source code.

Obviously, R is for "(R)enamed." What is the "100" for? If it's being
returned as a flag to --name-status and friends, it should probably be
documented somewhere.

-- 
"Oh, look: rocks!"
	-- Doctor Who, "Destiny of the Daleks"
