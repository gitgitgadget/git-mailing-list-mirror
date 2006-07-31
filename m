From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: File version at a specific date?
Date: Mon, 31 Jul 2006 20:24:04 +0200
Organization: At home
Message-ID: <ealhrj$pdo$1@sea.gmane.org>
References: <200607311956.00679.Alexander.Zvyagin@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 31 20:24:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7cR5-0008BM-LZ
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 20:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWGaSYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 14:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWGaSYM
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 14:24:12 -0400
Received: from main.gmane.org ([80.91.229.2]:4488 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030304AbWGaSYL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 14:24:11 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7cQl-00086W-8A
	for git@vger.kernel.org; Mon, 31 Jul 2006 20:23:55 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 20:23:55 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 20:23:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24533>

Alexander ZVYAGIN wrote:

> I failed to find in the documentation how to look to a file content
> at some moment in a past.
> 
> Something like this:
> $ git checkout master~2 Makefile
> when I specify not the revisions numbers ago the file was (~2),
> but the time, for example "2005-12-12 00:00:00" or something like this.
> 
> Where should I look at?

Either use git rev-list with --since=datestring, --after=datestring,
--until=datestring, --before=datestring to find a commit, or if you have
reflog enabled (you have .git/logs/refs/) you can use @{date} syntax,
see 'man git-rev-parse'

"A suffix @ followed by a date specification enclosed in a brace pair  (e.g.
 {yesterday},  {1  month  2 weeks 3 days 1 hour 1 second ago} or {1979-02-26
 18:30:00}) to specify the value of the ref at a prior point in  time.  This
 suffix  may  only be used immediately following a ref name and the ref must
 have an existing log ($GIT_DIR/logs/<ref>)."

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
