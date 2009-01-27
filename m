From: Jeff King <peff@peff.net>
Subject: Re: how to see full file with diff marks
Date: Mon, 26 Jan 2009 23:57:03 -0500
Message-ID: <20090127045702.GC735@coredump.intra.peff.net>
References: <497E92C1.80102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ittay Dror <ittay.dror@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 05:58:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRg1x-0002eN-4S
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 05:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbZA0E5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 23:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbZA0E5H
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 23:57:07 -0500
Received: from peff.net ([208.65.91.99]:44020 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbZA0E5G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 23:57:06 -0500
Received: (qmail 8777 invoked by uid 107); 27 Jan 2009 04:57:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Jan 2009 23:57:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2009 23:57:03 -0500
Content-Disposition: inline
In-Reply-To: <497E92C1.80102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107310>

On Tue, Jan 27, 2009 at 06:51:13AM +0200, Ittay Dror wrote:

> I have a large file and I want to view the changes between two commits,  
> but in the context of the whole file, not just hunks. How can I do that?

git diff -U9999999 ?

-Peff
