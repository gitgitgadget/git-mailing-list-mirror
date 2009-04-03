From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 14:37:38 -0400
Message-ID: <20090403183738.GA15926@coredump.intra.peff.net>
References: <20090403T065545Z@curie.orbis-terrarum.net> <20090403132029.GC21153@coredump.intra.peff.net> <200904031954.57584.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 20:39:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpoIa-0003jP-8Y
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 20:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760215AbZDCShz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 14:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756995AbZDCShz
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 14:37:55 -0400
Received: from peff.net ([208.65.91.99]:59574 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757569AbZDCShy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 14:37:54 -0400
Received: (qmail 924 invoked by uid 107); 3 Apr 2009 18:38:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 14:38:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 14:37:38 -0400
Content-Disposition: inline
In-Reply-To: <200904031954.57584.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115553>

On Fri, Apr 03, 2009 at 07:54:57PM +0200, Johannes Sixt wrote:

> If you base the patch on 'master', you can add this line to test-lib.sh
> 
> test -z "$NO_PERL" && test_set_prereq PERL

Thanks, I'm working up a patch using this now.

> [But actually, if I read you patch correctly, NO_PERL will be set in 
> t/Makefile only if one runs 'make test' from the main directory. You should 
> invent some method to detect missing perl (or that NO_PERL was set) if 'make' 
> is run directly from t/.]

Yes, it should go into GIT-BUILD-OPTIONS which gets sourced by
test-lib.sh (and then it not only works with "make test" from "t/", but
also with "sh t????-whatever.sh".

-Peff
