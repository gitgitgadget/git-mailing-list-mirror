From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Question about git revert
Date: Thu, 8 Jul 2010 05:05:02 +0200
Message-ID: <201007080505.02633.chriscool@tuxfamily.org>
References: <20100708015019.GP10042@volcano.builtonlinux.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Hal Eisen <eisen@dunhackin.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 05:05:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWhQa-0003od-Ci
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 05:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab0GHDFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 23:05:13 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:42327 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531Ab0GHDFM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 23:05:12 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 696E5818034;
	Thu,  8 Jul 2010 05:05:04 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-22-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100708015019.GP10042@volcano.builtonlinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150529>

On Thursday 08 July 2010 03:50:19 Hal Eisen wrote:
> I did a search of the archives for this mailing list, and couldn't
> find anything applicable.
> 
> I am having the same problem as Joshua Cheek.  He asked this question
> on StackOverflow about a month ago.
> 
> http://stackoverflow.com/questions/2938301/git-remove-specific-commit
> 
> There are no merges involved.  I would be perfectly happy having
> another commit in my history which documents the reverting of a prior
> commit.
> 
> The problem seems to stem from git-revert not properly calculating the
> "cleanness" of the prior commit, and incorrectly thinking that later
> commits depend on the to-be-reverted commit.

You may want to try "git revert" with the new --strategy option,
for example "git revert --strategy resolve <commit>". This option is not in a 
released version yet, so you should use one of the last git version from the 
master branch, for example v1.7.2-rc2.

> I have seen other web sites which suggest using git to manually
> generate a diff, and then applying it as a reverse patch, but that
> seems like a kludge.
> 
> What is the best solution for this use case?

It depends on how well the revert algorithms work in the case you are 
interested in. If one strategy works quite well, then manually fixing the few 
remaining problems, if any, in the result is probably the best solution. 

Regards,
Christian.
