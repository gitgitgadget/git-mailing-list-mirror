From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: Usability of git stash
Date: Sat, 18 Oct 2008 11:26:08 +0200
Message-ID: <87prly5k5r.fsf@cup.kalibalik.dk>
References: <87wsg9acfv.fsf@cup.kalibalik.dk>
	<nKimSsYZj6xfGNCQS3i5cRwnWQfbHrtUrwdGB2zGWVfMOcfZMwJDKg@cipher.nrlssc.navy.mil>
	<86vdvsg4up.fsf@lola.quinscape.zz>
	<vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Oct 18 11:27:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kr862-0002YO-9s
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 11:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbYJRJ0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 05:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbYJRJ0M
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 05:26:12 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:59488 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbYJRJ0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 05:26:11 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id E44EE14062;
	Sat, 18 Oct 2008 11:26:09 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 98A4D1405A;
	Sat, 18 Oct 2008 11:26:09 +0200 (CEST)
In-Reply-To: <vCcONcOJu3QKQyRgPdT5Dws3F2P25RNAFOgM5GX6FWWKJe40papCRw@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu\, 16 Oct 2008 10\:22\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98532>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> In exchange for allowing new users to stub their toe on new commands, the
> work flow of more experienced users is made a little easier.

I wonder whether experienced users even use stash a lot. Personally,
after getting my head around the DAG, and thus getting more
comfortable with git reset, I tend to make "WIP" commits instead.

After having used "git stash clear" at a bad time once, I am wary of
stashing work that I actually want to keep. I prefer workflows where
my mistakes can be (easily) corrected.


The primary thing that stash does for me is preserve the index state.
Unfortunately, --index is not default for stash apply, so I often
forget it.

Sometimes, I also want stash to store away changes to untracked files
(to get a clean working directory), but that is not possible.


Maybe I just don't quite understand what git stash is about ...


Anders.
