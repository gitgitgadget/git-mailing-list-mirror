From: Greg Price <price@MIT.EDU>
Subject: Re: [PATCH 0/6] rebase: command "ref" and options
	--rewrite-{refs,heads,tags}
Date: Tue, 28 Jun 2011 09:17:17 -0400
Message-ID: <20110628131717.GA6822@dr-wily.mit.edu>
References: <cover.1309133817.git.greg@quora.com> <7vhb7bxgt9.fsf@alter.siamese.dyndns.org> <BANLkTinDFYsw7-N=_Ex8i42So_0LzVAWvA@mail.gmail.com> <20110628104758.GS5771@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 15:31:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbYNX-0007BC-IE
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 15:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969Ab1F1NTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 09:19:17 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:42170 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754347Ab1F1NRW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 09:17:22 -0400
X-AuditID: 12074423-b7ce8ae000000a29-84-4e09d45a18a8
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 55.52.02601.A54D90E4; Tue, 28 Jun 2011 09:17:14 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p5SDHKLW023046;
	Tue, 28 Jun 2011 09:17:20 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5SDHIU6028365;
	Tue, 28 Jun 2011 09:17:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110628104758.GS5771@dr-wily.mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42IRYrdT0Y26wulnsGMPr8WqmY/ZLbqudDNZ
	NPReYXZg9tg56y67x8VLyh6fN8kFMEdx2aSk5mSWpRbp2yVwZax5/4+94DdPxfJ5Z1gbGPdw
	dTFyckgImEisar/IDGGLSVy4t54NxBYS2McoceaBcxcjF5C9gVFi/4+n7BDOF0aJDatmg1Wx
	CKhKvGu8ywhiswkoSPyYvw5skohAlMSr5zNYQWxmAXGJdXPPs4PYwgIREt3PHwHFOTh4BYwl
	5r5JgJi5g1Hi4N/FYL28AoISJ2c+YYHo1ZK48e8lE0g9s4C0xPJ/HCAmJ9DRa6/qg5iiAioS
	q5ZmTmAUnIWkdxaS3lkIvQsYmVcxyqbkVunmJmbmFKcm6xYnJ+blpRbpmunlZpbopaaUbmIE
	B7KL8g7GPweVDjEKcDAq8fAyruTwE2JNLCuuzD3EKMnBpCTKu+USp58QX1J+SmVGYnFGfFFp
	TmrxIUYJDmYlEd6pRkA53pTEyqrUonyYlDQHi5I4b673f18hgfTEktTs1NSC1CKYrAwHh5IE
	r8FloEbBotT01Iq0zJwShDQTByfIcB6g4ctBaniLCxJzizPTIfKnGHU5Fr1adphRiCUvPy9V
	Spw3BaRIAKQoozQPbg4sAb1iFAd6S5h3OkgVDzB5wU16BbSECWhJWS3YkpJEhJRUA+OqB8WZ
	sk5e3y+vCE+wUuRVvNiX/CveYmfkuq910iYXlf60Rn8WLHcQlk7s7dTxW+H/+5fgJjYj9iXK
	XVkpjO/2206Yp+Vcae9d7mLnsH69sufWCu1CHb201QwLjm+r/6293TB4jrVn0mzj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176399>

On Tue, Jun 28, 2011 at 06:47:58AM -0400, Greg Price wrote:
> I agree with your footnote -- the more general case will require a
> more powerful sequencer to support properly.  And now I see that
> Ramkumar Ramachandra is making progress on such a thing right now!
> That's great news -- this is a project that has been attempted at
> least four times, by five people (including me), in the last three
> years.  I hope to see this round make it in -- I was actually thinking
> about returning to the problem after seeing this series through, but I
> would be glad to see Ram beat me to it.

[Hello, Ram!]

Hmm, on further reading I'm not sure the sequencer Ram aims to build
this summer actually extends to the "mark" and "reset" commands (or
the concepts of "the rewritten <commit>" and "detach" in the
pseudo-TODO notation of your footnote) that would be required to
implement this broader rewrite-side-branches feature.  It looks like
the focus may be on taking the existing features of rebase and
bringing them into C.

This sounds great too -- it should make rebase a lot faster -- but it
will leave open the pet project I've thought about returning to, of
making "rebase -i -p" work correctly even when the user wants to
rearrange the commits rather than just s/pick/edit/ etc.  That will
require implementing a richer sequencer very like the one required for
a general rewrite-side-branches feature.

Ram, have I correctly read your plans?  For context, see Junio's
remarks upthread about one thing a richer sequencer could be used for:
  http://thread.gmane.org/gmane.comp.version-control.git/176339/focus=176359

Greg
