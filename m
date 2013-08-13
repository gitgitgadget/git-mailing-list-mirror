From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Tue, 13 Aug 2013 09:00:04 -0700
Message-ID: <7v4natzim3.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr> <ku0lqj$qvs$1@ger.gmane.org>
	<vpqk3jwcb1q.fsf@anie.imag.fr>
	<7v1u649e5m.fsf@alter.siamese.dyndns.org>
	<vpqbo57clnb.fsf@anie.imag.fr>
	<7vwqnu6aei.fsf@alter.siamese.dyndns.org>
	<vpqzjsmhvjg.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Damien Robert <damien.olivier.robert+gmane@gmail.com>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 13 18:01:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9H2K-00018l-28
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 18:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106Ab3HMQB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 12:01:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60168 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758765Ab3HMQAL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 12:00:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E836437983;
	Tue, 13 Aug 2013 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Lti9P1W/afArEpjyC9keYEPzdY=; b=M/naOA
	L9SSGd8x69QLbPcnYkbF7DEJxitQV4/JKnqkPCuIln6TKOQpsShLROnn4t+/CoFB
	tb7fEaOkMki9TP2mZm1+CUfRDkmNTOktYa5tKEs0MPt4YMM5ZbOelD8kuCiI0mZI
	Y51b5hLcARfrQnSdF44rVLOYHTFcPpsis7oS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ThPqV/aumZgy2A3IHLXPhWt9ZWXCZe2w
	XQEqCcUsOkUhAutU3Eg0NtK/kA/k5cQd1Co0prwPUxvnDTQ1WDb2oPrb7ZyU3Crl
	vb5pNirwwJn3ZG5qSqhYYiG5gT/zAb8TCn+x3rhee0CA5FckRTEaoZqNZSywgYCT
	6CbF2Wr/MtI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3A7537982;
	Tue, 13 Aug 2013 16:00:10 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F37E43796F;
	Tue, 13 Aug 2013 16:00:08 +0000 (UTC)
In-Reply-To: <vpqzjsmhvjg.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	13 Aug 2013 09:58:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D9BCB20-0431-11E3-9471-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232230>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> +changes.  You can emulate `git log` with a trivial script that pipes
>
> I'd say "You can emulate `git log` and `git log -p`" here, but I'm fine
> with your version too.

By `git log`, I meant "`git log` with its various options", as it
felt unnecessary to single `-p` out.  But will reword anyway.

>> -[NOTE]
>> -Most likely, you are not directly using the core
>> -Git Plumbing commands, but using Porcelain such as 'git add', `git-rm'
>> -and `git-commit'.
>
> This removal sounds unrelated, but I don't understand what this note was
> doing here anyway, so it's good to remove it.

Yeah, the removal is part of "...and this document is not where the
end users learn what `git log` command is about.  Stop at briefly
mentioning the possibility of combining rev-list with diff-tree to
build your own log, and leave the end-user documentation of `log` to
the new tutorial and the user manual".

Thanks.
