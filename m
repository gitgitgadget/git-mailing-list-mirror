From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: [PATCHv2] Documentation/git-submodule.txt: Add Description section
Date: Wed, 16 Jul 2008 22:15:26 +0300
Message-ID: <87d4ldvdwx.fsf@Astalo.kon.iki.fi>
References: <20080715183705.GD4379@zakalwe.fi>
	<20080716184248.6524.38463.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 21:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCUI-000369-5y
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490AbYGPTP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755990AbYGPTP3
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:15:29 -0400
Received: from 85-23-32-88-Rajakyla-TR1.suomi.net ([85.23.32.88]:53010 "EHLO
	Astalo.kon.iki.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754979AbYGPTP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:15:28 -0400
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1KJCTG-00045K-98; Wed, 16 Jul 2008 22:15:26 +0300
In-Reply-To: <20080716184248.6524.38463.stgit@localhost> (Petr Baudis's
	message of "Wed, 16 Jul 2008 20:44:12 +0200")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88728>

Petr Baudis <pasky@suse.cz> writes:

> +Submodules are a special kind of tree entries which refer to a particular tree
> +in another repository (living at a given URL).  The tree entry describes
> +the existence of a submodule with the given name and the exact revision that
> +should be used, while the location of the repository is described in the
> +`/.gitmodules` file.

I was surprised to learn that a commit ID in a tree does not
prevent Git from pruning the corresponding commit object if
one happens to exist in the same repository.  That might be
best documented under "Tree Object" in user-manual.txt though,
rather than in git-submodule.txt.
