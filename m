From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Why does gpg.program work for commit but not log?
Date: Wed, 18 Jun 2014 00:18:35 -0400
Organization: PD Inc
Message-ID: <ABACA8639E2A49BA8A1E602DBE815867@black>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 18 06:18:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx7Kb-0002Nc-JV
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 06:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbaFRESh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 00:18:37 -0400
Received: from mail.pdinc.us ([67.90.184.27]:47490 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbaFRESh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 00:18:37 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5I4IZr8016712
	for <git@vger.kernel.org>; Wed, 18 Jun 2014 00:18:36 -0400
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Thread-Index: Ac+KrF9xGOocgT7DSneym8Kd9mJWjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251966>

jpyeron@black /projects/microsoft-smartcard-sign/tmp
$ git --version
git version 1.7.9
jpyeron@black /projects/microsoft-smartcard-sign/tmp
$ GIT_TRACE=1 git commit -S -m 'bin'
trace: built-in: git 'commit' '-S' '-m' 'bin'
trace: run_command: '/projects/microsoft-smartcard-sign/tmp/bin/logginggpg.sh'
'-bsau' 'Jason Pyeron <jpyeron+test3@pdinc.us>'
gpg: WARNING: using insecure memory!
gpg: please see http://www.gnupg.org/documentation/faqs.html for more
information

You need a passphrase to unlock the secret key for
user: "Jason Pyeron <jpyeron+test3@pdinc.us>"
2048-bit RSA key, ID 54D0E8E4, created 2014-06-18

[master 38afa1f] bin
 1 files changed, 19 insertions(+), 0 deletions(-)
 create mode 100755 bin/logginggpg.sh

jpyeron@black /projects/microsoft-smartcard-sign/tmp
$ GIT_TRACE=1 git log --show-signature
trace: built-in: git 'log' '--show-signature'
trace: run_command: 'less'
trace: exec: 'less'
trace: run_command: 'gpg' '--verify' '/tmp/.git_vtag_tmpNLFqtm' '-'
commit 38afa1f4d0c73fd47d5788310a1a2080aa0abbba
gpg: WARNING: using insecure memory!
gpg: please see http://www.gnupg.org/documentation/faqs.html for more
information
gpg: Signature made Wed, Jun 18, 2014  0:11:40 EDT using RSA key ID 54D0E8E4
gpg: Good signature from "Jason Pyeron <jpyeron+test3@pdinc.us>"
Author: Jason Pyeron <jpyeron+test3@pdinc.us>
Date:   Wed Jun 18 00:11:40 2014 -0400

    bin
trace: run_command: 'gpg' '--verify' '/tmp/.git_vtag_tmp41t6O6' '-'

commit 174d4544627883c4b03a9b888c2d2c127accefa5
gpg: WARNING: using insecure memory!
gpg: please see http://www.gnupg.org/documentation/faqs.html for more
information
gpg: Signature made Wed, Jun 18, 2014  0:08:39 EDT using RSA key ID 54D0E8E4
gpg: Good signature from "Jason Pyeron <jpyeron+test3@pdinc.us>"
Author: Jason Pyeron <jpyeron+test3@pdinc.us>
Date:   Wed Jun 18 00:08:39 2014 -0400

    loged signed commit
trace: run_command: 'gpg' '--verify' '/tmp/.git_vtag_tmpo6b0D3' '-'

commit 4f7ad8a8f38b06d675ac5196c80b1a26ecbee433
gpg: WARNING: using insecure memory!
gpg: please see http://www.gnupg.org/documentation/faqs.html for more
information
gpg: Signature made Tue, Jun 17, 2014 23:18:01 EDT using RSA key ID 54D0E8E4
gpg: Good signature from "Jason Pyeron <jpyeron+test3@pdinc.us>"
Author: Jason Pyeron <jpyeron+test3@pdinc.us>
Date:   Tue Jun 17 23:17:55 2014 -0400

    test signed commit

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
