From: rhlee <richard@webdezign.co.uk>
Subject: Re: Working on merged branches whilst seeing current master
Date: Thu, 12 Nov 2009 08:49:22 -0800 (PST)
Message-ID: <1258044562803-3994102.post@n2.nabble.com>
References: <1257959806206-3987667.post@n2.nabble.com> <20091111215727.GK27518@vidovic> <1258030118389-3992599.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 17:49:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8crQ-0005qE-VN
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 17:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbZKLQtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 11:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbZKLQtR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 11:49:17 -0500
Received: from kuber.nabble.com ([216.139.236.158]:38370 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbZKLQtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 11:49:17 -0500
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1N8crK-0007JT-QD
	for git@vger.kernel.org; Thu, 12 Nov 2009 08:49:22 -0800
In-Reply-To: <1258030118389-3992599.post@n2.nabble.com>
X-Nabble-From: rhlee <richard@webdezign.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132782>



Tim Mazid wrote:
> 
> Actually, there's no reason you couldn't just 'git reset HEAD^' once you
> realise that the branch isn't ready. If you want to see the changes from
> master, you could just merge that into your branch. If you just want to
> see the content in master, you could use gitk or gitg, which allows you to
> view files at any commit.
> 
> Personally, I merge master into my branches, test and check, and fix, then
> merge the branch into master. This sometimes results in a fast-forward, if
> you haven't made changes to master. If you don't like that, you can always
> use the --no-ff option, though.
> 

I don't think 'git reset HEAD^' would work in my case as that only goes back
one commit. I may have made many other changes on the master branch that I
want to keep.

By merging from master into your branch, like you said, you get a nice graph
view that shows what you've brought into your branch from master since you
last left off. But doesn't this goes against the idea that branches should
be independent, by bringing in changes from master?
-- 
View this message in context: http://n2.nabble.com/Working-on-merged-branches-whilst-seeing-current-master-tp3987667p3994102.html
Sent from the git mailing list archive at Nabble.com.
