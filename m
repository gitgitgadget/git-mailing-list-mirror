From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: push.default: current vs upstream
Date: Sat, 31 Mar 2012 19:48:54 -0400
Message-ID: <201203312348.q2VNmsmc015543@no.baka.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org> <20120329095236.GA11911@sigill.intra.peff.net> <7vbonfqezs.fsf@alter.siamese.dyndns.org> <20120329221154.GA1413@sigill.intra.peff.net> <7vfwcqq2dw.fsf@alter.siamese.dyndns.org> <20120330071358.GB30656@sigill.intra.peff.net> <7vty15ltuo.fsf@alter.siamese.dyndns.org> <20120330210112.GA20734@sigill.intra.peff.net>
        <CA+7g9JxK5DHj3vbdGgF2dEJxvn=_ZfjAv7Y+AL_P-aO1FVB6-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Nathan Gray <n8gray@n8gray.org>
X-From: git-owner@vger.kernel.org Sun Apr 01 01:49:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE82j-00066X-Ke
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 01:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab2CaXtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 19:49:08 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from tsutomu.baka.org ([66.114.72.182]:41083 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752186Ab2CaXtH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 19:49:07 -0400
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q2VNmsAY023619
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 31 Mar 2012 19:48:54 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q2VNmsmc015543;
	Sat, 31 Mar 2012 19:48:54 -0400
In-reply-to: <CA+7g9JxK5DHj3vbdGgF2dEJxvn=_ZfjAv7Y+AL_P-aO1FVB6-w@mail.gmail.com>
Comments: In reply to a message from "Nathan Gray <n8gray@n8gray.org>" dated "Sat, 31 Mar 2012 15:49:09 -0700."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194472>


In message <CA+7g9JxK5DHj3vbdGgF2dEJxvn=3D_ZfjAv7Y+AL_P-aO1FVB6-w@mail.=
gmail.com>, Nathan Gray writes:

    If a user does some work on his new "features/frobnitz" branch and
    does a "git push" only to find that his work has been committed to =
the
    company's master branch he will be confused, frustrated, and public=
ly
    embarrassed.  He then has to apologize and figure out how to revert
    the changes.  I really don't see any scenario where that user ends =
up
    saying "oh yeah, I guess git was right and I was wrong."

When working with a single remote, I tend to agree with you (though
since I also think receive.denyDeletes should be on by default for
shared repos the public humiliation of creating a branch when you did
not mean to might still exist but of course it will be less damaging
to others) .  However, tracking really comes into its own when working
with multiple remotes.  Is creating a stumbling block between na=C3=AFv=
e
use and more sophisticated use really necessary?

However, the current message for this use case could seem to be
tweaked to take care of this:

$ git branch BB origin/B
Branch BB set up to track remote branch B from origin.

Add "If you push your changes will go there."
And "See git branch --upstream to modify both settings"

This provides the power of tracking with smaller possibility of
the type of embarrassment you envision.

					-Seth Robertson
