From: Andreas Krey <a.krey@gmx.de>
Subject: Re: first parent, commit graph layout, and pull merge direction
Date: Thu, 23 May 2013 21:25:12 +0200
Message-ID: <20130523192512.GR9448@inner.h.apk.li>
References: <20130522115042.GA20649@inner.h.apk.li> <7v4ndukhx0.fsf@alter.siamese.dyndns.org> <20130523090657.GB23933@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 21:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufb8d-0001Jk-S4
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 21:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758481Ab3EWTZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 15:25:20 -0400
Received: from continuum.iocl.org ([217.140.74.2]:39256 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758248Ab3EWTZT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 15:25:19 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id r4NJPCr20096;
	Thu, 23 May 2013 21:25:12 +0200
Content-Disposition: inline
In-Reply-To: <20130523090657.GB23933@inner.h.apk.li>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225285>

On Thu, 23 May 2013 11:06:57 +0000, Andreas Krey wrote:
...
> ...
> > Don't do that, then.

Ouch, you're right. The problem is not actually in the
pull; only the *last* pull into a feature branch that
then get pushed back ff to master needs to be reversed.

And at that time you don't know it's the last one
-> swap parents before the push if necessary.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
