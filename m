From: Greg Price <price@MIT.EDU>
Subject: Re: [PATCH 6/6] rebase --rewrite-refs: tests
Date: Tue, 28 Jun 2011 07:22:01 -0400
Message-ID: <20110628112200.GX5771@dr-wily.mit.edu>
References: <cover.1309133817.git.greg@quora.com> <ab6d17ba0ea919e0f873597b60d6c7e9a43460c8.1309133817.git.greg@quora.com> <4E08AAAE.5020604@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 13:38:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbWcG-0001Al-1H
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 13:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309Ab1F1LXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 07:23:05 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:50384 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757266Ab1F1LWD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 07:22:03 -0400
X-AuditID: 12074425-b7b82ae000000a2a-dc-4e09b936c4fd
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 39.B4.02602.639B90E4; Tue, 28 Jun 2011 07:21:26 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p5SBM20E014382;
	Tue, 28 Jun 2011 07:22:02 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5SBM1q2016963;
	Tue, 28 Jun 2011 07:22:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4E08AAAE.5020604@cisco.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixG6nomu2k9PPoPejoEXXlW4mi4beK8wW
	p45+Z3Vg9pjyeyOrx8VLyh6fN8kFMEdx2aSk5mSWpRbp2yVwZVyZ3MxY8IK1ordlJmsD42aW
	LkZODgkBE4nNK3rYIWwxiQv31rOB2EIC+xglVk+T7WLkArI3MErMvNTODuF8YZT4duo0I0gV
	i4CqxILWdWAdbAIKEj/mr2MGsUUE5CWaJl1kArGZBawllp1+BrSNg0NYwFSi/60ZiMkrYCyx
	6HIYxMjpjBKHl7wBO4hXQFDi5MwnLBCtWhI3/r1kAqlnFpCWWP6PAyTMKaApMWPzNbCJogIq
	EquWZk5gFJyFpHkWkuZZCM0LGJlXMcqm5Fbp5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5i
	BAeyi+oOxgmHlA4xCnAwKvHwMq3k8BNiTSwrrsw9xCjJwaQkymuwg9NPiC8pP6UyI7E4I76o
	NCe1+BCjBAezkgjvVCOgHG9KYmVValE+TEqag0VJnDfE+7+vkEB6YklqdmpqQWoRTFaGg0NJ
	gvcByFDBotT01Iq0zJwShDQTByfIcB6g4YtBaniLCxJzizPTIfKnGBWlxHkPgCQEQBIZpXlw
	vbBE84pRHOgVYd5rIFU8wCQF1/0KaDAT0OCyWrDBJYkIKakGxnSGCe4PUw+de2eysoo3ZenB
	Bnkj/quz+gK1C3Or+DxerFTe8DU8/HRC1L8zaQt7OqQurviaa//yEpvlFd9kTmGlKz/jbTm5
	d2YKXVbK3dsX/EqncfWVTbM/OZaWnv6Tun7R9Juuz9KtA58czjgjr1lo0qBWGHld 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176395>

On Mon, Jun 27, 2011 at 12:07:10PM -0400, Phil Hord wrote:
> On 01/24/2010 09:28 PM, Greg Price wrote:
> > +test_expect_success setup '
> > +	test_commit A &&
> > +	git branch topic &&
> > +	test_commit B &&
> > +	git checkout topic &&
> > +	test_commit C &&
> > +	git branch part1 &&
> > +	test_commit D
> > +	git branch part2 &&
> > +	test_commit E
> > +'
> 
> I think there is a missing "&&" at the end of "test_commit D".  But it's
> possible I just don't understand the test machinery enough to know this
> is normal.  Can you explain to me the difference in that case?

Nope, that's just a mistake -- it means that if "test_commit D" were
to somehow fail, we'd move on as if nothing was wrong.  Fixed, thanks.

Greg
