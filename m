From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Improve git-rev-list --header output
Date: Sun, 5 Jun 2005 08:17:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506050815130.1876@ppc970.osdl.org>
References: <20050605132515.GB17462@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 17:12:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DewnY-00036v-CY
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 17:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVFEPPs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 11:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVFEPPs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 11:15:48 -0400
Received: from fire.osdl.org ([65.172.181.4]:8379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261587AbVFEPPo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 11:15:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j55FFejA029404
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 5 Jun 2005 08:15:40 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j55FFd0S010629;
	Sun, 5 Jun 2005 08:15:39 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050605132515.GB17462@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 5 Jun 2005, Petr Baudis wrote:
>
> Indent the commit header by four spaces like in the --pretty output;
> the commit ID is still shown unaligned. This makes the --header output
> actually usable for further processing.

I'm actually going to do a few different "header formats", and have 
pretty_print_commit() able to switch between them. IOW, this would count 
as just one form of pretty-printing.

I want to have the "dense" format, which has only the author and the top
line(s) of the description (stop at the first empty line), and a "raw"  
format, which has all the parent information etc (ie this one).

		Linus
