From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix pulling into the same branch.
Date: Sun, 11 Sep 2005 10:36:00 -0700
Message-ID: <7vk6hntslb.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043BA469@scsmsx401.amr.corp.intel.com>
	<7vzmr43vix.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0509111153380.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 19:37:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEVkO-0006BS-Q2
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 19:36:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVIKRgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 13:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVIKRgE
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 13:36:04 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:27627 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964976AbVIKRgC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 13:36:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050911173601.NMMO24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Sep 2005 13:36:01 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8303>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 26 Aug 2005, Junio C Hamano wrote:
>
>> Johannes, what do you think, as the original advocate of "push in
>> reverse"?
>
> I'm fine with it.

Wow, blast from the past ;-).

> Although it might make more sense to check for dirty state, and 
> fast-forward only for a clean state (together with a checkout of the new 
> HEAD).

Yes, but the issue becomes how we can reliably tell if a
repository is naked or has an associated working tree.  I've
seen people rsync only .git subdirectory of their live working
tree to publish to a public repository, which means their pulic
repository has <project>.git/index file, so it is kind of
tricky.
