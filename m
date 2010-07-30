From: Jeff King <peff@peff.net>
Subject: Re: pre-commit hook and Aspell
Date: Fri, 30 Jul 2010 14:21:16 -0400
Message-ID: <20100730182116.GA18544@coredump.intra.peff.net>
References: <4C529290.7040509@zbh.uni-hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Stefan Bienert <bienert@zbh.uni-hamburg.de>
X-From: git-owner@vger.kernel.org Fri Jul 30 20:21:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeuDN-0005sI-Uz
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 20:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760037Ab0G3SV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 14:21:29 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40933 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760019Ab0G3SVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 14:21:22 -0400
Received: (qmail 3433 invoked by uid 111); 30 Jul 2010 18:21:20 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Fri, 30 Jul 2010 18:21:20 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jul 2010 14:21:16 -0400
Content-Disposition: inline
In-Reply-To: <4C529290.7040509@zbh.uni-hamburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152253>

On Fri, Jul 30, 2010 at 10:51:28AM +0200, Stefan Bienert wrote:

> I'm trying to setup a hook for my project which forces me to check the
> spelling of text (here: TeX) files, whenever they change. As
> spellchecker I use Aspell, which is giving me a headache at the moment.
> The problem is: Running the pre-commit script in the shell works,
> started as hook does not.

Hooks run without stdio connected to the tty. Have you tried doing
"aspell </dev/tty >/dev/tty" in your hook?

-Peff
