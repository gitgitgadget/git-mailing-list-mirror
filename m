From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 09:54:50 -0700
Message-ID: <7v8v35hc11.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	<7vvc6ah81g.fsf@alter.siamese.dyndns.org>
	<CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
	<CAMP44s18ps9JtY7+mvXVbuZu3cm7bHnK1vCzMWqBdvawLr+zzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 18:55:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfYnA-0005hT-Lu
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 18:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076Ab3EWQyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 12:54:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759949Ab3EWQyx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 12:54:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3390215BB;
	Thu, 23 May 2013 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dsZTV6Ze8BGrwe9XC6m6U+fkMzk=; b=lnfSnT
	tM2AhueM00ji+Cd00tK7v63OYcdPleqaGm/rmdKDedaaBTpkdUXs7Seg31tV48RU
	lOS9CJH1atb9/zHh+UsqyYT5STlbAnbyZ2ntPLNdK0HgvArjXhFtQeiLxVEbHx93
	ISpByjYEUIDQD5RcHVOyg/5YNq+sv2tqMi/40=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lvg38U81s+nAp5nG2Lgz3a5FeGm2w+6s
	70IY1fuENcgNQYQcqCq62OGK4uTGEL62gP7759UrZeT+vjmSudfjhfcBAPDrFcJU
	VzXaGwLYeyEEftxTguUUIqUQLBBARa8tt77YgUB3wkx3jcntk5KtYLH+PAW2y7ZY
	Jy8N1C3uq2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B875A215BA;
	Thu, 23 May 2013 16:54:52 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E2974215B8;
	Thu, 23 May 2013 16:54:51 +0000 (UTC)
In-Reply-To: <CAMP44s18ps9JtY7+mvXVbuZu3cm7bHnK1vCzMWqBdvawLr+zzA@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 23 May 2013 00:22:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C835598-C3C9-11E2-82A5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225266>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 22, 2013 at 11:07 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Wed, May 22, 2013 at 7:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>>> IIRC, git-gui runs two blames, one without any -C and one with (I do
>>>>> not offhand recall how many -C it uses) to show both.
>>>>
>>>> 'git blame' is a very expensive operation, perhaps we should add
>>>> another option so users don't need to run two blames to find this.
>>>
>>> Yes, you could add a "struct origin *suspect_in_the_same_file" next
>>> to the current "struct origin *suspect" to the blame_entry in order
>>> to represent the origin you would get if you were to stop at a "move
>>> across files" event, and keep digging, when you are operating under
>>> "-C -C" or higher mode.
>>
>> No, this is what I meant:
>
> But that would not print the right line numbers, so perhaps:

Users of full-output may want to be able to see the same thing.

I have a suspicion that you misread what assign_blame() does.  The
first inner loop to find one "suspect" is really what it says.  It
loops over blame entries in the scoreboard but it is not about
finding one "entry", but is to find one "suspect".  The "ent" found
in the loop that you store in tmp_ent is no more special than any
other "ent" that shares the same "suspect" as its origin.

Imagine that your scoreboard originally has three blocks of text
(i.e. blame_entry) A, B, and C, and the current suspect for A and C
are the same, while we already know what the final guilty party for
B is (which may be some descendant of the "suspect").

Once we find one "suspect" in the first inner loop, the call to
pass_blame() does everything it can do to exonerate that "suspect".

It runs a single diff between the suspect and each of its parents to
find lines in both A and C that can be blamed to one of these
parents, and blame entries A and C are split into pieces, some of
which still have the same suspect as their origin, which are where
their lines originate from, while others are attributable to these
parents or their ancestors.

If you keep the original entry for A to do something special, like
printing what the original range of A was before it was split by
pass_blame(), wouldn't you need to do the same for C?  We will not
be visiting C later in the outer while(1) loop, as a single call to
pass_blame() for "suspect" we did when we found it in A has already
taken care of it.

I am not sure what you are trying to achieve with that found-guilty
logic, even if the "save away in tmp_ent" logic is changed to keep
all the blame entries that have "suspect" we are looking at as their
origin.  When the current suspect is found to have passed all lines
intact from its parents, we will see found-guilty left to be false.

How would it make the original blame_entry (perhaps halfway) guilty
in that situation?

> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1500,25 +1500,16 @@ static int emit_one_suspect_detail(struct
> origin *suspect, int repeat)
>  	return 1;
>  }
>
> -/*
> - * The blame_entry is found to be guilty for the range.  Mark it
> - * as such, and show it in incremental output.
> - */
> -static void found_guilty_entry(struct blame_entry *ent)
> +static void print_guilty_entry(struct blame_entry *ent)
>  {
> -	if (ent->guilty)
> -		return;
> -	ent->guilty = 1;
> -	if (incremental) {
> -		struct origin *suspect = ent->suspect;
> -
> -		printf("%s %d %d %d\n",
> -		       sha1_to_hex(suspect->commit->object.sha1),
> -		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
> -		emit_one_suspect_detail(suspect, 0);
> -		write_filename_info(suspect->path);
> -		maybe_flush_or_die(stdout, "stdout");
> -	}
> +	struct origin *suspect = ent->suspect;
> +
> +	printf("%s %d %d %d\n",
> +			sha1_to_hex(suspect->commit->object.sha1),
> +			ent->s_lno + 1, ent->lno + 1, ent->num_lines);
> +	emit_one_suspect_detail(suspect, 0);
> +	write_filename_info(suspect->path);
> +	maybe_flush_or_die(stdout, "stdout");
>  }
>
>  /*
> @@ -1531,14 +1522,19 @@ static void assign_blame(struct scoreboard *sb, int opt)
>  	struct rev_info *revs = sb->revs;
>
>  	while (1) {
> -		struct blame_entry *ent;
> +		struct blame_entry *ent, tmp_ent;
>  		struct commit *commit;
>  		struct origin *suspect = NULL;
> +		int found_guilty = 0;
>
>  		/* find one suspect to break down */
> -		for (ent = sb->ent; !suspect && ent; ent = ent->next)
> -			if (!ent->guilty)
> +		for (ent = sb->ent; ent; ent = ent->next)
> +			if (!ent->guilty) {
> +				tmp_ent = *ent;
>  				suspect = ent->suspect;
> +				break;
> +			}
> +
>  		if (!suspect)
>  			return; /* all done */
>
> @@ -1564,9 +1560,20 @@ static void assign_blame(struct scoreboard *sb, int opt)
>  			commit->object.flags |= UNINTERESTING;
>
>  		/* Take responsibility for the remaining entries */
> -		for (ent = sb->ent; ent; ent = ent->next)
> -			if (same_suspect(ent->suspect, suspect))
> -				found_guilty_entry(ent);
> +		for (ent = sb->ent; ent; ent = ent->next) {
> +			if (same_suspect(ent->suspect, suspect)) {
> +				if (ent->guilty)
> +					continue;
> +				found_guilty = ent->guilty = 1;
> +				if (incremental)
> +					print_guilty_entry(ent);
> +			}
> +		}
> +
> +		if (incremental && !found_guilty &&
> +				!is_null_sha1(suspect->commit->object.sha1))
> +			print_guilty_entry(&tmp_ent);
> +
>  		origin_decref(suspect);
>
>  		if (DEBUG) /* sanity */
