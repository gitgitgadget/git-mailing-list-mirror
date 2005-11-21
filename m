From: "David S. Miller" <davem@davemloft.net>
Subject: Re: non-trivial merge failures
Date: Sun, 20 Nov 2005 20:17:12 -0800 (PST)
Message-ID: <20051120.201712.32582587.davem@davemloft.net>
References: <20051120.134945.104623647.davem@davemloft.net>
	<20051120221922.GB29291@mail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 05:17:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ee36u-0001ku-Dh
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 05:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVKUEQy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 23:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbVKUEQy
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 23:16:54 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:37805
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750905AbVKUEQx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 23:16:53 -0500
Received: from localhost ([127.0.0.1] ident=davem)
	by sunset.davemloft.net with esmtp (Exim 4.54)
	id 1Ee37A-0005zC-EN; Sun, 20 Nov 2005 20:17:12 -0800
To: rayl@mail.com
In-Reply-To: <20051120221922.GB29291@mail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12420>

From: Ray Lehtiniemi <rayl@mail.com>
Date: Sun, 20 Nov 2005 15:19:22 -0700

> On Sun, Nov 20, 2005 at 01:49:45PM -0800, David S. Miller wrote:
> > 
> > It looks like it's failing to import some python module called
> > "subprocess", and I aparently don't have that installed.
> > /usr/bin/python on this Debian box is aparently python-2.3, do
> > I need to be using python-2.4 for this merge stuff to work?
> 
> Define WITH_OWN_SUBPROCESS_PY in Makefile to install a copy of
> this module.

How about a version check at build or "make test" time so we can get a
sensible failure diagnostic instead of a weird cryptic "subprocess
import failure" when Python is too old? :-)

At least some better behavior than what we have now, where "make test"
still passes when you have this problem.
