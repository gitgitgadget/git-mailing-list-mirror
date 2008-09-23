From: Jhair Tocancipa Triana <jhair.tocancipa@gmail.com>
Subject: fatal: cannot store pack file (git 1.6.0.2 + sshfs)
Date: Tue, 23 Sep 2008 20:15:28 +0100
Organization: Golem. Ubuntu Laptop
Message-ID: <87iqsmy8q7.fsf@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 21:21:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiDRq-0006P4-48
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 21:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYIWTUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 15:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbYIWTUL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 15:20:11 -0400
Received: from main.gmane.org ([80.91.229.2]:32905 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955AbYIWTUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 15:20:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KiDQY-0004lo-Hy
	for git@vger.kernel.org; Tue, 23 Sep 2008 19:20:02 +0000
Received: from resnet-nat-198.ucs.ed.ac.uk ([194.81.254.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 19:20:02 +0000
Received: from jhair.tocancipa by resnet-nat-198.ucs.ed.ac.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 19:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: resnet-nat-198.ucs.ed.ac.uk
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:oZ8gL9IS6UklEr/BiWxjO/F484A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96585>

I'm getting the following when running git on a partition mounted with
sshfs:

$ git pull
remote: Counting objects: 304, done.
remote: Compressing objects: 100% (256/256), done.
remote: Total 260 (delta 103), reused 0 (delta 0)
Receiving objects: 100% (260/260), 26.62 MiB | 3979 KiB/s, done.
Resolving deltas: 100% (103/103), completed with 32 local objects.
error: unable to write sha1 filename .git/objects/pack/pack-dc5c3614e795918f457a2f98a58f10134ebf246b.pack: Operation not permitted

fatal: cannot store pack file
fatal: index-pack failed

git pull worked fine in the same repository yesterday (new files where
committed in the meantime).

I'm not sure if this is a problem in git or in sshfs (or somewhere
else).

Any ideas what the problem could be?

Thanks,

-- 
Jhair
