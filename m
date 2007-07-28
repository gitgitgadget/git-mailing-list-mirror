From: Insitu <abailly@oqube.com>
Subject: Newbie problem
Date: Sat, 28 Jul 2007 09:20:22 +0200
Organization: OQube
Message-ID: <87vec5vvt5.fsf@osquare.oqube.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 09:30:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEgkc-0001cx-W7
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 09:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760827AbXG1HaF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 28 Jul 2007 03:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760653AbXG1HaF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 03:30:05 -0400
Received: from main.gmane.org ([80.91.229.2]:57865 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760875AbXG1HaE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 03:30:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IEgkU-0000nJ-Ip
	for git@vger.kernel.org; Sat, 28 Jul 2007 09:30:02 +0200
Received: from abailly.pck.nerim.net ([213.41.244.235])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 09:30:02 +0200
Received: from abailly by abailly.pck.nerim.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Jul 2007 09:30:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: abailly.pck.nerim.net
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:0/LvvAOaExdUgcVw7OyNcxfZN8I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54003>

Hello,=20
I am new to git and gave it a try to version my home dir and
synchronize it between two machines. It works but I think I did some
mistakes in my setup which make its usability non optimal:=20
 - push/pull operations need remote address
 - I didn't set up any branch

Here is what I did (lap is for operations on laptop, pc on desktop):
lap> git init
lap> git add ...
lap> git commit ...
lap> scp .git pc:
lap> mv .git git-init
pc> git checkout .
pc> git commit ...
lap> git clone  -n --bare --reference git-init/  ssh://pc/~/.git
lap> git checkout .
lap> git add ...
lap> git commit

Now, I want to be able to do:
lap> git push
or
lap> git pull

instead of=20
lap> git push ssh://pc/~/.git

I think I need to reconfigure my remote branches/origin on laptop but
don't want ot break everything.

Help appreciated,
--=20
OQube < software engineering \ g=E9nie logiciel >
Arnaud Bailly, Dr.
\web> http://www.oqube.com
