From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: config for merging master to test branch
Date: Mon, 28 Dec 2009 18:38:39 -0500
Message-ID: <20091228233838.GA28052@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 00:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPPSv-00028q-EP
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 00:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbZL1X4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 18:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbZL1X4o
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 18:56:44 -0500
Received: from l2mail1.panix.com ([166.84.1.75]:49948 "EHLO l2mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbZL1X4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 18:56:44 -0500
X-Greylist: delayed 1085 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Dec 2009 18:56:44 EST
Received: from mail1.panix.com (mail1.panix.com [166.84.1.72])
	by l2mail1.panix.com (Postfix) with ESMTP id 867E4A9
	for <git@vger.kernel.org>; Mon, 28 Dec 2009 18:40:10 -0500 (EST)
Received: from panix5.panix.com (panix5.panix.com [166.84.1.5])
	by mail1.panix.com (Postfix) with ESMTP id 5848A1F08A
	for <git@vger.kernel.org>; Mon, 28 Dec 2009 18:38:39 -0500 (EST)
Received: by panix5.panix.com (Postfix, from userid 14662)
	id 4CD7A2422A; Mon, 28 Dec 2009 18:38:39 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135773>

Hello:

Here's my workflow...

testing directory (test branch)
    [set origin to server repository]
    git pull
    git branch test
    git checkout test
    [edit settings files]
    git commit ...

working directory (master branch)
    [set origin to server repository]
    [make changes]
    git commit ...
    git push origin master

Now, here's the question.  I want to go back into the testing directory 
and do a "git pull" and have the changes from master automatically merged 
into my test branch in one step, without having to do an explicit set of 
checkouts and merges.  I get the impression there are configuration 
settings that allow such to be done.  Is my impression correct?  If so, 
what are the explicit configuration commands, please?  Or is there some 
command other than "pull" I should be using to do this?

Thanks,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
 4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335 f: 718-854-0409
