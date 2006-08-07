From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: fast-import and unique objects.
Date: Mon, 07 Aug 2006 16:48:08 +0200
Organization: At home
Message-ID: <eb7jr2$4ar$1@sea.gmane.org>
References: <9e4733910608060532w51fca2c0r8038828df0d41eeb@mail.gmail.com> <9e4733910608060853ua0eabc1w9b35b8414d3c9bae@mail.gmail.com> <20060806180323.GA19120@spearce.org> <9e4733910608062148u4341dabag451c3f49f1a792a1@mail.gmail.com> <20060807050422.GD20514@spearce.org> <9e4733910608070737k52aaea7clf871d716d16547c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 07 16:49:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GA6Pi-0000sL-Pf
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 16:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWHGOtB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 10:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWHGOtB
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 10:49:01 -0400
Received: from main.gmane.org ([80.91.229.2]:3243 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750842AbWHGOtA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 10:49:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GA6P9-0000j9-8t
	for git@vger.kernel.org; Mon, 07 Aug 2006 16:48:31 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 16:48:31 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Aug 2006 16:48:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25016>

Jon Smirl wrote:

> How about sending out a stream of add/change/delete operations
> interspersed with commits? That would let fast-import track the tree
> and only generate tree nodes when they change.

The problem with CVS, which cvsps (CVS PatchSet) tries to address is that
changes are to a file, and reconstructing which changes go together to make
_one_ commit...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
