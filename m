From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Friendly refspecs
Date: Tue, 22 Apr 2008 09:52:46 -0700
Message-ID: <7v63u9zva9.fsf@gitster.siamese.dyndns.org>
References: <20080409101428.GA2637@elte.hu>
 <20080409145758.GB20874@sigill.intra.peff.net>
 <20080409200836.GA19248@mithlond>
 <20080409203453.GA10370@sigill.intra.peff.net>
 <20080409222500.GB19248@mithlond>
 <20080409225112.GB12103@sigill.intra.peff.net>
 <20080413093102.GC12107@mithlond.arda.local>
 <20080416034823.GA11727@sigill.intra.peff.net>
 <alpine.LNX.1.00.0804161126280.19665@iabervon.org>
 <7vod89pnxx.fsf@gitster.siamese.dyndns.org>
 <20080422105658.GA11238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 22 18:54:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoLkb-0005LO-Q9
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 18:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755078AbYDVQw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 12:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754175AbYDVQw7
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 12:52:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbYDVQw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 12:52:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CBFD22863;
	Tue, 22 Apr 2008 12:52:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 15E7F2861; Tue, 22 Apr 2008 12:52:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80136>

Jeff King <peff@peff.net> writes:

> The "refs/heads/" dwimmery makes sense to me, because:
>
>   1. it changes a behavior which is currently an error condition, so
>      we're not hurting anyone's existing workflow
>
>   2. In my usage, pushing a branch to a tag (or vice versa) is the
>      exception, so I don't mind favoring pushing like types to like
>      types.
>
> But I recognize that (2) is based on my own workflow, so if people
> disagree, I guess it isn't so for everyone.

So the proposal is:

	"git push $there $commit:$name", when $name does not begin with
	refs/, is interpreted as "git push $there $commit:refs/heads/$name"

right?  I think that makes sense, at least to me.
