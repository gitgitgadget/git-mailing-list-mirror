From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: Working on merged branches whilst seeing current master
Date: Thu, 12 Nov 2009 04:48:38 -0800 (PST)
Message-ID: <1258030118389-3992599.post@n2.nabble.com>
References: <1257959806206-3987667.post@n2.nabble.com> <20091111215727.GK27518@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 13:49:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Z6T-0006gV-71
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 13:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbZKLMsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 07:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbZKLMsd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 07:48:33 -0500
Received: from kuber.nabble.com ([216.139.236.158]:44813 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZKLMsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 07:48:32 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N8Z6M-0002dm-DA
	for git@vger.kernel.org; Thu, 12 Nov 2009 04:48:38 -0800
In-Reply-To: <20091111215727.GK27518@vidovic>
X-Nabble-From: Tim Mazid <timmazid@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132766>



Nicolas Sebrecht-3 wrote:
> 
> The 11/11/09, rhlee wrote:
>> 
>> I use branches for features. I have a branch and I merged it into my
>> master
>> branch as I thought it was finished. But it turns out I wasn't and so I
>> need
>> to work on it again.
>> 
>> I have made some more changes (branches and merges) on master. So what I
>> should do is checkout that branch, work on it committing along the way
>> and
>> then merge it again onto my master branch.
>> 
>> However I though I am working on a feature branch I want to be also
>> working
>> from the master branch as reference.
> 
> If the feature branch is merged to the mainline, it should really mean
> that the feature is ready : the feature branch life stop here. This also
> means that if you see that this feature was not as ready as you thought,
> you have to restart a _new_ feature branch off of the mainline.
> 

Actually, there's no reason you couldn't just 'git reset HEAD^' once you
realise that the branch isn't ready. If you want to see the changes from
master, you could just merge that into your branch. If you just want to see
the content in master, you could use gitk or gitg, which allows you to view
files at any commit.

Personally, I merge master into my branches, test and check, and fix, then
merge the branch into master. This sometimes results in a fast-forward, if
you haven't made changes to master. If you don't like that, you can always
use the --no-ff option, though.

Good luck,
Tim.
-- 
View this message in context: http://n2.nabble.com/Working-on-merged-branches-whilst-seeing-current-master-tp3987667p3992599.html
Sent from the git mailing list archive at Nabble.com.
