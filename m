From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Tue, 26 Sep 2006 14:17:20 -0700 (PDT)
Message-ID: <20060926211720.21355.qmail@web31808.mail.mud.yahoo.com>
References: <efc2t8$eti$3@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Sep 26 23:17:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSKIu-0004F0-Uq
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 23:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWIZVRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 17:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWIZVRV
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 17:17:21 -0400
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:21412 "HELO
	web31808.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932416AbWIZVRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 17:17:20 -0400
Received: (qmail 21357 invoked by uid 60001); 26 Sep 2006 21:17:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oLvlFS/F7Mli6y76Zx+Gk5lQYBxFy9bEVQ7EIUXIZuoW1VV6ZpnyWyfVXn+/jX57e9zi2/B9sd5b0ScY9UQ/Dnh542t3EGIHfICYs3r8vNDyqGZ/nmCb9z7PO7QZH2ymH+p+E4MRlvGg/346ffmDDTx67G2D4cCO3fAIEYAvkXw=  ;
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 14:17:20 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <efc2t8$eti$3@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27822>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> I think that this need some thinking over. For blob we have two
> "base" objects: tree which have specified blob, and commit which
> have tree which have specified blob. We might want to specify
> that all hash*base are to the commit-ish.

Agreed, we should always refer to the commit-ish, for obvious
reasons.

This patch doesn't make this decision though.  It simply
sets hash_base to HEAD if not defined.

Now, since "git-ls-tree" works on both commit-ish and
tree-ish, we are ok.

    Luben
