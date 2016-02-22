From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] tests: rename work-tree tests to *work-tree*
Date: Mon, 22 Feb 2016 11:35:12 +0100
Message-ID: <56CAE460.8010405@drmicha.warpmail.net>
References: <2e74b7a8e3dd27ccd225b5278500f8a3e029d245.1455985042.git.git@drmicha.warpmail.net>
 <xmqqfuwn9hyp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 11:35:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXnpu-0000SD-6n
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 11:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbcBVKfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 05:35:19 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:60103 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754300AbcBVKfR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 05:35:17 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 8E3D4207D8
	for <git@vger.kernel.org>; Mon, 22 Feb 2016 05:35:14 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Mon, 22 Feb 2016 05:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=TE/hiN/nfjyUj9fIOkQupbxyZ7k=; b=FBsAh1
	PQouTCJI6yLtyx+FbBHRFY27J8WXt2QoaaC8blRreqOp8KWJoUmJrvMG4wvZtVM6
	oRKh50LdphCor1HijRowELLlzayatJa74Ya0MyzFcqnxM9LaOAoryZRRaubJ89kH
	sYct/WHjd62sExeEHXoykb3gdJUa7QjiDeMM8=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=TE/hiN/nfjyUj9f
	IOkQupbxyZ7k=; b=mVX4v8SjBJRdG0E1hS+/q5i4rWc3sSDkybsUlTOfd+kbt0A
	OcFzx3WYQOFHbueJf0pfEGtprBtOsAQ6EX5LgvWWcCuZAPgX/GCWDSWlSSiT5G1j
	wMUylUhoClp/QdNuTsEoXONf/E8fqYQ6lV6K3eAtSkEUuOn+jk2xFeXSDvnk=
X-Sasl-enc: tyTe7aXBGAa+YWQ2ct/bgAsooJvNhvlAEnbBdmSVJgu2 1456137314
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 084FC6800A5;
	Mon, 22 Feb 2016 05:35:13 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <xmqqfuwn9hyp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286907>

Junio C Hamano venit, vidit, dixit 20.02.2016 22:42:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> "Work tree" or "working tree" is the name of a checked out tree,
>> "worktree" the name of the command which manages several working trees.
>> The naming of tests mixes these two, currently:
>>
>> $ls t/*worktree*
>> ...
>> Rename t1501, t1509 and t7409 to make it clear on first glance that they
>> test work tree related behavior, rather than the worktree command.
>>
>> t2104, t7011 and t7012 are about the "skip-worktree" flag so that their
>> name should remain unchanged.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> Just some housekeeping. Not super necessary, but should make it easier to find
>> the right test to amend, for example.
> 
> That is rather unfortunate.  Most of them predate the "worktree"
> subcommand, I think, and having to rename them merely because a
> subcommand with a confusing name appeared sound somewhat backwards.

The question is: What ist the way forward?

I was looking for a proper place for a "git worktree" test and got
confused by the status quo. My suggestion is one way to help that
confusion, but I'd be happy to learn other ways. "grep" is an answer, too.

Maybe it's also time to admit that the numbering and naming scheme in t/
don't scale and that we should rather support other means of navigating
t/, such as standardizing a comment boiler plate in each test or such.

In fact, giving up on the numbering scheme would allow to regroup tests
more easily because there would be no room constraint any more (within a
fixed finite set of numbers).

Michael
