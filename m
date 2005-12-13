From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9m aka 1.0rc5
Date: Mon, 12 Dec 2005 21:52:50 -0800
Message-ID: <7vslsxbl1p.fsf@assigned-by-dhcp.cox.net>
References: <7vbqznm4b7.fsf@assigned-by-dhcp.cox.net>
	<20051212183723.c4b09964.paul@permanentmail.com>
	<7vd5k1dax6.fsf@assigned-by-dhcp.cox.net>
	<20051212192013.9ef4c8b2.paul@permanentmail.com>
	<20051212195408.40af06f1.paul@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 06:54:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Em35s-0006Gr-CN
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 06:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVLMFwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 00:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVLMFwy
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 00:52:54 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:10464 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932460AbVLMFwx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 00:52:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213055104.QXTX17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Dec 2005 00:51:04 -0500
To: Paul Dickson <paul@permanentmail.com>
In-Reply-To: <20051212195408.40af06f1.paul@permanentmail.com> (Paul Dickson's
	message of "Mon, 12 Dec 2005 19:54:08 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13571>

Paul Dickson <paul@permanentmail.com> writes:

>> I would suspect groff (as used by man).
>> 
>>   $ zcat /usr/share/man/man1/git-repack.1.gz|grep '^[A-Z][a-z]* by'
>
> I think it's up one level to the creator of the man files:
>
> .SH "DESCRIPTION"
> This script is used to combine all objects that do not currently reside in a "pack", into a pack..sp

Hmph.  In the same environment as before:

$ rm -f git-repack.1
$ make git-repack.1
rm -f doc.dep+ doc.dep
perl ./build-docdep.perl >doc.dep+
mv doc.dep+ doc.dep
asciidoc -b docbook -d manpage -f asciidoc.conf git-repack.txt
xmlto man git-repack.xml
Writing git-repack.1 for refentry
rm git-repack.xml
$ make git-repack.xml
asciidoc -b docbook -d manpage -f asciidoc.conf git-repack.txt
$ grep osdl git-repack.1 git-repack.xml
git-repack.1:Written by Linus Torvalds <torvalds@osdl\&.org>
git-repack.xml:<simpara>Written by Linus Torvalds &lt;torvalds@osdl.org&gt;</simpara>
$ exit

And it is the same on kernel.org machine I have account on.
