From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Like commit -a, but...
Date: Mon, 5 Nov 2012 21:56:28 +0100
Message-ID: <20121105205628.GG21244@inner.h.apk.li>
References: <20121105202948.GA17505@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 21:56:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVTiu-00038O-AA
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 21:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905Ab2KEU4b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 15:56:31 -0500
Received: from continuum.iocl.org ([217.140.74.2]:35668 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121Ab2KEU4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 15:56:31 -0500
X-Greylist: delayed 1599 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Nov 2012 15:56:30 EST
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id qA5KuSm18715;
	Mon, 5 Nov 2012 21:56:28 +0100
Content-Disposition: inline
In-Reply-To: <20121105202948.GA17505@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209082>

On Mon, 05 Nov 2012 21:29:48 +0000, Andreas Krey wrote:
...
> But still I'd like to know if there is a cleaner solution,
> esp. with respect to the index.

Actually, it seems

 commit -m 'index'
 commit -a -m 'worktree'
 ...push
 git reset HEAD^
 git reset --soft HEAD^

might do the index trick.

But is there a direct way to convert the current working tree into a
tree object?

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
