From: Paul Dickson <paul@permanentmail.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9m aka 1.0rc5
Date: Mon, 12 Dec 2005 19:20:13 -0700
Message-ID: <20051212192013.9ef4c8b2.paul@permanentmail.com>
References: <7vbqznm4b7.fsf@assigned-by-dhcp.cox.net>
	<20051212183723.c4b09964.paul@permanentmail.com>
	<7vd5k1dax6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 03:21:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElzmN-0004gN-NI
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 03:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVLMCUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Dec 2005 21:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVLMCUU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Dec 2005 21:20:20 -0500
Received: from thorn.pobox.com ([208.210.124.75]:44521 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S932364AbVLMCUR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Dec 2005 21:20:17 -0500
Received: from thorn (localhost [127.0.0.1])
	by thorn.pobox.com (Postfix) with ESMTP id 633D5122;
	Mon, 12 Dec 2005 21:20:39 -0500 (EST)
Received: from red.pwd.internal (ip68-230-78-84.ph.ph.cox.net [68.230.78.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by thorn.sasl.smtp.pobox.com (Postfix) with ESMTP id 0747C1838;
	Mon, 12 Dec 2005 21:20:37 -0500 (EST)
Received: from white.pwd.internal ([192.168.1.9])
	by red.pwd.internal (8.13.5/8.13.4) with SMTP id jBD2KDYN013994;
	Mon, 12 Dec 2005 19:20:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5k1dax6.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.8; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13563>

On Mon, 12 Dec 2005 17:48:37 -0800, Junio C Hamano wrote:

> $ dpkg -l asciidoc xmlto
> Desired=Unknown/Install/Remove/Purge/Hold
> | Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
> |/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: uppercase=bad)
> ||/ Name           Version        Description
> +++-==============-==============-============================================
> ii  asciidoc       7.0.2-4        Highly configurable text format for writing
> ii  xmlto          0.0.18-5       XML-to-any converter
> $ grep '^[A-Z][a-z]* by' git-repack.1
> Written by Linus Torvalds <torvalds@osdl\&.org>
> Documentation by Ryan Anderson <ryan@michonline\&.com>

  $ rpm -q xmlto asciidoc man groff
  xmlto-0.0.18-9
  asciidoc-7.0.2-1.fc5
  man-1.6b-1
  groff-1.18.1.1-5

I would suspect groff (as used by man).

  $ zcat /usr/share/man/man1/git-repack.1.gz|grep '^[A-Z][a-z]* by'

	-Paul
