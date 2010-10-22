From: Jeff King <peff@peff.net>
Subject: Re: [BUG, PATCH v5 0/3] Fix {blame,cat-file} --textconv for cases
 with symlinks
Date: Fri, 22 Oct 2010 16:05:16 -0400
Message-ID: <20101022200516.GA13926@sigill.intra.peff.net>
References: <cover.1285758714.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Fri Oct 22 22:04:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Nqy-0003m6-6e
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 22:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757176Ab0JVUEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 16:04:33 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37361 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756345Ab0JVUEc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 16:04:32 -0400
Received: (qmail 23215 invoked by uid 111); 22 Oct 2010 20:04:31 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 22 Oct 2010 20:04:31 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Oct 2010 16:05:16 -0400
Content-Disposition: inline
In-Reply-To: <cover.1285758714.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159742>

On Wed, Sep 29, 2010 at 03:35:21PM +0400, Kirill Smelkov wrote:

> Kirill Smelkov (3):
>   tests: Prepare --textconv tests for correctly-failing conversion
>     program
>   blame,cat-file: Demonstrate --textconv is wrongly running converter
>     on symlinks
>   blame,cat-file --textconv: Don't assume mode is ``S_IFREF | 0664''

I finally got around to reviewing this series again (thanks for your
patience, Kirill). This latest version (v5) looks good to me.

-Peff
