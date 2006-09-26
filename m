From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Tue, 26 Sep 2006 22:34:55 +0200
Organization: At home
Message-ID: <efc2t8$eti$3@sea.gmane.org>
References: <20060926194706.32255.qmail@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 26 22:40:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSJjc-0003ef-Of
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 22:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWIZUkc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 16:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWIZUkc
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 16:40:32 -0400
Received: from main.gmane.org ([80.91.229.2]:38293 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932299AbWIZUka (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 16:40:30 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GSJil-0003TJ-7Z
	for git@vger.kernel.org; Tue, 26 Sep 2006 22:40:03 +0200
Received: from host-81-190-26-96.torun.mm.pl ([81.190.26.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 22:40:03 +0200
Received: from jnareb by host-81-190-26-96.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 22:40:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-96.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27821>

Luben Tuikov wrote:

> In tree view, by default, hash_base is HEAD and hash is the
> entry equivalent.  Else the user had selected a hash_base or
> hash, say by clicking on a revision or commit, in which case
> those values are used.

I think that this need some thinking over. For blob we have two
"base" objects: tree which have specified blob, and commit which
have tree which have specified blob. We might want to specify
that all hash*base are to the commit-ish.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
