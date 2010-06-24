From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: rebasing a merge
Date: Thu, 24 Jun 2010 10:16:19 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1006241012400.28950@ds9.cixit.se>
References: <AANLkTilY_9j2sXlplhYB4FPAIAzuPBg2UyUTEk4DaaYF@mail.gmail.com> <alpine.DEB.2.00.1006181010220.12445@ds9.cixit.se> <AANLkTikH9S1GCOwJfmKvO4fTvG46libJtrdMNQeiBm1_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 11:16:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORiXy-0000UN-S8
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 11:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab0FXJQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 05:16:27 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:37679 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754380Ab0FXJQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 05:16:27 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o5O9GKgh002555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 24 Jun 2010 11:16:20 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o5O9GJ0T002550;
	Thu, 24 Jun 2010 11:16:20 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <AANLkTikH9S1GCOwJfmKvO4fTvG46libJtrdMNQeiBm1_@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 24 Jun 2010 11:16:20 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149567>

Jay Soffian:

> I'm familiar with rerere.

Yes, of course, sorry for not recognizing your name :-)

> Which is what I was doing. But it occurred to me that the final tree
> that I want is the same as if I just do a second merge,

So, you want to just discard the change in the new commit on the branch you 
merged?

You could probably get off by "git cat-file" the commit object, changing the 
parent reference to point to the newly introduced commit while leaving the 
rest intact, and then "git hash-object" the new commit object, and then 
forward the branch head to that one.

-- 
\\// Peter - http://www.softwolves.pp.se/
