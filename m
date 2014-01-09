From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [BUG] "git rebase": fatal: Not a valid object name: ''
Date: Thu, 9 Jan 2014 17:06:03 +0100
Message-ID: <20140109160603.GR7102@inner.h.apk.li>
References: <CAOBEgJjmoXEDVa4L5LbAGMYR7_+NCf2tDSveieZxtU4bfWyzDw@mail.gmail.com> <20140109153618.GA18975@inner.h.apk.li> <20140109155620.GH7608@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Jan 09 17:06:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1I7k-0004K2-Uw
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 17:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbaAIQGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 11:06:15 -0500
Received: from continuum.iocl.org ([217.140.74.2]:51426 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbaAIQGK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 11:06:10 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id s09G63Q20579;
	Thu, 9 Jan 2014 17:06:03 +0100
Content-Disposition: inline
In-Reply-To: <20140109155620.GH7608@serenity.lan>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240259>

On Thu, 09 Jan 2014 15:56:21 +0000, John Keeping wrote:
...
> I think the correct fix is to change the "$switch_to" in the call to
> "git merge-base --fork-point" to "${switch_to:-HEAD}", but I'm not at a
> machine where I can test that or work up a patch at the moment...

Thanks, looks plausible and works. Need to catch train myself now.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
