From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 1/5] Add a generic tree traversal to fetch SVN properties.
Date: Tue, 16 Oct 2007 16:53:28 +0200
Message-ID: <4714D068.8090606@viscovery.net>
References: <1192545412-10929-1-git-send-email-tsuna@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Oct 16 16:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihnnj-00020u-7J
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 16:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbXJPOxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 10:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbXJPOxc
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 10:53:32 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:32524 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932540AbXJPOxc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 10:53:32 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IhnnJ-0008Vc-OA; Tue, 16 Oct 2007 16:53:18 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 17FC76B7; Tue, 16 Oct 2007 16:53:29 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1192545412-10929-1-git-send-email-tsuna@lrde.epita.fr>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61187>

Benoit Sigoure schrieb:
> 	* git-svn.perl (&traverse_ignore): Remove.
> 	(&prop_walk): New.
> 	(&cmd_show_ignore): Use prop_walk.

This may be your favorite style of commit messaged, but I think the 
concensus for git is a different style of commit message: We would like to 
see *why* this change is good. But you only note *what* was changed, 
something that can be seen by looking at the patch anyway.

The commit message should be helpful when the commit is looked at in 
isolation, like when you are doing some code archeology half a year later 
and e.g. git-blame/git-bisect points you to this commit.

Also a notice such as

  "With this we will be able to lift properties like svn:ignore into
   .gitignore in a follow-up change."

tells that this was actually part of a series and you don't have to remember 
that half a year ago there were 4 more patches submitted in the same second 
with this one.

-- Hannes
