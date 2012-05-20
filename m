From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] use 'stage' term consistently
Date: Sun, 20 May 2012 14:11:48 -0700
Message-ID: <7vzk92a76z.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1qqpTxRvjEH32MNqzUeNhgZ1gB+fu=cgvxnSbMB6oBGA@mail.gmail.com>
 <vpqehqxmwpj.fsf@bauges.imag.fr>
 <CAMP44s2DU_3UnHxhgwsTVT59KjLi0+=iW7utuofEyis+_06jGA@mail.gmail.com>
 <CACBZZX4_wjFG4D4_2w8UcvbRwBmJ583QpoP_n-tq+dNds3Bi7Q@mail.gmail.com>
 <7v1umv7ub0.fsf@alter.siamese.dyndns.org>
 <CAHREChgTHZL0sNJ3TkZOL7x4k9x=4GRhrZ6Gm0W+Ai_UnX2FEg@mail.gmail.com>
 <20120519060031.GB23799@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Scott Chacon <schacon@gmail.com>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 23:12:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWDPx-0007rR-Qu
	for gcvg-git-2@plane.gmane.org; Sun, 20 May 2012 23:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab2ETVLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 May 2012 17:11:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51391 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753736Ab2ETVLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2012 17:11:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EEA28087;
	Sun, 20 May 2012 17:11:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AYk4KZ9nH4KkUrYp591hCZNxBhk=; b=rkv4kp
	kpfWbFTQdJEZ2BDgTYPE5DftIoKv+S8gVGww+7kG4kRXN2iIL7EtxQcPKFh53QBU
	ExJ+E4USVucyOH3RsA3Db4kIeeyBrLuTAabGO0YETeRM7jxSSM0Rb7p2RA8j839d
	NrtmjirUXlBA/kpLS1TyO6srpiQz0ypjxSOiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tfkcn1XJE2v2NF3GE4Z825vx45a0VD/3
	vD76F4xs6IKFhgEo9eVUAhheCXce7ZzlUTInib77NHFTXnDcEU3WjHC/RAx17cdO
	Zq6DP9y0VuXlCwVTZdwvhvtEsPlEGOncpDuEapULc3j9tC6vLBrVRhEhJz6n4glo
	L1CowPaEI6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05CD28086;
	Sun, 20 May 2012 17:11:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69BC88085; Sun, 20 May 2012
 17:11:50 -0400 (EDT)
In-Reply-To: <20120519060031.GB23799@burratino> (Jonathan Nieder's message of
 "Sat, 19 May 2012 01:00:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6AA83ECC-A2C0-11E1-8A31-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198070>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Mark Lodato wrote:
>
>> I agree with Felipe that "staging" is the most appropriate term for
>> "adding to the index" in git.  As a native English speaker, I have
>> never thought of "to stage" as relating to shipping in any way.  To
>> me, by far the most common usage is in real estate.  The seller of a
>> home "stages" it by setting up furniture and decorations to make the
>> home as appealing to prospective buyers as possible.
>
> I think staging a home does not fit very well here, actually....
> By contrast, if you run an image search for "staging area", you will
> see examples in all sorts of fields...
> "aire de rassemblement" doesn't get as many hits from a web search,
> alas, so I guess the idiom is not as popular in other languages.

All true.

>    Instead, it would be better to change it to something like:
>
> 	This command modifies the content staged for the next commit
> 	using content found in the working tree.  It typically adds ...
>
> 	The "index" file (see gitindex(5)) typically holds a snapshot of
> 	the content of the working tree, and it is this snapshot that is
> 	taken as the content of the next commit.  Thus after making any
> 	changes to the working directory, and before running the commit
> 	command, you must use the add command to add any new or modified
> 	files.
>
> Sensible?

Comparing between the one before "Instead" and the above one, I would say
it is.

I am hoping that we are not wasting people's time by the same experiment
that already failed very early in Git's history to hide the "concept" of
that which is used to shape the tree that would be recorded in the next
commit that is different from either the current commit nor the contents
in the working tree, and instead this round is about the name of that
thing, which has been called "the index" and also colloquially known as
"the staging area" in many third-party documents.  

I personally think it is a wrong way of thinking to focus too much on the
"name", though. The goal should be increased clarity and ease of learning.
For example, the first sentence in your example reads equally well if it
said "the content _prepared_ for the next commit" without losing clarity
and tells the most important thing it must tell the user: that "add" is
about updating "that thing" that is different from the working tree and
the latest commit, even if "stage" (verb) does not translate well to other
language.

About the "git stage --add/rm" commands in your follow-up message, I have
mixed feelings.  Once users get that making progress and growing history
with Git is all about interacting with "that thing", writing out a new
tree out of it and recording it in a new commit with appropriate parents,
saying "stage" becomes redundant.  You "add", "remove", "patch", etc. to
affect that is recorded in "that thing" (e.g. you do not "add" to commit).

Another reason of my "mixed feelings" is that an interface organized
around what is affected, instead of around what is achieved, may be
counter-productive.  "add" that adds the contents in the working tree
(i.e. you already made the change you want yourself) to "that thing" makes
sense from the work-flow point of view. It is how you edit, test or
eyeball to convince yourself that you are happy with what is in your
working tree, and then approach one step closer to your next commit.

An interface built around "that thing" may have a subcommand that adds
contents to "that thing" regardless of what is in your working tree, but
it is useful in only special occasions (e.g. in filter-branch script that
does not want/need to use a temporary working tree).  Such a functionality
does have a place to live, namely at the plumbing level, but already is
available as "update-index".  But these commands that are organized around
"what" they operate on are and should be of "specialized" kind, not "end
user everyday activity" commands that are designed to give easier time to
people in learning and using the system.
