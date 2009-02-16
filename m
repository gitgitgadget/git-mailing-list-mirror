From: Jeff King <peff@peff.net>
Subject: Re: git-svn -- out of memory
Date: Mon, 16 Feb 2009 10:39:00 -0500
Message-ID: <20090216153900.GA22899@coredump.intra.peff.net>
References: <1234795937.845716.4397.nullmailer@beryx.hq.kred>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, normalperson@yhbt.net, git@vger.kernel.org
To: "Alfred M. Szmidt" <ams@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 16:40:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ5aQ-0002QG-9g
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 16:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbZBPPjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 10:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbZBPPjF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 10:39:05 -0500
Received: from peff.net ([208.65.91.99]:54502 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbZBPPjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 10:39:04 -0500
Received: (qmail 20242 invoked by uid 107); 16 Feb 2009 15:39:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Feb 2009 10:39:22 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2009 10:39:01 -0500
Content-Disposition: inline
In-Reply-To: <1234795937.845716.4397.nullmailer@beryx.hq.kred>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110194>

On Mon, Feb 16, 2009 at 03:52:17PM +0100, Alfred M. Szmidt wrote:

> Added an extra 20G of swap, still the same error.

You might have to also tweak your ulimit to be able to use that much
memory in a single process. Is this a 64-bit machine?

-Peff
