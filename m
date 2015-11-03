From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git gc/prune runs again and again
Date: Tue, 3 Nov 2015 16:21:09 +0100
Message-ID: <20151103152109.GA15036@inner.h.apk.li>
References: <20151103124420.GA10946@inner.h.apk.li> <CACsJy8DMyjaZ_jKz4B93e6gSgV7ensORqxD-WYOYL9=9SV5tLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 16:43:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtdkR-00051j-4C
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 16:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbbKCPVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 10:21:19 -0500
Received: from continuum.iocl.org ([217.140.74.2]:58979 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297AbbKCPVN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 10:21:13 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id tA3FLAN16416;
	Tue, 3 Nov 2015 16:21:10 +0100
Content-Disposition: inline
In-Reply-To: <CACsJy8DMyjaZ_jKz4B93e6gSgV7ensORqxD-WYOYL9=9SV5tLw@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280800>

On Tue, 03 Nov 2015 16:01:24 +0000, Duy Nguyen wrote:
....
> > I have a bit of an annoying behaviour in git gc;
> > there is a repo I regularly do a fetch in, and
> > this kicks off a gc/prune every time. I remember
> > there being a heuristic with being that many files
> > in .git/objects/17 as the gc trigger.

(It might be a good idea to use a random slot here.)

...
> > What can I do there? (This git is a bit old, 2.2.2)
> 
> Run "git prune". 2.2.2 hides this suggestion to run git-prune in this
> case. The next git version will show it back.

Actually, there is a 'git prune --expire 2.weeks.ago --no-progress'
running under the 'git gc --auto --quiet', and I don't want to drop
the expiry time lightly.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
