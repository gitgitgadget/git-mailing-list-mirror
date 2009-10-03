From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/7] imap-send: use separate read and write fds
Date: Sat, 3 Oct 2009 16:34:48 -0400
Message-ID: <20091003203448.GA9058@sigill.intra.peff.net>
References: <1254530385-2824-1-git-send-email-kusmabite@gmail.com>
 <20091003094049.GA17873@coredump.intra.peff.net>
 <40aa078e0910031144r735a6fdq25efc1e57a1d4c33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 22:36:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuBLI-0006U4-5C
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 22:36:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbZJCUf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2009 16:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbZJCUf2
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 16:35:28 -0400
Received: from peff.net ([208.65.91.99]:56431 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbZJCUf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 16:35:28 -0400
Received: (qmail 6241 invoked by uid 107); 3 Oct 2009 20:38:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 03 Oct 2009 16:38:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Oct 2009 16:34:48 -0400
Content-Disposition: inline
In-Reply-To: <40aa078e0910031144r735a6fdq25efc1e57a1d4c33@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129503>

On Sat, Oct 03, 2009 at 11:44:50AM -0700, Erik Faye-Lund wrote:

> Yeah, this is about Windows portability.
> 
> I'll add something like "This is a patch that enables us to use the
> run-command API, which is supported on Windows." to the commit-message
> in the next round. Is that enough?

Yeah, that would be fine. I was just left scratching my head wondering
what subtle portability difference the two descriptors could have. But
if it really is just a cleanup for the next patch, that's OK; just say
so.

-Peff
