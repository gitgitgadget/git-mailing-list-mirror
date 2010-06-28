From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-rev-parse.txt: Add more examples for caret and colon
Date: Mon, 28 Jun 2010 12:27:24 +0200
Message-ID: <4C28790C.2050301@drmicha.warpmail.net>
References: <7vocewff4b.fsf@alter.siamese.dyndns.org> <97667b60355ab334a390985cae56a28f7a622eb3.1277712897.git.git@drmicha.warpmail.net> <A612847CFE53224C91B23E3A5B48BAC74483CEF65C@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Mon Jun 28 12:28:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTBZo-0006bF-4f
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 12:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589Ab0F1K2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 06:28:23 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56146 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751278Ab0F1K2W (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jun 2010 06:28:22 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E9D8710944F;
	Mon, 28 Jun 2010 06:28:09 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 28 Jun 2010 06:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=XIt5Dx8htw3AQO/xpd/paEqcx3w=; b=bun2V+RMGwM5B12fzQNTFKr6L4v50jYrxIy+3z0WuBsCWledlV7DVgrvrC2algBRkrOtaidtGf2z5ufeS9e3Nvij2basCMSXqmQey1qtB+y0FHE6lKzTn5inT+wCUwi2rDP3gkERhI1YbBS+5wbjz2nvw3jo5jeXXR6gMhpr7zY=
X-Sasl-enc: yTQbGZA13/CPDqMbFd08qnLYwD49mSg7Yh6MYNnt/rwc 1277720889
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F0F014EC169;
	Mon, 28 Jun 2010 06:28:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100625 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483CEF65C@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149829>

Peter Kjellerstedt venit, vidit, dixit 28.06.2010 12:03:
>> -----Original Message-----
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
>> Behalf Of Michael J Gruber
>> Sent: den 28 juni 2010 10:18
>> To: git@vger.kernel.org
>> Cc: Junio C Hamano; Matthieu Moy
>> Subject: [PATCH] git-rev-parse.txt: Add more examples for caret and
>> colon
>>
>> Several items in the caret, colon and friends section contain examples
>> already. Make sure they all come with examples, and that examples come
>> early so that they serve as a visual guide, as well.
>>
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> This is on top of the ":path" patch to git-rev-parse.txt.
>>
>> I chose not to rewrap the paragraphs so that the diff is clearer,
>> especially with --color-words.
>> I don't know what the best patch workflow guideline is here. Maybe
>> rewrapping a v2?
>>
>>  Documentation/git-rev-parse.txt |   15 ++++++++-------
>>  1 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-
>> parse.txt
>> index d525e57..da5cdf4 100644
>> --- a/Documentation/git-rev-parse.txt
>> +++ b/Documentation/git-rev-parse.txt
>> @@ -256,7 +256,7 @@ the `$GIT_DIR/refs` directory or from the
>> `$GIT_DIR/packed-refs` file.
>>    the branch the ref is set to build on top of.  Missing ref defaults
>>    to the current branch.
>>
>> -* A suffix '{caret}' to a revision parameter means the first parent of
>> +* A suffix '{caret}' to a revision parameter (e.g. "HEAD^") means the first parent of
> 
> Shouldn't that be
> 
> * A suffix '{caret}' to a revision parameter (e.g. `HEAD{caret}`) means the first parent of
> 
> for consistency?

Both of them render the same with my asciidoc. I don't mind making it
consistent.

~ and ^ are dangerous with asciidoc 8, but we compile with
asciidoc7compatible, so this is a non-issue.

> 
>>    that commit object.  '{caret}<n>' means the <n>th parent (i.e.
>>    'rev{caret}'
>>    is equivalent to 'rev{caret}1').  As a special rule,
>> @@ -282,23 +282,24 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
>>    and dereference the tag recursively until a non-tag object is
>>    found.
>>
>> -* A colon, followed by a slash, followed by a text: this names
>> +* A colon, followed by a slash, followed by a text (e.g. ":/fix nasty bug"): this names
> 
> Most examples in this file seem to use `` rather than "".

I did not do the statistics, many use `, many use ', and many use ".
The first two often render in the same way.

> 
>>    a commit whose commit message starts with the specified text.
>>    This name returns the youngest matching commit which is
>>    reachable from any ref.  If the commit message starts with a
>>    '!', you have to repeat that;  the special sequence ':/!',
>>    followed by something else than '!' is reserved for now.
>>
>> -* A suffix ':' followed by a path; this names the blob or tree
>> +* A suffix ':' followed by a path (e.g. "HEAD:README"); this names the blob or tree
>>    at the given path in the tree-ish object named by the part
>> -  before the colon. ":path" (with an empty part before the colon)
>> +  before the colon.
>> +  ":path" (with an empty part before the colon, e.g. ":README")
>>    is a special case of the syntax described next: content
>>    recorded in the index at the given path.
>>
>>  * A colon, optionally followed by a stage number (0 to 3) and a
>> -  colon, followed by a path; this names a blob object in the
>> -  index at the given path.  Missing stage number (and the colon
>> -  that follows it) names a stage 0 entry. During a merge, stage
>> +  colon, followed by a path (e.g. ":0:README"); this names a blob object in the
>> +  index at the given path. Missing stage number (and the colon
>> +  that follows it, e.g. ":README") names a stage 0 entry. During a merge, stage
>>    1 is the common ancestor, stage 2 is the target branch's version
>>    (typically the current branch), and stage 3 is the version from
>>    the branch being merged.
>> --
>> 1.7.1.621.g01d76
> 
> I tried to find a document describing documentation standards for 
> git (i.e., something similar to Documentation/CodingGuidelines),
> but could not find any such document. Did I just miss it, or does
> it not exist?

Ironically, I have tried to suggest something like that, together with a
series of patches implementing that. Feel free to try again ;)

As a general practical rule, I think we try to stay "locally
consistent", i.e. within the surrounding context.

For current asciidoc:
'foo' is emphasized
`foo` is monospaced and literal (not expanded)
`foo' is enclosed in single quotation marks
``foo'' is enclosed in double quotation marks

(In fact, for us `foo` is not foo because we compile with
no-inline-literal to shut off asciidoc 8.4 changes for inline literals.)

Michael
