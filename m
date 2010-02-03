From: Peter Krefting <peter@softwolves.pp.se>
Subject: How to rebase and rename?
Date: Wed, 3 Feb 2010 10:05:10 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1002030958380.17444@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 10:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcbAn-0002Xh-CH
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 10:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320Ab0BCJFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 04:05:15 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:46056 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754815Ab0BCJFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 04:05:12 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o1395A4b023244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Feb 2010 10:05:10 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o1395AVu023241;
	Wed, 3 Feb 2010 10:05:10 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 03 Feb 2010 10:05:10 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138816>

Hi!

If I have a repository with a topic branch that is published, and that I 
want to rebase and republish under a new name, is there an easy way of doing 
that?

I.e., I want to go from

      ---C---D topic-1
     /
  --A---X---X---B master

to

        ---C---D topic-1
 	  /
      /           ---C'---D' topic-2
     /           /
  --A---X---X---B master

Currently, I do something along the lines of:

  git branch topic-2 topic-1
  git rebase master topic-2

but that feels wrong as it creates the "topic-2" branch pointing the 
the wrong way first. Is there a way to eliminate that step?

-- 
\\// Peter - http://www.softwolves.pp.se/
