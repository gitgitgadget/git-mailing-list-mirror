From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Remote's 'currently active branch' not HEAD?
Date: Tue, 3 Sep 2013 14:37:33 +0200
Message-ID: <20130903123733.GR12966@inner.h.apk.li>
References: <20130903104652.GA5813@inner.h.apk.li> <20130903114831.GA8559@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 03 14:37:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGprZ-0003sn-AC
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 14:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847Ab3ICMhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 08:37:37 -0400
Received: from continuum.iocl.org ([217.140.74.2]:48521 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408Ab3ICMhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 08:37:36 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r83CbX510760;
	Tue, 3 Sep 2013 14:37:33 +0200
Content-Disposition: inline
In-Reply-To: <20130903114831.GA8559@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233722>

On Tue, 03 Sep 2013 13:48:31 +0000, Andreas Krey wrote:
...
> I now have a sample repo that reproduces this behaviour.
> Unpack tar file, clone, see clone having 'wrong' branch
> checked out, apparently independent of the transport:

Ouch, it looks like 'git clone' doesn't actually know
the 'current remote branch' but picks one of those that
happen to have the HEAD *commit* as their tip.

At least the 'git clone' doc would be misleading then.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
