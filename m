From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: git-cvs-import-script problems
Date: Fri, 05 Aug 2005 12:14:27 +0200
Message-ID: <u5tfytoitbw.fsf@fidgit.hq.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Aug 05 13:32:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E10Pz-0008TC-Qp
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 13:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbVHELa4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 5 Aug 2005 07:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbVHELa4
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 07:30:56 -0400
Received: from main.gmane.org ([80.91.229.2]:58256 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262986AbVHELay (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 07:30:54 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1E10Ow-0008Io-Fj
	for git@vger.kernel.org; Fri, 05 Aug 2005 13:30:10 +0200
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Aug 2005 13:30:10 +0200
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Aug 2005 13:30:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:XL8LYcHQju4JScfkN0QaiI+NVlU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I just tried importing a large CVS repository to git, using "git
cvsimport".  It managed to import a lot of files and revisions, but
half-way through, it stopped with this message:

  Unknown: F

As far as I can till, this "F" probably came from the CVS server
process.  Could it be that my CVS is too new or too old?

I'm using git b03e2d2091153d239063cfc086a840d74a9eadde,  cvs 1.11.20,
cvsps 2.1, and the CVS repository is a local directory.

Also, when the process stops, I have .git/HEAD pointing to
refs/heads/master (which doesn't exist).  I thought it would be
pointing to refs/heads/origin.

--=20
David K=E5gedal
