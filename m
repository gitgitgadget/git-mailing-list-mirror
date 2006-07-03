From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make zlib compression level configurable, and change
 default.
Date: Mon, 3 Jul 2006 12:50:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607031248320.12404@g5.osdl.org>
References: <loom.20060703T124601-969@post.gmane.org>
 <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com>
 <44A91C7A.6090902@fys.uio.no> <Pine.LNX.4.64.0607031030150.1213@localhost.localdomain>
 <Pine.LNX.4.64.0607030929490.12404@g5.osdl.org> <85d5cm8qfn.fsf_-_@lupus.ig3.net>
 <Pine.LNX.4.64.0607031226370.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 03 21:50:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxURL-000664-1y
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 21:50:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWGCTug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 15:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWGCTuf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 15:50:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64655 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751267AbWGCTuf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 15:50:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k63JoOnW022922
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 12:50:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k63JoNmo030772;
	Mon, 3 Jul 2006 12:50:23 -0700
To: Joachim B Haga <cjhaga@fys.uio.no>
In-Reply-To: <Pine.LNX.4.64.0607031226370.12404@g5.osdl.org>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23196>



On Mon, 3 Jul 2006, Linus Torvalds wrote:
> 
> Oh, and for all the same reasons, we should use
> 
> 	int zlib_compression_level = Z_BEST_COMPRESSION;

That should be Z_DEFAULT_COMPRESSION, of course.

Anyway, I think the patches are ok as-is, and my suggestion to avoid the 
"-1" and use Z_DEFAULT_COMPRESSION is really just an additional comment, 
not anything fundamental.

So Junio, feel free to add an

	Acked-by: Linus Torvalds <torvalds@osdl.org>

regardless of whether also doing that.

		Linus
