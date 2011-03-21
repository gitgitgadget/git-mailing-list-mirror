From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] rev-list --min-parents,--max-parents: doc and test
 and completion
Date: Mon, 21 Mar 2011 06:54:31 -0400
Message-ID: <20110321105431.GB16334@sigill.intra.peff.net>
References: <cover.1300459016.git.git@drmicha.warpmail.net>
 <182c5ece22835559a9762e242adb701547cf6575.1300459017.git.git@drmicha.warpmail.net>
 <20110318194802.GB27825@sigill.intra.peff.net>
 <4D871401.6020900@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 11:54:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1cl1-0007PS-23
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 11:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab1CUKyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 06:54:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52288
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753087Ab1CUKyh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 06:54:37 -0400
Received: (qmail 12049 invoked by uid 107); 21 Mar 2011 10:55:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 06:55:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 06:54:31 -0400
Content-Disposition: inline
In-Reply-To: <4D871401.6020900@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169580>

On Mon, Mar 21, 2011 at 10:01:53AM +0100, Michael J Gruber wrote:

> >> +	Show only commits which have at least resp. at most that many
> >> +	commits, where `--max-parents=8` denotes infinity (i.e. no upper
> >> +	limit). In fact, 7 (or any negative number) does, but 8 is
> >> +	infinity sideways 8-)
> > 
> > I didn't quite parse this "resp." in the middle.
> 
> Well, there are two options (--min-parents, --max-parents) which we
> describe in one paragraph. Sooo...

I figured out what you were trying to say. I just had never seen the
abbreviation "resp." before. I guessed it meant "respectively", but the
syntax is all wrong.

Digging around via google, I was able to find that it is a mathematical
term with a specific syntax, but one I had never seen before. Maybe I am
just clueless and sheltered, but after 30-odd years of reading English
(12 of which involved reading academic computer science papers!), I
can't help but think it is not all that common and may confuse other
readers. Add on top that it is usually used in parentheses, which helps
make it more obvious what is going on.

I really think "Show only commits which have at least (or at most,
respectively) that many commits" says the same thing, but is way more
accessible.

> > That way it is obvious that "--merges" cancels a previous --min-parents
> > on the command line (maybe the text should be "this is an alias for..."
> > to make it clear that doing it is exactly the same).
> 
> Yes, that is helpful. I have doubts about "alias" for. Without wanting
> to sound elitist or something, I have the impression that we start
> catering for users who understand "equivalent" more reliably than "alias".

I just wanted to make sure people didn't think "equivalent" meant "has a
similar effect to" as opposed to "is exactly as if you did". But reading
it again, I think "equivalent" is fine, and I see you picked it up in
the latest series.

-Peff
