From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Thu, 28 Apr 2005 13:47:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504281339530.18901@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
 <42713379.7080107@lsrfire.ath.cx> <Pine.LNX.4.58.0504281217100.18901@ppc970.osdl.org>
 <20050428202739.GE30308@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 28 22:46:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRFsP-0007bd-Uu
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 22:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVD1UtH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 16:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVD1Uqc
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 16:46:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:48780 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262160AbVD1UpY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 16:45:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3SKjGs4009032
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Apr 2005 13:45:17 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3SKjFkN008490;
	Thu, 28 Apr 2005 13:45:16 -0700
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050428202739.GE30308@mythryan2.michonline.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 28 Apr 2005, Ryan Anderson wrote:
> 
> Try adding "set -e" to the beginning of cg-log.

Nope. I actually downloaded bash-3.0, and it literally seem sto be 
impossible to get bash to not do it. 

It has some noise there about signal trapping, but that doesn't actually
seem to work.

		Linus
