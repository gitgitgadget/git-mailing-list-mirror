From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: how the commit ID come from in GIT?
Date: Tue, 6 Nov 2012 03:04:32 +0400
Message-ID: <20121105230430.GK5210@localhost.localdomain>
References: <1352145846.26267.YahooMailClassic@web141404.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hong zhang <henryzhang62@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:05:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVVjD-00075j-38
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 00:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886Ab2KEXEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 18:04:38 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:53277 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964824Ab2KEXEh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 18:04:37 -0500
Received: from proxysrv.domain007.com (localhost [10.8.0.42] (may be forged))
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id qA5N4XGJ012036;
	Tue, 6 Nov 2012 03:04:34 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 495B9B22ED9; Tue,  6 Nov 2012 03:04:33 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <1352145846.26267.YahooMailClassic@web141404.mail.bf1.yahoo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209090>

On Mon, Nov 05, 2012 at 12:04:06PM -0800, hong zhang wrote:

> Could anyone explain how the git commit ID will include all the files
> that devloper makes changes on?
> 
> How git commit ID works?

To expand on the answer provided by Magnus, I would also suggest reading
the classic "Git from the bottom up" document [1], and if you want a
totally informal and fun introduction to how these cryptographic hashes
come about and why they are useful, I suggest reading
"The Git Parable" [2].

1. http://newartisans.com/2008/04/git-from-the-bottom-up/
2. http://tom.preston-werner.com/2009/05/19/the-git-parable.html
