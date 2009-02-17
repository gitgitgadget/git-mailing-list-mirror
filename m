From: Alan <alan@clueserver.org>
Subject: Rebase v.s. fast forward
Date: Tue, 17 Feb 2009 15:50:04 -0800
Message-ID: <1234914604.3334.7.camel@rottwang.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 00:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZZix-0005tg-SY
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbZBQXuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752973AbZBQXuH
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:50:07 -0500
Received: from 216-99-213-120.static.dsl.aracnet.com ([216.99.213.120]:35337
	"EHLO clueserver.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbZBQXuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:50:06 -0500
Received: from [127.0.0.1] (blackbox.fnordora.org [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 5E44CF504FB
	for <git@vger.kernel.org>; Tue, 17 Feb 2009 15:50:05 -0800 (PST)
X-Mailer: Evolution 2.25.90 (2.25.90-2.fc11) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110480>

I am dealing with a kernel branch of a branch that undergoes frequent
rebases and I want to know the easiest way of handling things.

The tree is pulled from kernel.org. Patches are applied to the tree by a
developer here on a branch.  I take that branch, make my own branch, add
drivers and other modifications and publish to a different repo.

Now that 2.6.29 is occurring, every time there is a new RC candidate, he
rebases the tree and tells everyone to rebuild.  Since the developers on
my projects have their own branches off of my tree, rebuilding
everything is starting to look like a big pain.

Is there a way to take a rebased repository and apply the changes in a
manner that does not require reconstructing everything from patches?

Can you fast forward on a rebased repo or are you just hosed?  (Or would
that be considered "frebasing"?)
