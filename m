From: David Kastrup <dak@gnu.org>
Subject: Can I have this, pretty please?
Date: Sun, 12 Aug 2007 15:23:47 +0200
Message-ID: <85ir7kq42k.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 15:23:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKDQA-0006tW-Ru
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 15:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbXHLNXv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 09:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933811AbXHLNXv
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 09:23:51 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:33399 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603AbXHLNXu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 09:23:50 -0400
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 36E7C24AE0B
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 15:23:49 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 15ECBABAE0
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 15:23:49 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-036-190.pools.arcor-ip.net [84.61.36.190])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id CBD663BE22
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 15:23:48 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E61791C3C79D; Sun, 12 Aug 2007 15:23:47 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3934/Sun Aug 12 03:59:08 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55682>


Hi,

I have more or less brought my system to a stillstand by trying to
visualize branches and histories: the graphical tools really suck
resources.

So I have been thinking how I could use Emacs, and how to cache what
efficiently, and put out information just on-demand and so on.

And then it struck me: Emacs has a very efficient browser for linked
one-line information that can be expanded into complete changesets
with diffs inside.  It is called "Gnus".  A newsreader.

Mapping a repository into newsgroups (one per branch head?), complete
with threads, references, header display, article fetch (by
git-format-patch), Message Ids (=commit id) is much more
straightforward than creating an HTML server.  And it means that
everybody can use his favorite newsreader for navigating a repository.

Even when we are talking about readonly access, this would be simply
great and at once make for a whole bunch of existing tools that would
provide much better options in many respects than existing
git-specific repository browsers for going through commit histories.

And the possibilities for write access are at least intriguing.

So a lightweight nntp server serving git commits as articles would be
really cool.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
