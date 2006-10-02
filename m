From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Mon, 2 Oct 2006 12:51:10 -0700 (PDT)
Message-ID: <20061002195110.33802.qmail@web31801.mail.mud.yahoo.com>
References: <efpfc3$765$1@sea.gmane.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Oct 02 21:52:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUToy-0006ff-GP
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 21:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbWJBTvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 15:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWJBTvN
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 15:51:13 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:26253 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964923AbWJBTvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 15:51:11 -0400
Received: (qmail 33804 invoked by uid 60001); 2 Oct 2006 19:51:10 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=l0Cic2v5IODneZ/Hu7U5Zr6ZgFtucvihhMXI7rEa5NQ6yVFqw2rhvIP3JhpmnksAxNTIIAAX12qikIQXYS8HJ0uhE8dxN48Illx3ZLPYMhckduLs8RBHTe1wY93KIsPPnyXDXjzd6W4ou1bCIYwajT7a9+stNIvxVy1yvp/WCWE=  ;
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Mon, 02 Oct 2006 12:51:10 PDT
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
In-Reply-To: <efpfc3$765$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28233>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Luben Tuikov wrote:
> 
> > What this patch does is simply set "h" and/or "hb" to
> > the string "HEAD" instead of the string "<SHA1 of HEAD>" when
> > h/hb is not defined.
> 
> I guess there it is a good idea, but we should always think
> over if we want "constant" link, always showing the same thing,
> or a "variable" (or "news") link, showing current version.
> 
> Explicit sha1 hash as 'h'/'hb' gives persistent, cacheable link,
> while e.g. "HEAD" gives "variable" link.

Exactly what is wanted by people using git in a work environment.

   Luben
P.S. Please don't edit out the CC list leaving only git in. Click
"Reply-all" please, just like everyone else does.
