From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: Importing from CVS issues
Date: Tue, 16 Aug 2005 14:16:15 +0200
Message-ID: <u5toe7y2i28.fsf@fidgit.hq.vtech>
References: <1124188894.7444.9.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 16 14:19:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E50Ov-0008Dl-QZ
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 14:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932675AbVHPMSY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 Aug 2005 08:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVHPMSY
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 08:18:24 -0400
Received: from main.gmane.org ([80.91.229.2]:8424 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932675AbVHPMSX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 08:18:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E50N4-0007ma-NT
	for git@vger.kernel.org; Tue, 16 Aug 2005 14:16:46 +0200
Received: from gorgon.vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 14:16:46 +0200
Received: from davidk by gorgon.vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Aug 2005 14:16:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: gorgon.vtab.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:di5jltV54Wl/mL5Md46J4dxp0Fo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Alex Bennee <kernel-hacker@bennee.com> writes:

> Before the import script finally dies with:
>
> WARNING: revision 1.3.2.1 of file
> scripts/xmltools/t/data/gzip/DO-NOT-BACKUP on unnamed branch
> DONE; creating master branch
> cp: cannot stat `/export/test/cvstogit/.git/refs/heads/origin': No su=
ch
> file or directory

Was this done with an empty destination dir?  I've seen similar things
happen in a dir where an interrupted cvs import was done previously,
and the 'origin' branch was never created.

--=20
David K=E5gedal
