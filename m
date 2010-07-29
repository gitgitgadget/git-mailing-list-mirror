From: Samir Faci <samir@esamir.com>
Subject: Git CVS Import Questions
Date: Thu, 29 Jul 2010 09:17:38 -0500
Message-ID: <AANLkTin_d_wKxyJDMbjz4vFacr6GNYzE_aUGi2vbXW3V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 29 16:23:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeU0t-0008Jc-SO
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 16:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757582Ab0G2ORp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 10:17:45 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44196 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757576Ab0G2ORo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 10:17:44 -0400
Received: by pvc7 with SMTP id 7so108407pvc.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 07:17:43 -0700 (PDT)
Received: by 10.114.112.13 with SMTP id k13mr171056wac.211.1280413058766; Thu, 
	29 Jul 2010 07:17:38 -0700 (PDT)
Received: by 10.229.30.139 with HTTP; Thu, 29 Jul 2010 07:17:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152176>

I have a question about git cvs's import.

I have the following setup in ~/.bashrc:

export CVS_RSH=ssh
export CVSROOT=cvs:/cvs
export CVS_RSH CVSROOT

and I can do a cvs import using git by doing something along these lines:

mkdir bar; git cvsimport -v Foo/Bar   which checks out the history of
module Bar into the current directory (in this case bar)

now... if I do this again in another directory

mkdir bar2; git cvsimport -v Foo/Bar  which repeats the same process
the hashes don't match up.

case in point:
git log --oneline | head -n 1
2fa5b70 ChangeLog:     * Fixing build file syntax error.
git log --oneline | head -n 1
ccef115 ChangeLog:     * Fixing build file syntax error.


Now, correct me if I'm wrong.. but I thought the hashes were generated
based on the content of the diff.  So shouldn't two cvs checkouts
containing the same data
have the same hashes?   ie.  If a git commit is generated based on a
particular diff, then the hash should always be the same, should it
not?

Am I missing something?  I'm just trying to understand the behavior...
-- 
--
Samir Faci
*insert title*
fortune | cowsay -f /usr/share/cows/tux.cow
