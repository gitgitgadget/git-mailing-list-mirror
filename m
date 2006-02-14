From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: bug: stgit doesn't handle branch names with / in them
Date: Tue, 14 Feb 2006 18:35:09 +0100
Message-ID: <20060214173509.GA8666@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 18:36:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F945D-00076z-V2
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 18:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422695AbWBNRfU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Feb 2006 12:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422696AbWBNRfT
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 12:35:19 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:32783 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1422695AbWBNRfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 12:35:18 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1F944z-0002K9-00; Tue, 14 Feb 2006 17:35:09 +0000
To: Catalin Marinas <catalin.marinas@arm.com>
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16144>

"stg branch -l" only shows branches directly under refs/heads, and
completely ignores branches in subdirectories. But it does print the
name of the subdirectories . . .

"stg branch" prints only the part of the branch name following the
final slash.

    $ git-branch
      kha/abc123
      kha/dab
    * kha/patches
      kha/powerup
      kha/dare
      kha/dare-build
      kha/boo123
      kha/lisp106
      local/test0
      local/test3
      local/test4
      SVN-import
      test5

    $ stg branch -l
    Available branches:
            SVN-import  |
            kha         |
            local       |
            test5       |

    $ stg branch
    patches

No patch (yet), sorry.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
