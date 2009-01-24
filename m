From: Jeff King <peff@peff.net>
Subject: Re: read-only working copies using links
Date: Sat, 24 Jan 2009 14:35:08 -0500
Message-ID: <20090124193508.GC18010@coredump.intra.peff.net>
References: <3EE64C92-CB4C-47BD-9C48-E369AED4B82F@gmail.com> <bd6139dc0901240302q6b3c9a13p56fe39a976882133@mail.gmail.com> <AE9781AD-0B63-4AEE-9B62-20F9720B5DC4@gmail.com> <bd6139dc0901241043h7087316bgcbcb5d9085d603ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chad Dombrova <chadrik@gmail.com>,
	Tim 'Mithro' Ansell <tansell@google.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 20:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQoJ1-0002Px-Gk
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 20:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185AbZAXTfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 14:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755061AbZAXTfL
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 14:35:11 -0500
Received: from peff.net ([208.65.91.99]:37813 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755028AbZAXTfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 14:35:10 -0500
Received: (qmail 19288 invoked by uid 107); 24 Jan 2009 19:35:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 24 Jan 2009 14:35:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jan 2009 14:35:08 -0500
Content-Disposition: inline
In-Reply-To: <bd6139dc0901241043h7087316bgcbcb5d9085d603ef@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106997>

On Sat, Jan 24, 2009 at 07:43:20PM +0100, Sverre Rabbelier wrote:

> On Sat, Jan 24, 2009 at 19:39, Chad Dombrova <chadrik@gmail.com> wrote:
> > what's the case against it, other than the obvious, that it will take more
> > work?
> 
> Good question, I think it was mostly that, someone has to implement it
> (possibly as part of packv4). Backwards compatibility is of course
> always an concern, but I'm not too familiar with the subject, perhaps
> other people on the list (or even those were at the gittogether) can
> comment?

If I understand his proposal correctly, such objects must _not_ be part
of a pack. The whole idea is splitting them _more_, not less.

-Peff
