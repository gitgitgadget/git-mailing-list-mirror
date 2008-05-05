From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git and peer review
Date: Mon, 5 May 2008 15:48:31 +0200
Message-ID: <20080505134831.GA12733@diana.vm.bytemark.co.uk>
References: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com> <87k5i9u8f1.fsf@nav-akl-pcn-343.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Toby Allsopp <Toby.Allsopp@navman.co.nz>
X-From: git-owner@vger.kernel.org Mon May 05 15:50:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt14y-0005LQ-0B
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 15:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727AbYEENtT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2008 09:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754412AbYEENtT
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 09:49:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3028 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753288AbYEENtT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 09:49:19 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Jt13P-0003ed-00; Mon, 05 May 2008 14:48:31 +0100
Content-Disposition: inline
In-Reply-To: <87k5i9u8f1.fsf@nav-akl-pcn-343.mitacad.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81282>

On 2008-05-05 08:21:54 +1200, Toby Allsopp wrote:

> At the moment I'm using gitk to step through the patch series along
> with the patch to gitk that adds a context-menu entry to lauch an
> external diff tool when a side-by-side diff is easier to read.
>
> This is okay, but it's a bit of a pain to make changes while the
> review is in progress (git rebase -i, s/pick/edit on the appropriate
> line, make changes, git commit --amend, git rebase --continue).
> Perhaps stgit or guilt would help with this.

Yes, StGit helps here. "stg edit <patchname>" lets you edit the commit
message of any patch.

( In the master branch, but not yet released, is an emacs mode for
  StGit. It displays the list of patches (name + first line of commit
  message), and you can press "=3D" to view the patch (including the
  commit message), and "e" to edit its commit message. )

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
