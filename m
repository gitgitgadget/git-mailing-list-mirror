From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Mon, 11 Sep 2006 03:04:31 +0200
Organization: At home
Message-ID: <ee2cms$o18$1@sea.gmane.org>
References: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com> <20060908184215.31789.qmail@science.horizon.com> <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com> <Pine.LNX.4.64.0609081600530.27779@g5.osdl.org> <9e4733910609081628w2a59551foc28c689d0538a984@mail.gmail.com> <17668.2019.732961.855446@cargo.ozlabs.ibm.com> <20060911000306.GA28927@spearce.org> <7vfyezqlny.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Sep 11 03:05:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMaEa-00058f-Sn
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 03:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWIKBEw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 21:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWIKBEw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 21:04:52 -0400
Received: from main.gmane.org ([80.91.229.2]:32392 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932125AbWIKBEv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Sep 2006 21:04:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMaE8-00052i-CU
	for git@vger.kernel.org; Mon, 11 Sep 2006 03:04:44 +0200
Received: from host-81-190-17-209.torun.mm.pl ([81.190.17.209])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 03:04:44 +0200
Received: from jnareb by host-81-190-17-209.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 11 Sep 2006 03:04:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26826>

Junio C Hamano wrote:

>  the impact of changing the
> one-file-per-ref implementation to something based on a single
> simple databasy file (e.g. gdbm, bdb, sqlite, ...)

One of the complaints against Subversion was that it use BerkeleyDB
(bdb) backend... but it was before it acquired fsfs interface. Perhaps
we could use it too.

Or perhaps it is for something like Electra, or ReiserFS file properites
access...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
