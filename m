From: Jason Miller <jason@milr.com>
Subject: Delete branch during fast-import
Date: Tue, 17 Sep 2013 10:49:55 -0700
Message-ID: <20130917174954.GA28563@home.jasonmmiller.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 20:03:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLzcx-0005uY-RX
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 20:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab3IQSDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 14:03:41 -0400
Received: from fed1rmfepi107.cox.net ([68.230.241.138]:47735 "EHLO
	fed1rmfepi107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab3IQSDk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 14:03:40 -0400
X-Greylist: delayed 646 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Sep 2013 14:03:40 EDT
Received: from fed1rmimpo210 ([68.230.241.161]) by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.09 201-2260-151-124-20120717) with ESMTP
          id <20130917175253.XIPV3892.fed1rmfepo101.cox.net@fed1rmimpo210>
          for <git@vger.kernel.org>; Tue, 17 Sep 2013 13:52:53 -0400
Received: from localhost ([70.191.80.19])
	by fed1rmimpo210 with cox
	id SHst1m00D0R0GNW01HstgD; Tue, 17 Sep 2013 13:52:53 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020202.523896F5.0157,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=drIF/Sc4 c=1 sm=1
 a=8Pu+u8o12PWZCfupdeghHQ==:17 a=wom5GMh1gUkA:10 a=TJnKmCqjyHAA:10
 a=as2ii8JTC2oA:10 a=kj9zAlcOel0A:10 a=BswL-RFwAAAA:8 a=kM_2MJY8AAAA:8
 a=svIbT7w5TVgA:10 a=bTV28HER_Yd_lZct8_gA:9 a=CjuIK1q_8ugA:10
 a=kvx9ACX9JqAA:10 a=WOsSUt-DgwAA:10 a=8Pu+u8o12PWZCfupdeghHQ==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (CRAM-MD5)
 smtp.auth=aidenn01@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234897>

I'm trying out a rather large subversion import, and am trying to
figure out if there is a way to delete branches during a fast-import.

Right now I can think of only 2 ways to handle this:

1) End the import, do a git branch -D and then resume the import.

2) Scan the entire repository history, identify
deleted branches and handle them upfront so that they never have
conflicting names.

Is there a better way?

-Jason
