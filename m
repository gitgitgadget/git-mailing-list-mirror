From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Mon, 14 Mar 2016 10:25:27 -0700
Message-ID: <xmqq7fh5as54.fsf@gitster.mtv.corp.google.com>
References: <56E3BE3E.9070105@gmail.com>
	<1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
	<xmqqk2l58s2a.fsf@gitster.mtv.corp.google.com>
	<FB2E0900-A77E-4AE2-A580-9192746A8ABA@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sidhant Sharma <tigerkid001@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 18:29:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afWIn-0000Uk-1i
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 18:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764AbcCNR3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 13:29:04 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751941AbcCNR3C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 13:29:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BDF64C69A;
	Mon, 14 Mar 2016 13:25:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OsM228JK1ICClkpQbycJ3xInHQI=; b=bQygFE
	NrARqaTHlrw1HPxpl3yB0d7OfuifXRBJTKdTAQzePtwTGMNBWB0yVYAS/q5smES8
	lgT5eqdekywcfi8SrHnGIb7TXoeXWwimYNUcszN0P+vrp7/WZvRprU8RSSnbFVZv
	1j8DCUHHV9TDOzhMCz7em5drWXFLk52MqyJpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r0xDtunmtH3v3t1MXyDscYxCwriNXHVd
	vW+6NeRjb6etnKY6L2HnWj3x4Cbk2TqCld49dWm+gfzG9xofNXUtUJz0L1pTOaew
	ZAI2LQII44mEys7Aolm3BU4R7Ek51F05y7fyTo9yastA3CiEn8KL8tEjHeTk9XxF
	YgAwdW0+E18=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 138D04C699;
	Mon, 14 Mar 2016 13:25:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7951A4C698;
	Mon, 14 Mar 2016 13:25:29 -0400 (EDT)
In-Reply-To: <FB2E0900-A77E-4AE2-A580-9192746A8ABA@gmail.com> (Lars
	Schneider's message of "Mon, 14 Mar 2016 09:16:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BF9F1510-EA09-11E5-929E-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288791>

Lars Schneider <larsxschneider@gmail.com> writes:

> On 14 Mar 2016, at 07:57, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I recall back in the days when people said that Hg's command set was
>> so much more pleasant to use that some people thought about building
>> Hg's command line UI on top of low level implementation of the Git's
>> data structure....
>> ...
>
> I think a "ggit" wrapper should not introduce any new commands or
> new parameters. Everything should be passed unmodified to Git.
> The wrapper would only add additional warnings...

Somehow I was assuming that you are aiming for a more ambitious
project, where the users get an easier-to-learn-and-understand
command line UI experience than bare Git [*1*], but none of what I
said about "limiting and omitting" applies if "ggit" will be a
"passthru after examining what goes on" wrapper.

> Maybe "ggit" could also be interpreted as "guided Git" (sounds more 
> friendly than "guarded Git"). I have the impression that many Git 
> beginners make mistakes because they don't have a mental model of Git,
> yet. A "guided" Git version could explain the commands a bit more 
> detailed as they use Git (e.g. with ASCII graph examples). I know
> that's what man pages are for but I've encountered many users 
> (especially on Windows) that are not aware of man pages.

ounds like a lot of work but still a sensible goal.  And that leaves
no room for questioning if it is suitable for Git GSOC, at least to
me--it does fall into the scope of making experience of learning
better for Git itself.

Thanks.


[Footnote]

*1* For example, subversion migrants may say it is confusing to call
    the command "checkout" that is used to clobber files in the
    working tree to the state in the index and may want to call it
    "revert"--and "$SCM revert $path" would be the way the more
    ambitious project would let its users do that operation; it
    would call underlying "git checkout $path" for its users.
    There are other command line UI restructuring that will not
    belong to Git itself but an alternative UI front-end may want to
    use, e.g. "$SCM diff INDEX WORKTREE $pathname" that is turned
    into "git diff $pathname" and "$SCM diff HEAD INDEX $pathname"
    that is turned into "git diff --cached HEAD $pathname".
