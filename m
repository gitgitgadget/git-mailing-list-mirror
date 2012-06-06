From: John Wiegley <jwiegley@gmail.com>
Subject: Please revert e371046b6473907aa6d62b7862a3afe9d33561e1
Date: Wed, 06 Jun 2012 05:28:51 -0500
Message-ID: <m24nqoohss.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 12:35:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScDa5-0000FV-2T
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 12:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652Ab2FFKfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 06:35:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:43115 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713Ab2FFKfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 06:35:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ScDZw-000094-Cy
	for git@vger.kernel.org; Wed, 06 Jun 2012 12:35:04 +0200
Received: from c-98-215-105-167.hsd1.il.comcast.net ([98.215.105.167])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 12:35:04 +0200
Received: from jwiegley by c-98-215-105-167.hsd1.il.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 12:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-98-215-105-167.hsd1.il.comcast.net
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.1 (darwin)
Cancel-Lock: sha1:Szgsa7RsQOXChzuojx4USi4j8Es=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199311>

I've spoken to the author of this commit, Matthias Urlichs.  Here is an
excerpt of our conversation:

> On Sat, 2012-04-21 at 00:08 -0500, John Wiegley wrote:
> > Just wanted to let you know that this bit me.  I have a client whose CVS
> > repository I'm converting to Git, and they have _many_ log messages that
> > are larger than 32k in size.
> 
> Feel free to submit a patch that reverts this. These days, there's probably
> no user of cvs2git left, but at that time it was important to get the same
> commit IDs back.

This just needs to be reverted:

    git revert e371046b6473907aa6d62b7862a3afe9d33561e1

Thanks,
  John
