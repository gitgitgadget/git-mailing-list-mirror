From: Jon Loeliger <jdl@freescale.com>
Subject: Re: changing history once public
Date: Fri, 30 May 2008 16:37:19 -0500
Message-ID: <4840738F.2070909@freescale.com>
References: <1212182690.8311.30.camel@isidore.myhome.westell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John J. Franey" <jjfraney@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 23:39:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2CJQ-0000Li-Tn
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 23:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbYE3ViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 17:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbYE3ViH
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 17:38:07 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:60265 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbYE3ViH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 17:38:07 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m4ULc12x009211;
	Fri, 30 May 2008 14:38:02 -0700 (MST)
Received: from [10.214.73.8] (mvp-10-214-73-8.am.freescale.net [10.214.73.8])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4ULc0Yx023879;
	Fri, 30 May 2008 16:38:01 -0500 (CDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1212182690.8311.30.camel@isidore.myhome.westell.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83342>

John J. Franey wrote:
> I think I understand the issue with changing history on branches that
> have been made public.
> 
> What is the negative of publishing a branch and not being able to apply
> history changing commands?

If there is something in that history you want to "remove",
it must be done as an inverse patch, or an additional "removal"
patch.  You can't just change the history by backing it up and
writing it differently.

> If I want to keep this branch current (in public), I would pull from the
> tracking branch resolve conflicts and push to my public repo. 

Right.

> This
> action leaves my commit as the parent of another commit; it is not
> longer at HEAD.  Does it matter if my commit is no longer HEAD of my
> branch?

Uh, by definition HEAD is the current-most commit on your
active branch, right?

HTH,
jdl
