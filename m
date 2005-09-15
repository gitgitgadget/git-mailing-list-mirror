From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: git version
Date: Thu, 15 Sep 2005 15:47:48 +0200
Message-ID: <u5tzmqeqw6z.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Sep 15 15:57:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFuBe-0002zR-1I
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 15:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbVIONx4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 15 Sep 2005 09:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030421AbVIONx4
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 09:53:56 -0400
Received: from main.gmane.org ([80.91.229.2]:20928 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030425AbVIONxz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 09:53:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EFu8S-0001ts-Ue
	for git@vger.kernel.org; Thu, 15 Sep 2005 15:50:45 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 15:50:44 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 15:50:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:S57O4ePbFZERwK4fczf3Rj5Lg5Y=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8604>

Why is "git --version" called so, and not "git version"?  It works
just like any other command, except that it is implemented internally
in the git script.

The "git" command takes a subcommand that does some action or simply
prints some informational output.  The "version" subcommand fits
nicely into that, and I don't see any need to prepend "--" to it.

--=20
David K=E5gedal
