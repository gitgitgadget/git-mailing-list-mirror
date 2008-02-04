From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: New to git: sorry for obvious question.
Date: Mon, 04 Feb 2008 15:10:38 +0200
Message-ID: <47A70ECE.2040606@panasas.com>
References: <47A6E130.7090909@glidos.net> <20080204105006.GA15855@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Paul Gardiner <osronline@glidos.net>, git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 14:11:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM16t-0005Vo-Oz
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 14:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785AbYBDNLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 08:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbYBDNLJ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 08:11:09 -0500
Received: from bzq-219-195-70.pop.bezeqint.net ([62.219.195.70]:45915 "EHLO
	bh-buildlin2.bhalevy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbYBDNLI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 08:11:08 -0500
Received: from bh-buildlin2.bhalevy.com (localhost.localdomain [127.0.0.1])
	by bh-buildlin2.bhalevy.com (8.14.1/8.14.1) with ESMTP id m14DAcFl003631;
	Mon, 4 Feb 2008 15:10:39 +0200
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <20080204105006.GA15855@bit.office.eurotux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72501>

On Mon, Feb 04 2008 at 12:50 +0200, Luciano Rocha <luciano@eurotux.com> wrote:
> On Mon, Feb 04, 2008 at 09:56:00AM +0000, Paul Gardiner wrote:
>>  Hi,
>>
>>  I've moved a project from CVS on sourceforge to git on repo.or.cz.  I
>>  want a local mirror on my own home server, so that it appears amongst
>>  the projects shown by my own gitweb set up, and so it gets caught by
>>  my backup system.  I've created the mirror with
>>
>>    git clone --bare <remote-url> <local-dir>
>>
>>  and that seems fine.  But how do I now keep it up to date.  I was
>>  guessing a cron job doing some sort of git pull, but pull doesn't
>>  look to work on --bare proj.git type repositories.
> 
> You want git fetch. Git pull also updates the working copy, which you
> don't have.
> 
> Also, git clone --bare doesn't set up the origin configuration, and I
> have to do it by hand:
>   git config remote.origin.url "$url"
>   git config remote.origin.fetch "+refs/heads/*:refs/heads/*"
> 
Better do "git-remote add URL" then manual addition as above.

Boaz
