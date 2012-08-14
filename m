From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Your branch and 'origin/master' have diverged
Date: Tue, 14 Aug 2012 10:19:27 -0700
Message-ID: <7v628lbdcw.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1WTbMSK8dOus6pFCa2C9vGA8QNE3+8w0LFmGkvcfq5fg@mail.gmail.com>
 <87zk5x6fox.fsf@thomas.inf.ethz.ch>
 <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 19:19:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1KmI-0003ZH-RW
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 19:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab2HNRTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 13:19:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33302 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809Ab2HNRTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 13:19:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1F35644E;
	Tue, 14 Aug 2012 13:19:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qWi7/UW8I7KBKInWbUmtQSQ+2Nc=; b=ggFJoN
	oeNM+qBIykUXu0L4iqtkUrADnhhzSNHulmTzlKATdgBeSQvvtQByPkj1HtiGKMLO
	BEjh4nhxwS/P9uXM9fnCQMzhG4GTgyoBSoTnF0TC5T1dxB6eQYZOqPBZE6AIvs24
	uJ7PqMXTvavqFYhBSbcXgvjnlCpaYP0mYaHlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ELm8KPPOoBovotaHWaE4dfGFmFqjnRPY
	eUrysDZ9S68cN//JQDmAaPx/tPHnPNR4d6Ag+ksS3TSuY56h3v2d6XCoTXfInjfU
	wACy3jT4hdTptXoARpi+PJ/ab2CmF4Baxp00L/FcIqYrL5kBRXuTnDD7vaPGwhX2
	9Bksw1+dqdQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFF4B644D;
	Tue, 14 Aug 2012 13:19:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1927F644A; Tue, 14 Aug 2012
 13:19:29 -0400 (EDT)
In-Reply-To: <CAE1pOi1YFe9GB1L_==RTecEAipdTKj2-ixpwTnrmOgkkV8rkYw@mail.gmail.com> (Hilco
 Wijbenga's message of "Tue, 14 Aug 2012 10:04:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 347CC950-E634-11E1-9330-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203417>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> On 14 August 2012 01:27, Thomas Rast <trast@student.ethz.ch> wrote:
>> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>
>>> # On branch master
>>> # Your branch and 'origin/master' have diverged,
>>> # and have 250 and 19 different commit(s) each, respectively.
>>> #
>>> nothing to commit (working directory clean)
>>>
>>> He asked me what to do and I told him to do what has always worked for
>>> me in the past when something like this happened: gitk, "reset master
>>> branch to here" (to a commit before the divergence and using --hard),
>>> git pull origin master. Problem solved.
>>
>> There are several layers of pitfalls and misunderstandings here.
>>
>> * Is your work origin/master..master (that is, anything in master but
>>   not origin/master) really so worthless as to make "scrap it all!" the
>>   normal course of resolution?
>
> Of course, it's master. Nobody should be working on master directly.

What a strange thing to say.  When will 'master' ever be updated
then and how?

If you mean 'master' as the integration branch for everybody to meet
and make progress, it would be more common for everybody to be
working on his own topic branch until perfection of the topic,
concluded by merging the completed topic to master and pushing the
master out to update it, no?

>> * pull = fetch + merge!  Repeat this a few times until it sinks in.
>>   Then print it on A0 and stick it up in your office or something.
>
> Yes, I know.
>
>>   For your case this means that the pull command is roughly equivalent
>>   to
>>
>>     git fetch origin master
>>     git merge FETCH_HEAD
>>
>>   The two-arg form of fetch does *not* update origin/master.  Assuming
>>   you got the reset right, the merge will fast-forward to whatever
>>   origin's master points to -- but origin/master is still the old state!
>
> Ah, now we're getting to something I did *not* know. :-) So FETCH_HEAD
> != origin/master?
>
 I tried to find out more information about
> FETCH_HEAD but there doesn't seem to be much. I have seen "FETCH_HEAD"
> show up in the terminal but always just ignored it as a Git
> implementation detail. When/how does origin/master get set then? I
> always assumed that was part of git fetch and then git merge would
> actually move master to origin/master.

It could be "git fetch --help" is failing for you, but I am
reasonably sure most if not all of the above are answered there;
another thing something you may not have known :-).

>> Taking all of this together, I think you should stop using two-arg
>> pull[*] or fetch, and replace your error-prone recipe with simply
>>
>>   git fetch
>>   git reset --hard origin/master
>>
>> Assuming, as before, that your local work is worthless.  Is it?
>> Otherwise it would be better to run something like
>>
>>   git fetch
>>   git rebase origin/master

Yeah, the latter makes sense, and I think it is a safer superset of
the former.  If there is nothing of value on 'master', the rebase
might stop and give control back to the user, but the user can tell
it to skip the cruft that came from the old 'master'.

>> [*] it's ok if you use it with an URL instead of a remote nickname
>
> Why would that be okay? What is the difference? Isn't the nickname
> just an alias for a URL?

As long as you tell what refspecs to use on the command line, the
remote nickname behaves as "just an alias for a URL", so yes,
because Thomas is discussing "two-arg pull or fetch", one arg being
either nickname or URL and the other is an explicit refspec on the
command line, it would be okay because there is no difference in
that case.
