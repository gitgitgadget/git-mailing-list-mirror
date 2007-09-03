From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Mon, 03 Sep 2007 09:07:42 +0200
Message-ID: <46DBB2BE.8030505@eudaptics.com>
References: <46DACD93.9000509@trolltech.com> <200709022228.00733.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0709022133190.28586@racer.site> <200709022342.42733.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 09:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS63l-0003gi-2L
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 09:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbXICHIt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 03:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbXICHIt
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 03:08:49 -0400
Received: from main.gmane.org ([80.91.229.2]:48003 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111AbXICHIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 03:08:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IS636-0004NP-29
	for git@vger.kernel.org; Mon, 03 Sep 2007 09:08:40 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 09:08:40 +0200
Received: from j.sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 09:08:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200709022342.42733.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57433>

Robin Rosenberg schrieb:
> $ ln -s Makefile x
> $ cp x y
> $ ls -ld x y
> lrwxrwxrwx 1 me me     8 sep  2 23:36 x -> Makefile
> -rw-r--r-- 1 me me 32164 sep  2 23:36 y

And if I understand the documentation correctly, then

$ mkdir foo && cd foo
$ cat ../x
x: No such file or directory

Right?

The docs say that symlinks without backslash are relative to the current 
directory (!!!).

-- Hannes
