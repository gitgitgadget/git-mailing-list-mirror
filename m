From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Questions about branches in git
Date: Fri, 29 Jan 2010 11:06:07 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1001291103300.25954@ds9.cixit.se>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Linck <mgl@absolute-performance.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 11:06:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nank4-0002bG-65
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 11:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756892Ab0A2KGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 05:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756856Ab0A2KGM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 05:06:12 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:57814 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756810Ab0A2KGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 05:06:11 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o0TA67Qh028323
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Jan 2010 11:06:07 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o0TA67Hp028319;
	Fri, 29 Jan 2010 11:06:07 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 29 Jan 2010 11:06:07 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138304>

Mike Linck:

> It seems that after a topic or bug branch is merged back into its parent, 
> especially if it was fast forwarded, it becomes hard to determine what 
> changes were made in it, to resolve the problem that it was created to 
> address.

If you keep the branch name somewhere (either pushed to the master 
repository, or to a side-repository used to store old "dead" branches), then 
you at least have the pointer to the last commit on that particular branch.

You can then backtrack through the commits to the previous merge-point, or 
branch head, in the history to find the point where it, most likely, was 
branched off from.

-- 
\\// Peter - http://www.softwolves.pp.se/
