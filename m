From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9m aka 1.0rc5
Date: Mon, 12 Dec 2005 17:48:37 -0800
Message-ID: <7vd5k1dax6.fsf@assigned-by-dhcp.cox.net>
References: <7vbqznm4b7.fsf@assigned-by-dhcp.cox.net>
	<20051212183723.c4b09964.paul@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 02:50:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElzHa-0006pV-Cu
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 02:48:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVLMBsj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 20:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLMBsj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 20:48:39 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42904 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932338AbVLMBsj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2005 20:48:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051213014646.KBRI20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Dec 2005 20:46:46 -0500
To: Paul Dickson <paul@permanentmail.com>
In-Reply-To: <20051212183723.c4b09964.paul@permanentmail.com> (Paul Dickson's
	message of "Mon, 12 Dec 2005 18:37:23 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13561>

Paul Dickson <paul@permanentmail.com> writes:

> On Sun, 11 Dec 2005 18:34:20 -0800, Junio C Hamano wrote:
>
>> GIT 0.99.9m aka 1.0rc5 is found at usual places:
>
> Is it just me or do most paragraphs (blocks of text) end with a ".sp"?

Not for me.

$ rm -f git-repack.1
$ make git-repack.1
asciidoc -b docbook -d manpage -f asciidoc.conf git-repack.txt
xmlto man git-repack.xml
Writing git-repack.1 for refentry
rm git-repack.xml
$ dpkg -l asciidoc xmlto
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  asciidoc       7.0.2-4        Highly configurable text format for writing
ii  xmlto          0.0.18-5       XML-to-any converter
$ grep '^[A-Z][a-z]* by' git-repack.1
Written by Linus Torvalds <torvalds@osdl\&.org>
Documentation by Ryan Anderson <ryan@michonline\&.com>
$ exit
