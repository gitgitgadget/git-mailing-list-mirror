From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn tags and branches
Date: Wed, 29 Aug 2007 13:15:55 -0700
Message-ID: <7vhcmip05g.fsf@gitster.siamese.dyndns.org>
References: <faulrb$483$1@sea.gmane.org> <85absc6we7.fsf@lola.goethe.zz>
	<cb7bb73a0708280209r36136128x7bce310bf4fd4f66@mail.gmail.com>
	<86sl64nhc1.fsf@lola.quinscape.zz>
	<cb7bb73a0708280237v6f248517h183174bc41296df3@mail.gmail.com>
	<46D4A664.4070007@vilain.net>
	<cb7bb73a0708281620v41383ed8w728af0112d2a6360@mail.gmail.com>
	<46D4ECE2.9020806@vilain.net>
	<cb7bb73a0708290141y159d6bbfj2bac23af5e86bb15@mail.gmail.com>
	<7v4piisolb.fsf@gitster.siamese.dyndns.org>
	<cb7bb73a0708290353iba0bdefl81a4a4e158be2fbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Sam Vilain" <sam@vilain.net>, "David Kastrup" <dak@gnu.org>,
	git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 22:16:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQTxV-0004ld-KH
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 22:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbXH2UQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 16:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754914AbXH2UQG
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 16:16:06 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:60308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbXH2UQE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 16:16:04 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 477CE12AA61;
	Wed, 29 Aug 2007 16:16:19 -0400 (EDT)
In-Reply-To: <cb7bb73a0708290353iba0bdefl81a4a4e158be2fbf@mail.gmail.com>
	(Giuseppe Bilotta's message of "Wed, 29 Aug 2007 12:53:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56976>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:

> On 8/29/07, Junio C Hamano <gitster@pobox.com> wrote:
>> "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
>>
>> > BTW can git have a tag and a branch with the same name? If
>> > not,...
>>
>> This is "Yes but".
>>
>> You can have a tag foo and branch foo.
>
> [snip]
>
>>  You can clarify yourself to avoid ambiguity like so:
>>
>>   . git branch newbranch heads/foo ;# I mean "branch from foo branch"
>>   . git log tags/foo ;# "show history starting at that tag"
>
> Ok. So assuming we import a svn repo which has a tag and a branch
> called 'name', and that there are post-tag commits in tags/name, how
> do we call the stuff?
>
> We could call 'name' both the (annotated) tag and the branch, but what
> name would we use for the branch created by post-tag commits?

That's the "Yes but" part.  You need to know what you are doing.

As I said in the part you quoted, if you have branch foo and tag
foo, and if you are interested in talking about the tag 'foo',
you say "tag/foo".  When you want to talk about the branch, you
say "heads/foo".  Replace "foo" with "name" and I think you get
your answer.
