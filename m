From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Tue, 25 Jun 2013 16:17:46 -0700
Message-ID: <1372201438-sup-833@pimlott.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net> <87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net> <1371278908-sup-1930@pimlott.net> <7vk3lvlmat.fsf@alter.siamese.dyndns.org> <87ip1e2tzx.fsf@hexa.v.cablecom.net> <7v7ghtjwbb.fsf@alter.siamese.dyndns.org> <8738shi2ht.fsf@linux-k42r.v.cablecom.net> <7vwqpshkxj.fsf@alter.siamese.dyndns.org> <1372190294-sup-1398@pimlott.net> <7vehbp27vl.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 01:17:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrcUk-0001WF-GU
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 01:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994Ab3FYXRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 19:17:51 -0400
Received: from pimlott.net ([72.249.23.100]:34819 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698Ab3FYXRu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 19:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Cc:Content-Type; bh=8fSQyDUB08+u1vOQQZ8PQeTzpqparSXSOtwBlXC2KCo=;
	b=M3v4oefJxUryctHVo8qMKascU/CVx9SVEqB3DtFfC/Mi1nG9cKDOKQAtcvvNivecBX2y7vAwymIvw/ReqrQST9wK8M37gAFz8yeucQrHeMDt6hQNQe/hd9JA48O/tzrT5btgQER6F/CDOR4+oyDQstqgpOZ7vDXbpV4sEIlUIDA=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UrcUd-0004Z2-0c; Tue, 25 Jun 2013 16:17:47 -0700
In-reply-to: <7vehbp27vl.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229018>

Excerpts from Junio C Hamano's message of Tue Jun 25 14:33:18 -0700 2013:
> Andrew Pimlott <andrew@pimlott.net> writes:
> 
> Just reponding for the "procedual" part for now.
> 
> > So if I don't want to break the discussion, should I append the unedited
> > format-patch output to my message after "scissors", or should I send it
> > as a whole new message with --in-reply-to?  Or something else?  I'll try
> > the first.
> 
> Which is fine, and you are almost there, but you do not want
> 
>  (1) "From 99023b..." that is not part of the message (it is a
>      delimiter between multiple patches when/in case a file contains
>      more than one);
> 
>  (2) "From: Andrew..." that is the same as the e-mail header in the
>      message I am responding to;
> 
>  (3) "Date: ..." which is older than the e-mail header in the
>      message I am responding to---the latter is the date people
>      actually saw this patch on the mailing list, so it is
>      preferrable to use it than the timestamp in your repository.
> 
> So in this case, I'd expect to see, after the "-- >8 --" line, only
> "Subject: " line, a blank and the log message.

Thank you.  It was not clear to me even after several doc readings what
git-mailinfo would look for where.  I think I assumed that the idea was
to transmit the original commit perfectly, and I stubbornly failed to
give up that assumption even when it clearly didn't fit.  Everything
makes more sense with the understanding that the receiver will pull
together non-patch metadata in the way that makes sense from his point
of view (and that a different commit will come back via fetch).  I will
take a whack at clarifying the docs if I have time.

Andrew
