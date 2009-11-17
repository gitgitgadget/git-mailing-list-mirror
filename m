From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] user-manual: new "getting started" section
Date: Tue, 17 Nov 2009 10:25:18 -0800
Message-ID: <7vocn1dn5d.fsf@alter.siamese.dyndns.org>
References: <7vr5ss64e5.fsf@alter.siamese.dyndns.org>
 <94a0d4530910241316r3fc4136emd036d18aa45a4192@mail.gmail.com>
 <7vy6n02mrk.fsf@alter.siamese.dyndns.org>
 <94a0d4530910250243k4cbc3c18l5e018a05e5afdb2d@mail.gmail.com>
 <20091025111438.GA11252@progeny.tock>
 <94a0d4530911111515q643e263bn3adc6b47cd968d3d@mail.gmail.com>
 <4AFBF18E.7070906@drmicha.warpmail.net>
 <20091114060600.6117@nanako3.lavabit.com>
 <94a0d4530911161452xe82858el322a1985341bf13c@mail.gmail.com>
 <20091117210625.6117@nanako3.lavabit.com>
 <20091117172815.GH31767@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Hannu Koivisto <azure@iki.fi>, Jeff King <peff@peff.net>,
	Wincent Colaiuta <win@wincent.com>,
	Matthias Lederhofer <matled@gmx.net>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 19:26:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NASkY-00060N-VQ
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 19:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755033AbZKQSZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 13:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754917AbZKQSZr
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 13:25:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754827AbZKQSZq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 13:25:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3C0D9F67B;
	Tue, 17 Nov 2009 13:25:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=MF5D5C3Y/KNvzKJORPiM7Khasz0=; b=eww7ok2LlGXP0qdD0KprAJT
	UZcQ+XRNCrYht7PZ0YuhWK1QgXx7Ju1z2+C5XUziV34Hbb/sgfrsR634L1NPyjhR
	WZxQu4xIDcXF3X6qvaAxQzGyHH9UJpFpE4OnAdiatIRJOEZSZwK0mdkaqqkYnRft
	lgR8nNnd/PHmEaNyPfZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=t/TCK1wqBqbtia8PZ/q6qAVFr9rCROcORXf/3YkBmTrB9UokL
	OjWhaywoy3/vNT1JJJfFpwIqntb2+kEfAXdMn7ee+nD0BNHTO0uD3xLvJoTiylrr
	R5HWSzhvDImbvGoBsvOSoA7M8dD55Mealz5eWdtiHpATlMZ0C7kQqj1xdo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EA659F67A;
	Tue, 17 Nov 2009 13:25:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 077319F670; Tue, 17 Nov 2009
 13:25:19 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D062A8C-D3A6-11DE-9D7C-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133098>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Tue, Nov 17, 2009 at 09:06:25PM +0900, Nanako Shiraishi wrote:
>> David's proposal introduced two magic tokens STAGE and WORKTREE.
>> 
>>   git diff STAGE WORKTREE   (like "git diff" today)
>>   git diff HEAD WORKTREE    (like "git diff HEAD" today)
>>   git diff WORKTREE HEAD    (like "git diff -R HEAD" today)
>>   git diff HEAD STAGE       (like "git diff --cached" today)
>>   git diff commit STAGE     (like "git diff --cached commit" today)
>> 
>> This looks nice on surface, but I think the apparent niceness 
>> is shallow. If of course has a small problem of introducing an 
>> obvious backward incompatibility. You can't use a branch whose 
>> name is STAGE anymore, but a deeper problem is that these two 
>> magic tokens pretend to be refs. But they do so only to the diff 
>> command. I don't see how you can make them sanely be usable to 
>> other commands like "git log v1.0.0..WORKTREE".
>
> Doesn't appear that refs have to point to commits; e.g., on the linux
> project:
>
> 	git log v2.6.11-tree..v2.6.32-rc7
> 	error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a
> 	commit
> 	fatal: Invalid revision range v2.6.11-tree..v2.6.32-rc7

True.  A ref can even point to a blob.

I think "diff" always takes two (pseudo-)tree-ish in David's world, and
you should be able to use these magic topens anywhere that expects a
tree-ish.  For example:

    $ git checkout STAGE Makefile

would be a way to say "please check out the version of Makefile in the
staging area".  And

    $ git archive WORKTREE
    $ git archive STAGE

would be a version of tar that is index-aware.

But we do not have to support commit-ish operations, such as "git log".

It is a different story if these pseudo-refs that denote tree-ish are
useful outside the context of "diff".  I do not think of many commands
that take arbitrary tree-ish other than the ones I mentioned above.  Even
though they take arbitrary tree-ish, people almost always use commit-ish
with them.

Which points to another issue with the approach.

The original intention of these magic tokens are to make things easier,
but they actually may make things _harder_ to teach, because you have to
explain why "git log WORKTREE" does not work but "git archive WORKTREE"
does.  Admittedly, you already have to explain your example to people
saying "it does not work because v2.6.11 is a tree and a tree by itself
does not have a point in history", but the thing is, v2.6.11-tree and
v2.6.11 are oddballs, and you do not have to give that explanation very
often, simply because the users are not exposed to a raw tree.

But WORKTREE and STAGE tokens are _meant_ to be exposed to them much more
prominently.  That's the whole point of the "git diff STAGE WORKTREE"
proposal.

People would become aware that they are very different from ordinary
commits, and then eventually they will realize that they are not even
trees [*1*].  

At that point, I suspect that these magic tokens become larger UI warts
themselves; they behave differently from everything else that is spelled
in all caps (e.g. HEAD, ORIG_HEAD, MERGE_HEAD).

As to --tree-vs-index counterproposal (was it a counterproposal?), except
for that I think they are too long to type in practice and need to be
shortened to be useful, I do not have a fundamental objection against it.


[Footnote]

*1* For example, I would not expect that we will make "git show WORKTREE"
to build a tree on the fly by running "git add -A && git write-tree" with
a temporary index and then running "git show" on the resulting tree
object, because there would be a better response than that if a user asks
"please show my worktree".
