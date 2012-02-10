From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 15:20:08 -0500
Message-ID: <20120210202008.GA5874@sigill.intra.peff.net>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
 <1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 21:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvwx9-0006xd-Ll
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 21:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434Ab2BJUUM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 15:20:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33520
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932337Ab2BJUUL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 15:20:11 -0500
Received: (qmail 7411 invoked by uid 107); 10 Feb 2012 20:27:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Feb 2012 15:27:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2012 15:20:08 -0500
Content-Disposition: inline
In-Reply-To: <1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190449>

On Fri, Feb 10, 2012 at 10:18:12AM +0100, Micha=C5=82 Kiedrowicz wrote:

> The code that comares lines is based on
> contrib/diff-highlight/diff-highlight, except that it works with
> multiline changes too.  It also won't highlight lines that are
> completely different because that would only make the output unreadab=
le.
> Combined diffs are not supported but a following commit will change i=
t.

Have you considered contributing back the enhancements to
contrib/diff-highlight? I took a look at handling multi-line changes
when I originally wrote it, but I was worried too much about failing to
match up lines properly, and ending up with too much noise in the diff.
Maybe your "don't highlight lines that are completely different" rule
helps that, though.

Do you have any examples handy? (I was hoping not to need to get a
running gitweb installation in order to see the output).

-Peff
