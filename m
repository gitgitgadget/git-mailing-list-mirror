From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] uml: remove elf.h
Date: Tue, 17 May 2005 14:44:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505171443180.18337@ppc970.osdl.org>
References: <200505171704.j4HH4Ne8002532@hera.kernel.org>
 <20050517142113.59097a3d.akpm@osdl.org> <20050517213447.GN7136@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262003AbVEQVpp@vger.kernel.org Tue May 17 23:51:56 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262003AbVEQVpp@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY9xF-0004za-GR
	for glk-linux-kernel@gmane.org; Tue, 17 May 2005 23:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVEQVpp (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Tue, 17 May 2005 17:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVEQVpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 17:45:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:6062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261953AbVEQVmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:42:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4HLgmU3002100
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 May 2005 14:42:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4HLgl0A024993;
	Tue, 17 May 2005 14:42:47 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050517213447.GN7136@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 May 2005, Petr Baudis wrote:
>
> Perhaps some artificial timestamp could help to the file
> removal heuristic in GNU patch. Or passing it -E, but that will
> obviously do the wrong thing to any other zero-sized files.

-E is always correct for the kernel, since zero-length files aren't really 
supposed to exist anyway, and "make distclean" has always removed them.

		Linus
