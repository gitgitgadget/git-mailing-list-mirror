From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 22:47:47 +0200
Organization: At home
Message-ID: <g43jlg$54g$1@ger.gmane.org>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <16460.6618382551$1214599182@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 22:49:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCKsS-0002KM-2L
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 22:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbYF0UsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 16:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753559AbYF0UsH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 16:48:07 -0400
Received: from main.gmane.org ([80.91.229.2]:51368 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753081AbYF0UsG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 16:48:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KCKrP-0000PT-VB
	for git@vger.kernel.org; Fri, 27 Jun 2008 20:48:00 +0000
Received: from abvh161.neoplus.adsl.tpnet.pl ([83.8.205.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 20:47:59 +0000
Received: from jnareb by abvh161.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 20:47:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvh161.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86631>

David Jeske wrote:

> reorder: Picture that a list of commits on this branch opens in an editor. You
> are free to rearrange the lines in any order you want, but you have to keep all
> the lines. When you are done reordering the lines, the tool creates a new topic
> branch and applies the changes (probably with cherrypick) to the new topic
> branch. If there are no conflicts, you're done.
> 
> merge: Picture now that in your editor you can create groupings of those
> individual commits that should make up separate topic-branches. The operation
> can still be performed automatically, and at the end, it can compose those
> topic branches into a single branch just like your original. At this point, you
> can "isolate" any one of those topic branches and test/push that topic branch.

git rebase --interactive?
Any patch management interface (StGIT, Guilt)?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
