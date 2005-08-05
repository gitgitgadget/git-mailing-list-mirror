From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: git-cvs-import-script problems
Date: Fri, 05 Aug 2005 16:46:51 +0200
Message-ID: <u5tslxoh25g.fsf@fidgit.hq.vtech>
References: <u5tfytoitbw.fsf@fidgit.hq.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Aug 05 17:05:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E13jm-000714-GR
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 17:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbVHEO6C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 5 Aug 2005 10:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVHEOzQ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 10:55:16 -0400
Received: from main.gmane.org ([80.91.229.2]:55446 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262307AbVHEOyR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Aug 2005 10:54:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E13XH-0004jM-Oz
	for git@vger.kernel.org; Fri, 05 Aug 2005 16:50:59 +0200
Received: from gorgon.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Aug 2005 16:50:59 +0200
Received: from davidk by gorgon.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 05 Aug 2005 16:50:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gorgon.vtab.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:/L6d/IEbw07HIrfTqkiwXMt59Q4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

David K=E5gedal <davidk@lysator.liu.se> writes:

> I just tried importing a large CVS repository to git, using "git
> cvsimport".  It managed to import a lot of files and revisions, but
> half-way through, it stopped with this message:
>
>   Unknown: F
>
> As far as I can till, this "F" probably came from the CVS server
> process.  Could it be that my CVS is too new or too old?

Upgrading to CVS 1.12.1 seems to have helped.

--=20
David K=E5gedal
