From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 18:29:03 +0100
Message-ID: <80myizelcw.fsf@tiny.isode.net>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
            <1219664940.9583.42.camel@pmac.infradead.org>
            <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
            <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
            <20080826145719.GB5046@coredump.intra.peff.net>
            <1219764860.4471.13.camel@gaara.bos.redhat.com>
            <1219766398.7107.87.camel@pmac.infradead.org>
            <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Woodhouse <dwmw2@infradead.org>,
	Kristian =?iso-8859-1?Q?H=F8gs?= =?iso-8859-1?Q?berg?= 
	<krh@redhat.com>, Jeff King <peff@peff.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, users@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:30:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2Mv-00040B-3V
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812AbYHZR3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756639AbYHZR3I
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:29:08 -0400
Received: from rufus.isode.com ([62.3.217.251]:55389 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756337AbYHZR3H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:29:07 -0400
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with SMTP 
          id <SLQ9XwBnext3@rufus.isode.com>; Tue, 26 Aug 2008 18:29:03 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Tue, 26 Aug 2008 18:29:03 +0100
X-Hashcash: 1:20:080826:torvalds@linux-foundation.org::Gpv9wBaM1O5By6yS:0000000000000000000000000000000001ED
X-Hashcash: 1:20:080826:dwmw2@infradead.org::ckhVHfPrDDLYmx6o:0000000000000000000000000000000000000000001yRa
X-Hashcash: 1:20:080826:krh@redhat.com::dLUqfeiI2ulzs/Vo:00024ee
X-Hashcash: 1:20:080826:peff@peff.net::50kvqJ4frkpgiG41:00000Ijt
X-Hashcash: 1:20:080826:git@vger.kernel.org::1V7kk1sJJvKZZqwW:00000000000000000000000000000000000000000001XP
X-Hashcash: 1:20:080826:johannes.schindelin@gmx.de::8RTELO+cYiTOvVP6:000000000000000000000000000000000005enT
X-Hashcash: 1:20:080826:gitster@pobox.com::6Po/rhRXBcvGs5rr:0000000000000000000000000000000000000000000035O0
X-Hashcash: 1:20:080826:users@kernel.org::sJ0TdiI/HmTUJ3LS:00Ts9
In-Reply-To: <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> (Linus Torvalds's message of "Tue\, 26 Aug 2008 10\:03\:25 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93776>

Linus Torvalds <torvalds@linux-foundation.org> writes:

[...]

> In case you wonder, the upside is:
>
>  - new people don't even learn the mistakes
>
>  - the people who _did_ complain are happier
>
>  - this model allows a per-user-preference model even on the same machine 
>    (ie even on something like master.kernel.org, everybody can choose 
>    _individually_ whether they want to see 'git-xyzzy' or not!)

And

  - it means git aliases have the same form as builtins

  - it means git on Windows has the same interface

(Arguably the latter point ought to be "forces Unix users to use the
same interface as on Windows", but the git-foo forms have been
deprecated on all platforms for a while.  Making Unix and Windows the
same seems a worthwhile goal, though presumably it's irrelevant for
linux kernel people.)
