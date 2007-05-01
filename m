From: =?iso-8859-1?Q?Thomas_H=FChn?= <newsgroups@thomas-huehn.de>
Subject: Re: git cvsimport fails
Date: Tue, 01 May 2007 17:54:46 +0200
Message-ID: <87abwomtdl.fsf@mid.thomas-huehn.de>
References: <87ejm0mtpy.fsf@mid.thomas-huehn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 01 17:55:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hiuh2-0004Vp-Iv
	for gcvg-git@gmane.org; Tue, 01 May 2007 17:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbXEAPzE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 1 May 2007 11:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbXEAPzE
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 11:55:04 -0400
Received: from main.gmane.org ([80.91.229.2]:38419 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988AbXEAPzB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 11:55:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hiugq-00005B-La
	for git@vger.kernel.org; Tue, 01 May 2007 17:54:56 +0200
Received: from p54a0c8d0.dip.t-dialin.net ([84.160.200.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 May 2007 17:54:56 +0200
Received: from newsgroups by p54a0c8d0.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 May 2007 17:54:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p54a0c8d0.dip.t-dialin.net
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:OLxU50esU8bfy6VrIJct88NE/I4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45954>

Thomas H=FChn <newsgroups@thomas-huehn.de> writes:

> I'm trying to import from a CVS repository and get this error message=
 at
> the end:
>
> |Commit ID 076fd7d71925bb551320aa20aa8eec68bf218f45
> |DONE.
> |fatal: Needed a single revision
> |Can merge only exactly one commit into empty head
> |Could not merge origin into the current branch.
>
> Is my git repo broken, is the CVS repo broken, is it just a shortcomi=
ng
> of cvsimport? Any idea whether it is fixable?

Okay, should have looked further for suitable git commands. git-fsck
tells me that HEAD is not a symbolic ref.

HEAD contains "ref: refs/heads/master", but refs/heads contains no
"master", just other files.

Can I find out, which hash master should point at?

Thomas
