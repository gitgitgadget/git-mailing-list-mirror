From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Community Book
Date: Tue, 29 Jul 2008 11:25:51 -0700
Message-ID: <7v3alsfsy8.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807290920p62f5d7e1r727a62ef2b4611fc@mail.gmail.com>
 <7vmyk0fux8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 20:27:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNtuZ-0001Tv-Fn
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 20:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546AbYG2SZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 14:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757572AbYG2SZ7
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 14:25:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbYG2SZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 14:25:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 83CC24A2C0;
	Tue, 29 Jul 2008 14:25:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C4C344A2BD; Tue, 29 Jul 2008 14:25:53 -0400 (EDT)
In-Reply-To: <7vmyk0fux8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 29 Jul 2008 10:43:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C90B8A28-5D9B-11DD-81DD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90664>

Junio C Hamano <gitster@pobox.com> writes:

> "Scott Chacon" <schacon@gmail.com> writes:
>
>> So I wanted to develop a really nice, easy to follow book for Git
>> newcomers to learn git quickly and easily.  One of the issues I
>> remember having when learning Git is that there is a lot of great
>> material in the User Guide, Tutorial, Tutorial 2, Everyday Git, etc -
>> but they're all huge long documents that are sometimes difficult to
>> come back to and remember where you were, and I didn't know which one
>> to start with or where to find what I was looking for, etc.
>
> Interesting.  A few comments, before I get dragged into my day job fully.

(cont'd)

I was planning to comment on the contents (i.e. text) but it appears that
most of the stuff was borrowed from the User Manual, so I won't.

	Side note: I wonder if this makes the whole "Community Book"
	GPLv2.  What would happen to the part that includes your own
	screencast?  You do not mind it be contaminated by our licence?

But there seems to be some stuff User Manual does not talk about.

[3_basic_branching_and_merging.html]

 - You've talked about low-level individual objects in an earlier section
   but you stopped at showing a single commit pointing at a tree.  People
   would find branching and merging very hard to get, without
   understanding the commit DAG.  On the other hand, you can explain
   commit DAG without going into details down to trees and blobs in the
   earlier section.  The user manual has "understanding reachability"
   section early on for this exact reason.

[5_creating_new_empty_branches.html]

 - As I repeatedly said on the list, I do not think teaching this is
   useful.  Multiple roots may happen as a result of pushing (or pulling)
   from a repository with unrelated root, but it is not something you
   would want to actively aim for.  At least there needs an explanation
   for the reason why making disjoint roots in the same repository is
   (sometimes) a good thing to do, and what its downsides are.
