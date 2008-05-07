From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
	configurable
Date: Wed, 7 May 2008 18:04:34 -0400
Message-ID: <20080507220434.GB5994@sigill.intra.peff.net>
References: <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com> <7vprs1ny5e.fsf@gitster.siamese.dyndns.org> <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com> <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com> <alpine.DEB.1.00.0805060954470.30431@racer> <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com> <alpine.DEB.1.00.0805071223450.30431@racer> <7viqxqc4gs.fsf@gitster.siamese.dyndns.org> <20080507194524.GA31500@sigill.intra.peff.net> <7vabj1dgr5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 08 00:06:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtrlj-0001xx-BP
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 00:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760578AbYEGWEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 18:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbYEGWEh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 18:04:37 -0400
Received: from peff.net ([208.65.91.99]:2030 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765552AbYEGWEe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 18:04:34 -0400
Received: (qmail 28083 invoked by uid 111); 7 May 2008 22:04:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 07 May 2008 18:04:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 May 2008 18:04:34 -0400
Content-Disposition: inline
In-Reply-To: <7vabj1dgr5.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81482>

On Wed, May 07, 2008 at 01:02:54PM -0700, Junio C Hamano wrote:

> I suspect that heavily depends on the input text.  If you drop "different"
> in the example, the output becomes:
> 
>     {-This|+Here} is {-a|+some} {-complete|+totally} {-sentence.|+text.}
> 
> which is totally sensible.
>
> [...]
> 
> which would yield on the output:
> 
>     {-This |+Here }is {-a complete sentence.|+some totally different text.}

Sensible, perhaps, but I think the second one is much nicer for English
text (though the first is much nicer for code, I expect).

> It's all in diff_words_tokenize(), which I kept deliberately stupid so
> that people can tweak it to their liking.

OK; I haven't been following the thread too closely, and I wanted to
make sure this was a question of how the tokenizing works, and not a
fundamental problem with this approach. Thanks for the explanation.

-Peff
