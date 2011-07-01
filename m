From: =?utf-8?Q?R=C3=A9mi_Vanicat?= <vanicat@debian.org>
Subject: [Wishlist] could git tell which password it is asking when asking a password.
Date: Fri, 01 Jul 2011 15:59:09 +0200
Organization: none
Message-ID: <877h82nlua.dlv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 15:59:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QceFn-0007fq-15
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 15:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650Ab1GAN70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jul 2011 09:59:26 -0400
Received: from lo.gmane.org ([80.91.229.12]:60694 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756475Ab1GAN7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 09:59:25 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QceFg-0007d7-03
	for git@vger.kernel.org; Fri, 01 Jul 2011 15:59:24 +0200
Received: from 29.191.138.88.rev.sfr.net ([88.138.191.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 15:59:23 +0200
Received: from vanicat by 29.191.138.88.rev.sfr.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 15:59:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 29.191.138.88.rev.sfr.net
User-Agent: Gnus/5.110016 (No Gnus v0.16) Emacs/23.3 (gnu/linux)
Cancel-Lock: sha1:SF3mponPGCchBcDBONv3qysjyNs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176522>

Hello,

When git is asking for a password (for example for pushing over https)
it call the $GIT_ASKPASS script with only "Password: " as a an argument=
,
so when one have several remote, it might not know which one is asking
the password.=20

It would be interesting also to plug some sort of password-safe unto
git, or some "git-agent".=20
--=20
R=C3=A9mi Vanicat
