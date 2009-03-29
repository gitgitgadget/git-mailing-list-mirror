From: jamespetts <jamespetts@yahoo.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the
  SVN
Date: Sun, 29 Mar 2009 05:08:57 -0700 (PDT)
Message-ID: <1238328537685-2552369.post@n2.nabble.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> <1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> <1238263580197-2549943.post@n2.nabble.com> <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com> <1238276809892-2550565.post@n2.nabble.com> <8c9a060903281504qd1b66hefb70e60c3f624d2@mail.gmail.com> <1238278694146-2550633.post@n2.nabble.com> <fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com> <1238323876827-2552153.post@n2.nabble.com> <fabb9a1e0903290403s2b0bbe1al57ac448a16d05070@mail.gmail.com> <1238327564546-2552334.post@n2.nabble.com> <fabb9a1e0903290503g7ec0a37djd71ce8eba6220d70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 14:10:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LntqU-0006Ht-BP
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 14:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbZC2MJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 08:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753414AbZC2MJA
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 08:09:00 -0400
Received: from kuber.nabble.com ([216.139.236.158]:51130 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbZC2MI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 08:08:59 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1Lntov-0005ab-MR
	for git@vger.kernel.org; Sun, 29 Mar 2009 05:08:57 -0700
In-Reply-To: <fabb9a1e0903290503g7ec0a37djd71ce8eba6220d70@mail.gmail.com>
X-Nabble-From: jamespetts@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115022>




Heya,

[it is customary on this list not to top post and to reply in-line,
like I'm doing now]

Ohh, terribly sorry - didn't realise.

On Sun, Mar 29, 2009 at 13:52, jamespetts <jamespetts@yahoo.com> wrote:
> Also, when I tried "git svn rebase", I got the following error:

> And the local directories for the repositories are still empty. Am I doing something wrong...?

You need to do something like 'git reset --hard trunk' on the master
branch, after which you can use 'git svn rebase'. This is needed the
first time only so that git svn can then figure out where you're at
from the commit messages.

Thank you for that suggestion :-) Unfortunately, "git reset --hard trunk" produced the following error:

"fatal: ambiguous argument 'trunk': unknown revision or path not in the working tree.

"use '--' to separate paths from revisions".

What am I doing wrong this time...?
-- 
View this message in context: http://n2.nabble.com/Fork-of-abandoned-SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp2548952p2552369.html
Sent from the git mailing list archive at Nabble.com.
