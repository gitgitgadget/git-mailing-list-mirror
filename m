From: Intland Software <marketing@intland.com>
Subject: Re: [ANNOUNCE] codeBeamer MR - Easy ACL for Git
Date: Thu, 19 Nov 2009 14:50:02 +0100
Message-ID: <4B054D0A.5030802@intland.com>
References: <4B03B153.1020302@intland.com> <20091118120936.GL17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Nov 19 14:50:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB7Oq-0000Rc-Eb
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 14:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756974AbZKSNuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 08:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756862AbZKSNuA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 08:50:00 -0500
Received: from mail02a.mail.t-online.hu ([84.2.40.7]:57471 "EHLO
	mail02a.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756866AbZKSNt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 08:49:58 -0500
Received: from [192.168.1.65] (dsl4E5C0E4F.pool.t-online.hu [78.92.14.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail02a.mail.t-online.hu (Postfix) with ESMTPSA id B7F16256D02;
	Thu, 19 Nov 2009 14:49:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <20091118120936.GL17748@machine.or.cz>
X-DCC-mail.t-online.hu-Metrics: mail02a.mail.t-online.hu 32721; Body=2 Fuz1=2
	Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133228>

Petr Baudis wrote:
> I think a lot of people wonder now, how does this compare to existing
> solutions; from your announcement I thought it's something like
> Gitosis/Gitolite, but in fact it seems more similar to Gitorious or
> GitHub (if it was publicly available, of course); perhaps it would be
All right, some quick comparisons with codeBeamer Managed Repository (MR).

* MR against Gitosis
In terms of access control, MR has the concept of "role", and it makes our security model more fine grained. Permissions 
can be set by role. One user account can have multiple roles. Roles are project-dependent. When you add a group to a 
project, you can assign multiple roles to the group (which is equivalent with assigning those roles to each group member 
one by one).
On the other hand, MR has a much broader scope than Gitosis. MR helps you to manage your repos, to track your 
tasks/bugs/issues, to follow commit activities, to browse repos in the web, can be extended using its APIs, etc. (And 
you don't have to install and maintain Git extensions for this.)

* MR against Gitolite
Pretty much the same applies here as well.

* MR against GitHub & Gitorious
Probably the most significant difference is that MR is available as free download, and can run behind your firewall.
MR was derived from the source code of our commercial product codeBeamer. CodeBeamer is a full-blown enterprise 
collaboration solution, thus MR is likely to focus more on the enterprise needs, not on the "social" aspect.
