From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH, take 1] Linear-time/space rename logic (exact renames
 only)
Date: Sun, 21 Oct 2007 22:41:29 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710212241180.10525@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
 <ee77f5c20710211731n2646ae11jd2fb2c0be12494ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:42:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijq3E-0007e1-6S
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbXJVFly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbXJVFly
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:41:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54115 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751975AbXJVFlw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 01:41:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9M5fUie009170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 21 Oct 2007 22:41:32 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9M5fTIp012739;
	Sun, 21 Oct 2007 22:41:30 -0700
In-Reply-To: <ee77f5c20710211731n2646ae11jd2fb2c0be12494ac@mail.gmail.com>
X-Spam-Status: No, hits=-3.22 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61944>



On Mon, 22 Oct 2007, David Symonds wrote:
> > @@ -291,7 +291,7 @@ LIB_H = \
> >         run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
> >         tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
> >         utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h \
> > -       mailmap.h remote.h
> > +       mailmap.h remote.h hash.o
> 
> I assume that should be "hash.h", not "hash.o"?

Oops.

Yes.

		Linus
