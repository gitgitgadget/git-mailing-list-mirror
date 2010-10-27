From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] Makefile: new prove target for running the tests
	with TAP
Date: Wed, 27 Oct 2010 04:57:09 +0000
Message-ID: <20101027045709.GA11250@idm.gtisc.gatech.edu>
References: <5c46df95f93b56aa2fce56c7efe7b2be80642c8b.1287045908.git.git@drmicha.warpmail.net> <20101014172301.GA2770@sigill.intra.peff.net> <7vmxq0ebe9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 06:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAy4j-0001ON-Ql
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 06:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096Ab0J0E5N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 00:57:13 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39284 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928Ab0J0E5L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 00:57:11 -0400
Received: (qmail 11437 invoked by uid 1001); 27 Oct 2010 04:57:09 -0000
Content-Disposition: inline
In-Reply-To: <7vmxq0ebe9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160020>

On Tue, Oct 26, 2010 at 05:18:22PM -0700, Junio C Hamano wrote:

> > like -j16, but it's a pain to construct the command line (especiall=
y as
> > I use --root in GIT_TEST_OPTS to get a significant speedup).
> [..]
> I kind of like this.  Perhaps with something like this squashed in?

Yeah, looks good to me. I guess you can steal the commit message and
authorship from Michael's original.

=C3=86var mentioned something about t/harness, which I honestly have no=
 idea
about (I don't have the right perl modules installed to run it). But
maybe that could be an alternate DEFAULT_TEST_TARGET. I dunno.

-Peff
