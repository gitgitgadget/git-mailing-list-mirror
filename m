From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Fri, 2 Nov 2012 10:46:18 -0400
Message-ID: <20121102144618.GA11170@sigill.intra.peff.net>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
 <20121029215631.GF20513@sigill.intra.peff.net>
 <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
 <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
 <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
 <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
 <5090EFCA.7070606@drmicha.warpmail.net>
 <CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
 <509149D9.3070606@drmicha.warpmail.net>
 <CAMP44s2PDZwTW55NDho9DyB2XZmsG0-KH4e78grJ2OFRVZkfjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 15:46:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUIW3-0003LG-N3
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 15:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab2KBOqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 10:46:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54551 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601Ab2KBOqV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 10:46:21 -0400
Received: (qmail 5055 invoked by uid 107); 2 Nov 2012 14:47:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 10:47:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 10:46:18 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s2PDZwTW55NDho9DyB2XZmsG0-KH4e78grJ2OFRVZkfjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208939>

On Wed, Oct 31, 2012 at 05:11:39PM +0100, Felipe Contreras wrote:

> > As a patch
> > submitter, you ("generic you") want the attention of others as
> > reviewers. It's in your own (again "generic you") interest not to put
> > them off, in the same way as it's up to the submitter to argue why a
> > patch is desirable and correct.
> 
> Ah, so you are making me a favor by reviewing the code?

I do not want to get embroiled in a discussion of manners and netiquette
(or, for that matter, nazis). But I think this point is worth calling
attention to, because it seems to be at the crux of the matter.

Basically, my opinion is that yes, he is doing a favor to you by
reviewing the code. Just as you have done us a favor by submitting the
code. And this is not specific to this topic or to you as a submitter.
It is a part of how the open source process works.

We have an existing code base that works well. It certainly has some
bugs, and it certainly is missing some features. But people use it every
day and are happy. The maintainers of that code base would want it to
improve over time, but they would also have to be careful not to
introduce regressions. And not just specific regressions in behavior; I
mean regressions in overall quality. A half-implemented feature that
crashes is worse than no feature at all. A change that fixes one bug but
hurts the readability of the code, leading to many future bugs, is a net
negative.

So when a contributor shows up with code, we are very grateful that
they've spent their time improving our software. But at the same time,
we must recognize that the contributor is generally scratching their own
itch. And we must make sure that in doing so, they did not hurt other
people's use cases, nor regress the overall quality of the code base.

It is the job of the maintainer to measure the risk and reward of each
change and to find a balance in accepting patches. But it's difficult to
do alone, and that is why volunteer reviewers on the list are very
valuable. They distribute the reviewing load across many brains, and in
many cases have expertise in particular areas that the maintainer can
rely on.

A submitter has scratched their own itch by writing the code. But if
they cannot cooperate with reviewers enough to get feedback, then the
maintainer has only two choices: review the patches themselves, or
reject the change. And when there is conflict with the regular reviewers
and the submitter, it is a red flag to the maintainer that it might not
be worth spending a lot of time there.

Does the code base suffer for this in the end? Perhaps. There are
features we might reject that could have benefited everybody. But we
might also be saving ourselves from the headaches caused by poorly
thought-out changes. The system cannot work if everybody does not show
up and cooperate.


Now, as for this specific topic: it is proposed for contrib, which means
that expectations are lower, and the rest of git does not suffer too
much if it has rough edges. At the same time, it also means that it
could live fairly easily outside of the tree. In fact, I think Michael
and others have been reasonably happy with their own out-of-tree
implementation.

I do think the proliferation of various implementations has made it hard
for users to see which ones are worth trying. So I think there is value
in carrying something in contrib/, as it would focus the attention of
users, and of other developers to make improvements.

So I think what I'd like to do is take your latest series into pu, with
the intention of merging it into next soon, and then cooking it in next
for a while. That would hopefully make it very easy for people following
'next' to try it out and see how it compares in the field with other
tools they have used (the msysgit one, or others).

I'm a little worried about hurting progress on the msysgit version; it
sounds like the functionality of your implementation is at parity with
that one (thanks to both you and Johannes for answering my other email
asking for a summary).  Johannes did mention that the design of their
tool was meant to eventually facilitate more backends. That's something
that might be valuable; on the other hand, that development hasn't been
happening, and there has been no effort lately on getting it merged into
git.git. I don't want to hold working code hostage to a future plan that
might or might not happen.  So I hope by keeping it in next for a bit,
that will give msysgit people time to check it out and mobilize their
efforts to improve their version if they would like.

-Peff
