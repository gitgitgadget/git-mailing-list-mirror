From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Should "log --cc" imply "log --cc -p"?
Date: Tue, 5 Feb 2013 06:22:49 -0500
Message-ID: <20130205112249.GE24973@sigill.intra.peff.net>
References: <7vmwvl6lj9.fsf@alter.siamese.dyndns.org>
 <510F95D7.6010107@drmicha.warpmail.net>
 <7vfw1c3ujo.fsf@alter.siamese.dyndns.org>
 <CACBZZX7FJ39sereptAQ40Q4MwEpf15v0H=++WvB7+BpMknxoYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 12:23:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2gcO-0000wx-I4
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 12:23:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab3BELWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 06:22:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33117 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab3BELWx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 06:22:53 -0500
Received: (qmail 28173 invoked by uid 107); 5 Feb 2013 11:24:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Feb 2013 06:24:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Feb 2013 06:22:49 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX7FJ39sereptAQ40Q4MwEpf15v0H=++WvB7+BpMknxoYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215480>

On Tue, Feb 05, 2013 at 11:16:52AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Mon, Feb 4, 2013 at 5:36 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> > "git log/diff-files -U8" do not need "-p" to enable textual patches=
,
> > for example.  It is "I already told you that I want 8-line context.
> > For what else, other than showing textual diff, do you think I told
> > you that for?" and replacing "8-line context" with various other
> > options that affect patch generation will give us a variety of end
> > user complaints that would tell us that C) is more intuitive to
> > them.
>=20
> On a related note I think "--full-diff" should imply "-p" too.

I don't think that is in the same class. --full-diff is quite useful fo=
r
many other diff formats. E.g.:

  git log --full-diff --raw Makefile

If you are proposing to default to "-p" when "--full-diff" is used but
no format is given, that is a slightly different thing. The --full-diff
in such a case is indeed useless, but I do not think it necessarily
follows that "-p" was what the user wanted.

-Peff
