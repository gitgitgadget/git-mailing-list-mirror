From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] clone: simplify progress message
Date: Mon, 10 May 2010 01:47:56 -0400
Message-ID: <20100510054756.GB13340@coredump.intra.peff.net>
References: <4BE60E89.8010709@pcharlan.com>
 <20100509110221.GA16639@coredump.intra.peff.net>
 <4BE7166A.5030107@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon May 10 07:49:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBLs2-000711-Qc
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 07:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab0EJFr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 01:47:57 -0400
Received: from peff.net ([208.65.91.99]:33334 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752773Ab0EJFr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 01:47:57 -0400
Received: (qmail 32412 invoked by uid 107); 10 May 2010 05:48:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 May 2010 01:48:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 May 2010 01:47:56 -0400
Content-Disposition: inline
In-Reply-To: <4BE7166A.5030107@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146760>

On Sun, May 09, 2010 at 01:09:14PM -0700, Pete Harlan wrote:

> > I guess it comes down to how much detail we want to show.
> 
> For me it isn't only a matter of detail; I find "Cloning into
> bar/.git" misleading, since bar is getting more than a .git directory.

Yeah, I can buy that line of reasoning. Junio's nitpick aside, I think
most users perceive the clone process as creating the whole "bar"
directory.

> Thank you for looking at this.  I agree with you, and have added a
> second patch that implements that.

These patches look good to me. I agree with Junio about just squashing
them.

-Peff
