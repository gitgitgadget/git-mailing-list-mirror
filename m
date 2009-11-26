From: Tim Mazid <timmazid@hotmail.com>
Subject: Re: Working on merged branches whilst seeing current master
Date: Thu, 26 Nov 2009 04:45:50 -0800 (PST)
Message-ID: <1259239550525-4070977.post@n2.nabble.com>
References: <1257959806206-3987667.post@n2.nabble.com> <20091111215727.GK27518@vidovic> <1258030118389-3992599.post@n2.nabble.com> <1258044562803-3994102.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 13:45:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDdjQ-00044L-7f
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 13:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611AbZKZMpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 07:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbZKZMpo
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 07:45:44 -0500
Received: from kuber.nabble.com ([216.139.236.158]:59350 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbZKZMpo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 07:45:44 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1NDdjK-0003U8-H7
	for git@vger.kernel.org; Thu, 26 Nov 2009 04:45:50 -0800
In-Reply-To: <1258044562803-3994102.post@n2.nabble.com>
X-Nabble-From: Tim Mazid <timmazid@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133790>



rhlee wrote:
> 
> 
> Tim Mazid wrote:
>> 
>> Actually, there's no reason you couldn't just 'git reset HEAD^' once you
>> realise that the branch isn't ready. If you want to see the changes from
>> master, you could just merge that into your branch. If you just want to
>> see the content in master, you could use gitk or gitg, which allows you
>> to view files at any commit.
>> 
>> Personally, I merge master into my branches, test and check, and fix,
>> then merge the branch into master. This sometimes results in a
>> fast-forward, if you haven't made changes to master. If you don't like
>> that, you can always use the --no-ff option, though.
>> 
> 
> I don't think 'git reset HEAD^' would work in my case as that only goes
> back one commit. I may have made many other changes on the master branch
> that I want to keep.
> 
> By merging from master into your branch, like you said, you get a nice
> graph view that shows what you've brought into your branch from master
> since you last left off. But doesn't this goes against the idea that
> branches should be independent, by bringing in changes from master?
> 

Yup, you only need to 'git reset HEAD^' on the master branch to undo the
merge. Isn't that what you wanted?

And yeah, I suppose it kind of does. But once again, you can 'git reset
HEAD^'. And since you're merging master INTO the branches, you are keeping
the branches independent, anyway.
-- 
View this message in context: http://n2.nabble.com/Working-on-merged-branches-whilst-seeing-current-master-tp3987667p4070977.html
Sent from the git mailing list archive at Nabble.com.
