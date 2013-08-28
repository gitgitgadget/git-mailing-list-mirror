From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [RFC PATCH] During a shallow fetch, prevent sending over
 unneeded objects
Date: Wed, 28 Aug 2013 17:36:38 +0200
Message-ID: <20130828153638.GF10217@login.drsnuggles.stderr.nl>
References: <20130711220127.GK10217@login.drsnuggles.stderr.nl>
 <CACsJy8CP6pGRwEn6H=cbKxTMuOjzAF3=Qh8qsLbJaw6feK3NMw@mail.gmail.com>
 <7vfvukbrqh.fsf@alter.siamese.dyndns.org>
 <CACsJy8BahoGcDcLjSaHA-62_KQE2wD-p5oeJOOA4nk8ZRfXrEA@mail.gmail.com>
 <20130812080203.GK10217@login.drsnuggles.stderr.nl>
 <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 17:36:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEhnc-00089b-2R
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 17:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753618Ab3H1Pgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 11:36:44 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:37592 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab3H1Pgn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 11:36:43 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1VEhnS-0004QQ-RB; Wed, 28 Aug 2013 17:36:39 +0200
Received: (nullmailer pid 17011 invoked by uid 1000);
	Wed, 28 Aug 2013 15:36:38 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233189>

Hi Duy,

> I thought a bit but my thoughts often get stuck if I don't write them
> down in form of code :-) so this is what I got so far. 4/6 is a good
> thing in my opinion, but I might overlook something 6/6  is about this
> thread.

The series looks good to me, though I don't know enough about the code
to do detailed analysis.

In any case, I agree that 4/6 is a good change, it removes a bunch of
similar code for the shallow special case (which is now no longer a
completely separate special case).

The total series also seems to actually fix the problem I reported. I'll
resend the testcase from my original patch as well, which now passes
with your series applied.

Thanks for diving into this!

Gr.

Matthijs
