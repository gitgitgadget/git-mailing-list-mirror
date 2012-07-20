From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 13:09:13 -0400
Message-ID: <20120720170913.GA14057@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <50092993.6010203@alum.mit.edu>
 <20120720154403.GB2862@sigill.intra.peff.net>
 <5009892E.9010808@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Alexey Muranov <alexey.muranov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jul 20 19:09:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsGhe-00071v-Fh
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 19:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245Ab2GTRJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 13:09:16 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56633 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140Ab2GTRJP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 13:09:15 -0400
Received: (qmail 12783 invoked by uid 107); 20 Jul 2012 17:09:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Jul 2012 13:09:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jul 2012 13:09:13 -0400
Content-Disposition: inline
In-Reply-To: <5009892E.9010808@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201788>

On Fri, Jul 20, 2012 at 06:37:02PM +0200, Johannes Sixt wrote:

> Am 20.07.2012 17:44, schrieb Jeff King:
> > So I think a suffix like ":d" is probably the least horrible.
> 
> Not so. It does not work on Windows :-( in the expected way. Trying to
> open a file with a colon-separated suffix either opens a resource fork
> on NTFS or fails with "invalid path".

Bleh. It seems that we did too good a job in coming up with a list of
disallowed ref characters; they really are things you don't want in your
filenames at all. :)

-Peff
