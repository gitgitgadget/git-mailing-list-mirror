From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Add a new commit-raw command.
Date: Tue, 24 Feb 2009 17:14:06 -0500
Message-ID: <20090224221406.GA6299@coredump.intra.peff.net>
References: <1235510914-23319-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Rene Stadler <renestadler84@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 23:15:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc5Yy-0001Ve-PC
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 23:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005AbZBXWOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 17:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753930AbZBXWOL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 17:14:11 -0500
Received: from peff.net ([208.65.91.99]:56984 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852AbZBXWOK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 17:14:10 -0500
Received: (qmail 18626 invoked by uid 107); 24 Feb 2009 22:14:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Feb 2009 17:14:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2009 17:14:06 -0500
Content-Disposition: inline
In-Reply-To: <1235510914-23319-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111353>

On Tue, Feb 24, 2009 at 11:28:34PM +0200, Felipe Contreras wrote:

> This command receives as input a raw commit object, and outputs the
> generated sha1. This is very useful when doing some serious repo
> reconstructions.
> 
> For example: git cat-file -p 343ee25 | git write-raw
> 343ee2589d1b94772f513cc699765622351acb19

How about:

  git cat-file -p 343ee25 | git hash-object -t commit --stdin

?

-Peff
