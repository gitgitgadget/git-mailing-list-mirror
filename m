From: darxus@chaosreigns.com
Subject: Feature request: don't require both bad and good when bisecting
Date: Sun, 18 Mar 2012 17:29:57 -0400
Message-ID: <20120318212957.GS1219@chaosreigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 22:36:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9NmT-0006mK-5G
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 22:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116Ab2CRVgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 17:36:14 -0400
Received: from panic.chaosreigns.com ([64.71.152.40]:38003 "EHLO
	panic.chaosreigns.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab2CRVgO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 17:36:14 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Mar 2012 17:36:14 EDT
Received: by panic.chaosreigns.com (Postfix, from userid 1000)
	id 45C481C5492; Sun, 18 Mar 2012 17:29:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=chaosreigns.com;
	s=mail; t=1332106197;
	bh=NQGtYjaG0Gn4g2Rw8QwRmnr+Fro4oUM2UjUKrmJsNrc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=snGN7udm95Fmv0svORAFBWmaTx6bnkQZyTAQZ9j9v5OrlFzadv/sgcjacAVMeD8sl
	 om8Jy+1tLeXMoyxz8uk4DMOeraO1wSl/IutT0UBrUISSQgmWJqmQoa5kAgBeUFkVya
	 8WUZCHsEa7C/rbXHOabtvzq0cohIejyEjZ5gUBYk=
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193392>

I'd like to be able to tell get only that I know the latest commit is bad,
and have it go find a good commit, then do the bisecting.  Maybe something
like the opposite of a binary search, start with the last commit, then
second to last, then 4th to last, 8th to last, etc., till it finds a good
commit.

-- 
"This hurts quite a bit. Very painful."
"Think of the sensation as reassurance that you are not dead yet. What
you are feeling is life in you!" - Johnny The Homicidal Maniac
http://www.ChaosReigns.com
