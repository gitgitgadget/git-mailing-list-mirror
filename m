From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: Re: [PATCH] document that git-tag can tag more than heads
Date: Thu, 24 Jul 2008 11:48:04 +0300
Message-ID: <87prp3652z.fsf@Astalo.kon.iki.fi>
References: <Pine.GSO.4.62.0807240000470.23113@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 10:48:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLwUw-00026h-Nf
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 10:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbYGXIrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 04:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbYGXIra
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 04:47:30 -0400
Received: from 85-23-32-88-Rajakyla-TR1.suomi.net ([85.23.32.88]:43821 "EHLO
	Astalo.kon.iki.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751279AbYGXIr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 04:47:29 -0400
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1KLwUW-0006Va-4t; Thu, 24 Jul 2008 11:48:04 +0300
In-Reply-To: <Pine.GSO.4.62.0807240000470.23113@harper.uchicago.edu> (Jonathan
	Nieder's message of "Thu, 24 Jul 2008 00:01:34 -0500 (CDT)")
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89854>

Jonathan Nieder <jrnieder@uchicago.edu> writes:

> Samuel Bronson had the idea of putting "<commit-ish> | <object>"
> for "<object>" because most tags point to commits (and for the
> rest of the manpage, all tags point to commits).

But the argument is not a <commit-ish>.  git.txt says:

        A command that takes a <commit-ish> argument ultimately
	wants to operate on a <commit> object but automatically
	dereferences <tag> objects that point at a <commit>.

git-tag does not automatically dereference tag objects that
point to a commit.  So if you want to use "|", then it should be
"<commit> | <object>".
