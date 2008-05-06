From: Barry Roberts <blr@robertsr.us>
Subject: Noob question on using branches
Date: Tue, 06 May 2008 09:47:48 -0600
Message-ID: <48207DA4.80502@robertsr.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 17:49:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtPPI-0002uu-Sy
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 17:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758406AbYEFPr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 11:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbYEFPrz
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 11:47:55 -0400
Received: from qmta08.emeryville.ca.mail.comcast.net ([76.96.30.80]:47048 "EHLO
	QMTA08.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755529AbYEFPry (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 11:47:54 -0400
Received: from OMTA08.emeryville.ca.mail.comcast.net ([76.96.30.12])
	by QMTA08.emeryville.ca.mail.comcast.net with comcast
	id NEE31Z0050FhH24A807d00; Tue, 06 May 2008 15:46:08 +0000
Received: from dalmuti.xactvalue.com ([76.27.63.88])
	by OMTA08.emeryville.ca.mail.comcast.net with comcast
	id NFnp1Z00A1uEJYk8U00000; Tue, 06 May 2008 15:47:51 +0000
X-Authority-Analysis: v=1.0 c=1 a=ATkW8okCTpsXDSITe1sA:9
 a=MKWnMxMkexC3clFx1eXsglEb424A:4 a=gi0PWCVxevcA:10
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81361>

I have a branch in my git repository that is a "released" branch.  It 
only gets defect fixes as they are needed to patch our production servers.

I want to get all those defect fixes back into the master, but I don't 
want changes from the master getting into the production branch, so I 
don't think I want to do:
git checkout master
git merge production

right?

It looks like "git pull --squash . production" will do what I want.  Is 
that correct, or is there a better way?  git cherry-pick seems 
cumbersome when I already know I want everything in the branch (unless 
there's a way to tell cherry-pick to get the whole branch and I've 
missed that).

Thanks,
Barry Roberts
