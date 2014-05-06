From: Damien Robert <damien.olivier.robert+gmane@gmail.com>
Subject: Re: Summary of the problems with git pull
Date: Tue, 6 May 2014 20:03:15 +0000 (UTC)
Message-ID: <lkbf63$p8l$1@ger.gmane.org>
References: <5366db742d494_18f9e4b308aa@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 22:37:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whm44-0001yQ-6x
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 22:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbaEFUeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 16:34:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:49850 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751228AbaEFUeF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 16:34:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WhltL-0005tX-Dm
	for git@vger.kernel.org; Tue, 06 May 2014 22:23:07 +0200
Received: from phare.normalesup.org ([129.199.129.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 May 2014 22:23:07 +0200
Received: from damien.olivier.robert+gmane by phare.normalesup.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 May 2014 22:23:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: phare.normalesup.org
X-Newsreader: Flrn (0.9.20070704)
X-Start-date: Tue, 06 May 2014 22:00:36 +0200 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248246>

Felipe Contreras  wrote in message
<5366db742d494_18f9e4b308aa@nysa.notmuch>:
> == git update ==
> 
> Another proposed solution is to have a new command: `git update`. This
> command would be similar to `git pull --ff-only` by default, but it
> could be configured to do merges instead, and when doing so in reverse.

Thanks for the nice summary.

As a user, I am very much in favor of adding a `git update` command. In
fact I already have a ruby script that does such a thing (fast-forward all my
local branches that have an upstream configured), so it would be nice to
have it directly in git core.
