From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Commit to other branch
Date: Sun, 6 Jun 2010 20:43:34 +0200
Message-ID: <20100606184334.GB30035@efreet.light.src>
References: <4C03D9C1.1060404@cedarsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schneider <mailings@cedarsoft.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 20:43:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLKp0-00073i-F3
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 20:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab0FFSnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 14:43:41 -0400
Received: from cuda1.bluetone.cz ([212.158.128.5]:53122 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab0FFSnk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 14:43:40 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by cuda1.bluetone.cz (Spam & Virus Firewall) with ESMTP
	id EAC3415A6ED5; Sun,  6 Jun 2010 20:43:34 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by cuda1.bluetone.cz with ESMTP id YAX2tZGGIs8NhaBo; Sun, 06 Jun 2010 20:43:34 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.71)
	(envelope-from <bulb@ucw.cz>)
	id 1OLKoo-0001eV-Gg; Sun, 06 Jun 2010 20:43:34 +0200
Content-Disposition: inline
In-Reply-To: <4C03D9C1.1060404@cedarsoft.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148535>

On Mon, May 31, 2010 at 17:46:09 +0200, Johannes Schneider wrote:
> I often run in that scenario:
> I see a small bugfix/typo/missing documentation. Of course I just add a
> bit of code to fix that issue...
> Then I'd like to commit that change as own commit. And most of the time
> this is possible without any problems (git commit <file>).
> But as I am *always* working on a topic branch, it takes some work to
> commit that change to another branch.

What I'd probably do is just commit the quick fix, as separate commit, where
I am. Than when I'd have a bit of time (probably when I'd otherwise think of
rebasing on master anyway) I'd rebase -i all such fixes to the bottom of the
topic branch, go to master and merge just those fixes. The rebase -i can be
against current master, so the merge back would be fast-forward, of course.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
