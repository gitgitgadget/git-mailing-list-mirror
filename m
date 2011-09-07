From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Documentation: "on for all" configuration of notes.rewriteRef
Date: Wed, 7 Sep 2011 23:29:17 +0200
Message-ID: <201109072329.18338.trast@student.ethz.ch>
References: <f415402994735a60664e1f9f85be490a68b25ed3.1315167848.git.trast@student.ethz.ch> <20110907212310.GH13364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "John S. Urban\"" <urbanjost@comcast.net>,
	Tor Arntsen <tor@spacetec.no>,
	knittl <knittl89@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:29:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1PgW-0001Ly-NA
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134Ab1IGV3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:29:23 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:8402 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757076Ab1IGV3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:29:22 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Wed, 7 Sep
 2011 23:29:17 +0200
Received: from thomas.inf.ethz.ch (129.132.209.196) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.289.1; Wed, 7 Sep
 2011 23:29:18 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.3-41-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <20110907212310.GH13364@sigill.intra.peff.net>
X-Originating-IP: [129.132.209.196]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180915>

Jeff King wrote:
> On Sun, Sep 04, 2011 at 10:27:04PM +0200, Thomas Rast wrote:
> 
> > Users had problems finding a working setting for notes.rewriteRef.
> > Document how to enable rewriting for all notes.
> 
> Hmm. Is this a safe thing to recommend?
> 
> I think the idea of storing something like generation numbers in
> git-notes is dead at this point, but it would be quite disastrous to
> have generation numbers copied to rebased commits. Ditto for something
> like a patch-id cache. Should these sorts of immutable cache notes, if
> and when they do come about, go into a separate hierarchy?

Admittedly I never considered the problem of supposedly-immutable
notes here.  The whole point was to help users who had no idea that
the string put there should probably start with refs/notes/.

So maybe the patch should instead say something along the lines of, to
enable rewriting for the notes ref called foo, put refs/notes/foo --
which to a core gitter of course sounds extremely redundant.

But what about the general issue of users who *have* put refs/notes/*,
and then some software comes along that does not expect them to be
rewritten?  Do we declare the software broken, or discourage from such
blanket rewriting?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
