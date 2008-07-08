From: Eric Hanchrow <offby1@blarg.net>
Subject: Re: uninstalling Git
Date: Mon, 07 Jul 2008 22:30:27 -0700
Message-ID: <87od59c58s.fsf@offby1.atm01.sea.blarg.net>
References: <4872F3B0.6050406@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 07:39:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG5v7-0003f6-5K
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 07:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbYGHFiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 01:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbYGHFiX
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 01:38:23 -0400
Received: from main.gmane.org ([80.91.229.2]:42045 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbYGHFiW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 01:38:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KG5u2-0005pp-W0
	for git@vger.kernel.org; Tue, 08 Jul 2008 05:38:14 +0000
Received: from q-static-138-125.avvanta.com ([206.124.138.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 05:38:14 +0000
Received: from offby1 by q-static-138-125.avvanta.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 05:38:14 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: q-static-138-125.avvanta.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:Cg3c51WpeM0TIbYBzfj5nzDJ2zU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87717>

>>>>> "Christian" == Christian Jaeger <christian@jaeger.mine.nu> writes:

    Christian> I wonder why there's no "uninstall" make target.  

This is a problem with lots of packages, not just git.  Here are two
things I do:
            
* When I remember, I use "gnu stow" to manage installations; doing so
  makes uninstallation easy.

* Failing that, I run

        find /usr -printf '%T@ ' -ls | sort -n | cut -d\  -f 2-

  and assume that all the installed files have the same last-modified
  timestamps -- once you've found one of them in that pipeline's output,
  you've found them all, since they'll all be adjacent.

-- 
Asking the Iraqi people to assume Saddam's debts
is rather like telling a man who has been shot in the head
that he has to pay for the bullet.
        -- James Surowiecki
