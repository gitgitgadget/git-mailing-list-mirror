From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] utf8: add utf8_strwidth()
Date: Sat, 31 Jan 2009 02:17:11 -0500
Message-ID: <20090131071711.GA3710@coredump.intra.peff.net>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Geoffrey Thomas <geofft@MIT.EDU>
X-From: git-owner@vger.kernel.org Sat Jan 31 08:18:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTA7k-0003Em-CE
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 08:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbZAaHRP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 02:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbZAaHRP
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 02:17:15 -0500
Received: from peff.net ([208.65.91.99]:46001 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbZAaHRO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 02:17:14 -0500
Received: (qmail 10482 invoked by uid 107); 31 Jan 2009 07:17:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 31 Jan 2009 02:17:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Jan 2009 02:17:11 -0500
Content-Disposition: inline
In-Reply-To: <1233308489-2656-1-git-send-email-geofft@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107910>

On Fri, Jan 30, 2009 at 04:41:28AM -0500, Geoffrey Thomas wrote:

> I'm about to use this pattern more than once, so make it a common function.

I know next to nothing about our encoding functions, but this seems
suspiciously similar to utf8_width in utf8.c. There is also a
git_wcwidth, but I don't know how they relate.

-Peff
