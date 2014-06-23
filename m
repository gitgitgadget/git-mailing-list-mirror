From: Stephen Kelly <steveire@gmail.com>
Subject: Re: gitk with submodules does not show new commits on other branches
Date: Mon, 23 Jun 2014 19:00:49 +0200
Message-ID: <lo9mg1$bma$1@ger.gmane.org>
References: <lo6o2h$vva$1@ger.gmane.org> <53A6F978.4010005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 19:01:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz7cF-00031X-VB
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 19:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbaFWRBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 13:01:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:57025 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755369AbaFWRBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 13:01:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Wz7c8-0002xA-Hr
	for git@vger.kernel.org; Mon, 23 Jun 2014 19:01:04 +0200
Received: from 188.111.54.34 ([188.111.54.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 19:01:04 +0200
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 19:01:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252353>

Jens Lehmann wrote:

> But I agree that this is suboptimal for your workflow. What about adding
> a "Visualize These Changes In The Submodule" menu entry for the context
> menu of a change in gitk just like the one git gui already has? Then the
> user could examine the merges in more detail if he wants.

Such a menu entry might be useful,  but it is still different workflow. It 
would be useful in the 'that commit sounds interesting - show me' case. I 
would need to see the commit title to know if it sounds interesting though. 

Your suggestion involves a different window and context, but all I want to 
see is a list of commit titles so I can press 'up' to see the next ones, not 
have to close a window first before I can see the next list, and then have 
to right-click to see the list of commits.

Is it so difficult to list the titles of all of the newly-reachable commits? 
Even with a config option? Even an undocumented option? 

Failing all of that, can you show me where the code would need to be changed 
to list all of the newly-reachable commits? I can keep a commit for myself 
then.

Thanks,

Steve.
