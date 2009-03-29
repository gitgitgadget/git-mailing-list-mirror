From: jamespetts <jamespetts@yahoo.com>
Subject: Re: Fork of abandoned SVN mirror - how to keep up to date with the
  SVN
Date: Sun, 29 Mar 2009 05:53:23 -0700 (PDT)
Message-ID: <1238331203288-2552470.post@n2.nabble.com>
References: <22756729.post@talk.nabble.com> <8c9a060903280922r6514de83mea4dea84c4116225@mail.gmail.com> <1238258794470-2549665.post@n2.nabble.com> <8c9a060903281102r3eae26edta34899485feb884b@mail.gmail.com> <1238263580197-2549943.post@n2.nabble.com> <8c9a060903281327j33056807j78a2cd03b8151979@mail.gmail.com> <1238276809892-2550565.post@n2.nabble.com> <8c9a060903281504qd1b66hefb70e60c3f624d2@mail.gmail.com> <1238278694146-2550633.post@n2.nabble.com> <fabb9a1e0903281521y2e6785f1w5dde3c73be404327@mail.gmail.com> <1238323876827-2552153.post@n2.nabble.com> <fabb9a1e0903290403s2b0bbe1al57ac448a16d05070@mail.gmail.com> <1238327564546-2552334.post@n2.nabble.com> <fabb9a1e0903290503g7ec0a37djd71ce8eba6220d70@mail.gmail.com> <1238328537685-2552369.post@n2.nabble.com> <fabb9a1e0903290535y59cd3a1fvd5a
 7d3476dff45bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 14:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnuXS-0003Na-6o
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 14:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbZC2Mx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 08:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbZC2Mx1
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 08:53:27 -0400
Received: from kuber.nabble.com ([216.139.236.158]:34927 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbZC2Mx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 08:53:26 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1LnuVv-00072F-9X
	for git@vger.kernel.org; Sun, 29 Mar 2009 05:53:23 -0700
In-Reply-To: <fabb9a1e0903290535y59cd3a1fvd5a7d3476dff45bc@mail.gmail.com>
X-Nabble-From: jamespetts@yahoo.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115025>



Heya,

On Sun, Mar 29, 2009 at 14:08, jamespetts <jamespetts@yahoo.com> wrote:
> "fatal: ambiguous argument 'trunk': unknown revision or path not in the working tree.
>
> "use '--' to separate paths from revisions".
>
> What am I doing wrong this time...?

You can do "git branch -a" to see which branch name git svn uses, it
might be 'git-svn', it depends on which version you're using I think.



Thank you for the suggestion - the first part seemed to work: once I got the correct name, "...reset --hard" responded with:

"HEAD is now at 4939935 first commit".

However, when I tried "git svn rebase" again, I still got this error:

"Unable to determine upstream SVN infromation from working tree history".

Have I done something wrong...?
-- 
View this message in context: http://n2.nabble.com/Fork-of-abandoned-SVN-mirror---how-to-keep-up-to-date-with-the-SVN-tp2548952p2552470.html
Sent from the git mailing list archive at Nabble.com.
