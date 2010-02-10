From: Jeff King <peff@peff.net>
Subject: Re: git add -u nonexistent-file
Date: Wed, 10 Feb 2010 00:57:27 -0500
Message-ID: <20100210055727.GH28526@coredump.intra.peff.net>
References: <20100208182929.GB14355@neumann>
 <a038bef51002081112s2d552835m4b34973f797ab4f8@mail.gmail.com>
 <20100209003958.GA4065@coredump.intra.peff.net>
 <7v7hqm2hs7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Packham <judge.packham@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 06:57:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf5Zs-0006Uw-2O
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 06:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab0BJF50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 00:57:26 -0500
Received: from peff.net ([208.65.91.99]:57684 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab0BJF50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 00:57:26 -0500
Received: (qmail 31417 invoked by uid 107); 10 Feb 2010 05:57:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 10 Feb 2010 00:57:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2010 00:57:27 -0500
Content-Disposition: inline
In-Reply-To: <7v7hqm2hs7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139493>

On Tue, Feb 09, 2010 at 01:58:16PM -0800, Junio C Hamano wrote:

> > That being said, you noticed that the regular add case notes unused
> > pathspecs on the command line:
> >
> >   $ git add bogus
> >   fatal: pathspec 'bogus' did not match any files
> >
> > We could probably do the same here.
> 
> It won't be entirely trivial to do so efficiently but it shouldn't be a
> rocket surgery.
> 
> Something like this (untested of course)?

Looks like Chris gave it some basic testing. I read over the patch
itself, and it looks sane to me.

-Peff
