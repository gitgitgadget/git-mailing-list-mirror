From: Mitchell Blank Jr <mitch@sfgoth.com>
Subject: Re: [ANNOUNCE] gitfs pre-release 0.03
Date: Fri, 18 Nov 2005 12:50:19 -0800
Message-ID: <20051118205019.GH87234@gaz.sfgoth.com>
References: <20051118124532.GG87234@gaz.sfgoth.com> <34a7ae040511180620v5f6ac014g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 21:35:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdCxg-0006FM-01
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161197AbVKRUfG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbVKRUfF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:35:05 -0500
Received: from gaz.sfgoth.com ([69.36.241.230]:42222 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1161197AbVKRUfB (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 15:35:01 -0500
Received: from gaz.sfgoth.com (localhost.sfgoth.com [127.0.0.1])
	by gaz.sfgoth.com (8.12.10/8.12.10) with ESMTP id jAIKoJi0045640;
	Fri, 18 Nov 2005 12:50:19 -0800 (PST)
	(envelope-from mitch@gaz.sfgoth.com)
Received: (from mitch@localhost)
	by gaz.sfgoth.com (8.12.10/8.12.6/Submit) id jAIKoJes045639;
	Fri, 18 Nov 2005 12:50:19 -0800 (PST)
	(envelope-from mitch)
To: Paolo Teti <paolo.teti@gmail.com>
Content-Disposition: inline
In-Reply-To: <34a7ae040511180620v5f6ac014g@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Fri, 18 Nov 2005 12:50:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12258>

Paolo Teti wrote:
> A question: the gitFS in your intent has to became a "clone" of the
> Rational MultiVersion File System?

Well, I guess I can't give a real solid answer since I've never used
Rational and I'm only vaguely aware of its capabilities.  However I think
the answer is "no".  My personal belief is that the filesystem abstraction
isn't a good fit to be the main interface to an SCM, especially git.
That's why I'm currently working on just visualizing the contents of the
git repository and I'll add features on top of that as they seem to make
sense.

-Mitch
