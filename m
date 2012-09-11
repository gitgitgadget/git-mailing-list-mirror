From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should GIT_AUTHOR_{NAME,EMAIL} set the tagger name/email?
Date: Tue, 11 Sep 2012 09:53:26 -0700
Message-ID: <7vk3w0ijqx.fsf@alter.siamese.dyndns.org>
References: <CACBZZX7Ud8Xx225ss6SYqZFXyW0FG2XJimBWdvW_NuMqn8yOnA@mail.gmail.com>
 <m2ehmlwxb2.fsf@igel.home>
 <CACBZZX4Egrx_vrKNV68pL8DL4xkLd5j8o-1t4+fA7+Ai758-9g@mail.gmail.com>
 <m2a9x9wwma.fsf@igel.home>
 <CACBZZX61pfus=coO4bh8LwKb578nrnL-gQqa_xQH__uqSe9fJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 18:53:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBTib-000173-5C
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 18:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758916Ab2IKQxa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Sep 2012 12:53:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40181 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757516Ab2IKQx3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Sep 2012 12:53:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9007B7C0D;
	Tue, 11 Sep 2012 12:53:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Enn0LYn+61AC
	pmMxD5aYEsuzKIs=; b=jGBX4wijsXpQQbWG3iU+xpBVwgF1iOZOCLq3VVDueOFE
	lo5UyFgl0OsAEqjCT0/bm+hENaAJt8U/QBgRqx8noTlC8IktOG36Wuobbu6dRJtG
	u2gmIVJ0naeYDyiUozAxExmRu6lf5a0r+f7AN7r3Z1hKSBb76WusD/a7dYWBhI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EVRirD
	hF8ACl+Q3qbI/nh7foFw5b/A2EJHIUYXM8W3IH1ok8LzF84QKsR2TdeqM88V4ChO
	AAmsZz/ub9Q9R4RsohtyPgIeHTsvLrBt4Ls02MN2CtzyCl9/meQZrMgT/gYEUgXT
	NI59TZ5WrF3oqnSSrdsgtaITmSv4GcIa5OFp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BCBF7C0C;
	Tue, 11 Sep 2012 12:53:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D19667C09; Tue, 11 Sep 2012
 12:53:27 -0400 (EDT)
In-Reply-To: <CACBZZX61pfus=coO4bh8LwKb578nrnL-gQqa_xQH__uqSe9fJA@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 11 Sep
 2012 16:56:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 357AD820-FC31-11E1-8720-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205250>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Sat, Sep 1, 2012 at 6:12 PM, Andreas Schwab <schwab@linux-m68k.org=
> wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> I don't get what you mean, what committer info?
>>
>> GIT_COMMITTER_{NAME,EMAIL}.  A tagger isn't really an author.
>
> Ah, am I the only one that finds that a bit counterintuitive to the
> point of wanting to submit a patch to change it?
>
> If you've created a tag you're the *author* of that tag, the
> author/committer distinction for commit objects is there for e.g.
> rebases and applying commits via e.g. git-am.
>
> We don't have a similar facility for tags (you have to push them
> around directly), but we *could* and in that case having a
> Tag-Committer as well well as a Tagger would make sense.
>
> Junio, what do you think?

Unless your name is Linus Torvalds and it is early in year 2005, I
wouldn't even think about it.

When we introduced "tagger name can be overriden with environment",
we could have added GIT_TAGGER_{NAME,EMAIL}, but we didn't.  Given
that tagging happens far far less often than committing, I think it
was a sensible thing to do.

It is a perfectly normal thing in Git for you to commit a patch
authored by other people on behalf of them (and that is why AUTHOR
exists as a separate name from the committer), but you still stand
behind the commits you create by setting COMMITTER of them to you.
The fact that it was _you_ who create the tag has similar weight
that you have your name as the committer in commit objects, so in
that sense, I think the semantics used for the name in tag is far
closer to COMMITTER than AUTHOR.

I guess I wouldn't mind too much if "git tag" learned a "--tagger"
option, and honored GIT_TAGGER_{NAME,EMAIL} if set (and otherwise,
fall back to GIT_COMMITTER_{NAME,EMAIL}), but I do not know if it is
worth it.  How often would you want to _lie_ about your identity
when you are tagging, and what legitimate reason do you have for
doing so?
