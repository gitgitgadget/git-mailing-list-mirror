From: Jeff King <peff@peff.net>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Tue, 6 Jan 2009 02:22:54 -0500
Message-ID: <20090106072253.GA9920@coredump.intra.peff.net>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johnny Lee <johnnylee194@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 08:24:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK6IX-0004hw-JZ
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 08:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbZAFHW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 02:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751525AbZAFHW4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 02:22:56 -0500
Received: from peff.net ([208.65.91.99]:46939 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbZAFHW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 02:22:56 -0500
Received: (qmail 32276 invoked by uid 107); 6 Jan 2009 07:23:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Jan 2009 02:23:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jan 2009 02:22:54 -0500
Content-Disposition: inline
In-Reply-To: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104642>

On Tue, Jan 06, 2009 at 03:00:52PM +0800, Johnny Lee wrote:

> While I'm looking at these "unable to unlink" files, it seems they are
> read only:
> git@tomato:~/golf$ ls -l .git/objects/16/
> total 4
> -r--r--r-- 1 johnny johnny 26 2009-01-05 09:25
> b14f5da9e2fcd6f3f38cc9e584cef2f3c90ebe
> 
> Is there anything wrong here?

It is normal for objects to be read-only. However, permission to unlink
a file comes from its directory permission. Is .git/objects/16 writable
by you?

-Peff
