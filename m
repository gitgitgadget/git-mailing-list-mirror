From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] git help: group common commands by theme
Date: Wed, 06 May 2015 10:42:55 -0700
Message-ID: <xmqqoalxbo0w.fsf@gitster.dls.corp.google.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<vpqfv7ap25j.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?S=C3=A9bastien?= Guimmara 
	<sebastien.guimmara@gmail.com>, git@vger.kernel.org,
	sunshine@sunshineco.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 06 19:43:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq3Li-0002n2-43
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 19:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbbEFRnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2015 13:43:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53186 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751336AbbEFRnE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2015 13:43:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C69634F31D;
	Wed,  6 May 2015 13:42:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tU7FfHBuVlY9
	4QGH0P8Qqz3Ogw0=; b=F+ZB4Ms3KypiJnvzDa/tYznEagveSES1jEXmfCslHJpO
	b043Gfv7Hz15GUAeANpdDRdFEY1x4Wd1esjoxes0s/4NNDFf2bmE8mpt9gKLynKO
	gWTOn6JUr10doVAHi1MNAv55PWOoopdYwWaK0nEuxvLzrem5PLDxBmUHZp3nk10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bFIvtD
	5p8/ReQhugDMs6KJwb39wyqcqCrjIjwTb60TNUJTMCtu7XRcNaxOsyjq2lSX33ap
	x0SJUhOlhn0Ctk0x7sEyS/ceLz0F8vRzeCuEBYLZg4r6J9AFZwPd20qI+EVIZ/Iy
	zXCGW+NZIjl5YJbMhwev6HvnbZVDdOUJql8EI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF2594F31C;
	Wed,  6 May 2015 13:42:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DDD84F31A;
	Wed,  6 May 2015 13:42:57 -0400 (EDT)
In-Reply-To: <vpqfv7ap25j.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	06 May 2015 09:59:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 54D61A6E-F417-11E4-8CD4-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268473>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com> writes:
>
>>    * examining the history and state:
>>       log        Show commit logs
>>       status     Show the working tree status
>>
>>    * growing, marking and tweaking your history:
>>       branch     List, create, or delete branches
>>       checkout   Checkout a branch or paths to the working tree
>>       commit     Record changes to the repository
>>       diff       Show changes between commits, commit and working [.=
=2E.]
>>       merge      Join two or more development histories together
>
> I would have put "diff" next to "status" in the "examining the histor=
y
> and state" section. It's neither growing, marking nor tweaking the
> history.

I am somewhat torn on this.

Your suggestion is about "what does this command do?"  Which is a
perfectly acceptable way to categorize commands once you nailed your
workflow down.

There is another school of thought to organize them according to "in
which phase in your development cycle do you use this command?",
i.e. more workflow oriented categorization.  From this point of
view, "diff" and "status" are important tools you use while "growing
your own history".

> But removing rm and mv seems weird. It seems to me that the obvious
> question of someone who just learnt "add" would be "and how do I do t=
he
> opposite?".

And the answer may confuse that someone even further (it is not
necessarily "rm", but is often "reset").  As a list of simple
command set to help the dip-your-toes-in-water process, a new user
may be better off starting with "add", "add ." and "commit -a", and
learn from the last part of "git add --help" that there are "rm" and
"mv" (both of which happen a lot less often than "add").
