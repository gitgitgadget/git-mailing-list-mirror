From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jul 2012, #07; Mon, 23)
Date: Tue, 24 Jul 2012 09:58:38 -0400
Message-ID: <20120724135838.GB14422@sigill.intra.peff.net>
References: <7vsjchhhhz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:58:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StfdO-0002eV-2x
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 15:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab2GXN6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 09:58:41 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60266 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab2GXN6k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 09:58:40 -0400
Received: (qmail 17330 invoked by uid 107); 24 Jul 2012 13:58:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 24 Jul 2012 09:58:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2012 09:58:38 -0400
Content-Disposition: inline
In-Reply-To: <7vsjchhhhz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202041>

On Mon, Jul 23, 2012 at 10:10:00PM -0700, Junio C Hamano wrote:

> * jc/test-lib-source-build-options-early (2012-06-24) 1 commit
>  - test-lib: reorder and include GIT-BUILD-OPTIONS a lot earlier
> 
> Reorders t/test-lib.sh so that we dot-source GIT-BUILD-OPTIONS that
> records the shell and Perl the user told us to use with Git a lot
> early, so that test-lib.sh script itself can use "$PERL_PATH" in
> one of its early operations.
> 
> Needs to be eyeballed by people who run tests with exotic options
> like valgrind, --root=/dev/shm/somewhere, etc.

I'm such a people. Both --valgrind and --root work OK with the patch.
Reading the patch, I don't see any other problematic options, either.

-Peff
