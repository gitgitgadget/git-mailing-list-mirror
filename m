From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git add -e documentation: rephrase note
Date: Mon, 19 Oct 2009 17:39:57 -0700
Message-ID: <7v3a5evqxu.fsf@alter.siamese.dyndns.org>
References: <20091014222628.GK6115@genesis.frugalware.org>
 <20091019063446.GA1457@coredump.intra.peff.net>
 <7vaazn7tg4.fsf@alter.siamese.dyndns.org>
 <200910191142.03446.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Miklos Vajna <vmiklos@frugalware.org>,
	git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Tue Oct 20 02:40:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N02lv-0003at-EW
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 02:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128AbZJTAkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 20:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756080AbZJTAkH
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 20:40:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066AbZJTAkF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 20:40:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A9085FE79;
	Mon, 19 Oct 2009 20:40:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fsqE+WEUEsIhmjl4bPsDQOqFQM0=; b=Q7CIl8
	RUYM+t01KzjZaaXS3jQ9KkxIwP77CpJesvbjw2skWa3HaU8NaJd+33CFkuZgEjSP
	HZvBuJmQs5z9Ezrw7A4qKBDXyxG4YGUSGI2syiig9LVl3gecmIOKe94rIYZlE8Oc
	3cXO4J4M/j6LgRm97Oz6o5Zm731jNFrmTkyOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dhCrBGozkgW9HEyXzO9xpRW8ISbSAwIw
	j+0LiSaqrev4JD7s5mY/peNyNVhV5sbGbxwiiT9Xcz2kORBXaJxAQnBwJ7cR803c
	xmqaTFWJnEjPoZ/BTZSdJqz1RhlU5nS2KNCVbUGDTOf6UVugsya38GXYq2SS8wsR
	LAFvuqSxJjU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AF1A5FE78;
	Mon, 19 Oct 2009 20:40:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 24F165FE77; Mon, 19 Oct
 2009 20:39:59 -0400 (EDT)
In-Reply-To: <200910191142.03446.wjl@icecavern.net> (Wesley J. Landaker's
 message of "Mon\, 19 Oct 2009 11\:42\:03 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1B9BF3EC-BD11-11DE-8B85-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130747>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> On Monday 19 October 2009 01:07:23 Junio C Hamano wrote:
>> That is Ok; the comment was not about stage vs add.
>>
>> > But beyond that, yes, you are right that removing a "+" line may have a
>> > different conceptual meaning to the user depending on the surrounding
>> > text. I wonder if such a "check-list" document really makes much sense,
>> > given that using "-e" at all means you need to understand the patch
>> > format and what makes sense (i.e., anybody who understands 'patch'
>> > knows that you can't just delete context lines and expect it to apply).
>>
>> Yeah, that is really what I wanted people who are in this discussion to
>> eventually realize ;-)
>
> Comment from the peanut gallery:
>
> I still think a quick summary checklist is useful even for a seasoned 
> developer that is intimate with the 'patch' format, as it lets users know 
> what git will do with your patch modifications.

Oh, that is not something I am against at all.  I (mis)took Peff's "what
makes sense" to cover more than what a patch format is, namely, "what the
user by modifying the patch and 'add -e' by accepting a modified patch are
doing."

> For example, when I first tried "add -e", my first thought was: "Awesome, 
> but, I wonder if git will do the right thing if I modify the patch in THIS 
> way ...". Fortunately, git did the right thing, but I wasn't really sure 
> until I tried it.

Actually, my "change +b to +e" example was meant to illustrate that git
is not necessarily doing the right thing.

Admittedly, there is no way to always do the right thing unless git can
read user's mind in this case, and realization of why it is impossible to
do is necessary before using "add -e"; otherwise you would end up getting
utterly confused.  I do not use "add -e" myself.

In one edit (i.e. "remove +c"), the intention is clear that the insertion
is merely kept out of the index and it might even eventually be added in a
later commit.  "c" could be a debugging "printf()" that the user may not
ever want to commit.  In either case, it is clear that the user wants to
keep that change in the work tree version.

In another edit (i.e. "change +b to +e"), the only thing that is clear is
that the user wants a version with "e" in the next commit.

Changing from "+b" to "+e" in "add -e" might have been done, in order to
change "+if (1 || debug)" in the work tree version to "+if (debug)" in the
version to be committed (so that the user can keep debugging without
giving the --debug option to the program, for example).  In this case, it
is quite similar to the earlier "remove +c" ("I know I inserted 'c' in my
work tree version, do not commit that change, but I do want to keep it in
my work tree") case, and keeping the work tree intact is the right thing
to do.

But it might have been done because the user spotted a typo in "b" and
wanted to correct it to "e", in which case the user may wish the change
be reflected to the work tree.

As there is no way to distinguish the last two cases (and I do not think
the code even attempts to tell the difference); half of the time you would
(perhaps mistakenly) think that "add -e" did a wrong thing to your typofix
edit, after adding the updated contents correctly to the index: "I told
git to fix the typo 'b' to 'e', and I committed the corrected version, but
then it discarded my fix---the typo is still there in my work tree".
