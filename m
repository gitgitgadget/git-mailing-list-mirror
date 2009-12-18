From: Andreas Krey <a.krey@gmx.de>
Subject: Re: [RFC/PATCH] branch: new option --will-track
Date: Fri, 18 Dec 2009 07:18:51 +0100
Message-ID: <20091218061851.GA10221@inner.home.ulmdo.de>
References: <1260956399-13802-1-git-send-email-cxreg@pobox.com> <7vaaxhdu1f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 07:28:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLWKf-0002lq-SF
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 07:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbZLRG2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 01:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbZLRG2w
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 01:28:52 -0500
Received: from continuum.iocl.org ([213.146.114.200]:61013 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZLRG2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 01:28:51 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Dec 2009 01:28:51 EST
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id nBI6Ip412873;
	Fri, 18 Dec 2009 07:18:51 +0100
Content-Disposition: inline
In-Reply-To: <7vaaxhdu1f.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135403>

On Thu, 17 Dec 2009 16:07:08 +0000, Junio C Hamano wrote:
...
> Also "git pull --remember $there $this" might be a good way to tell the
> configuration mechanism from the UI to remember that "I always want to
> merge $this branch from $there while on the branch I am currently on", and
> its implementation may probably use "git branch --reconfigure" internally.

Actually my favorite would be 'git push --track $there', pushing
the current local branch to $there and setting up tracking. That
way the tracking decision need not be made before the remote
branch actually exists.

Andreas
