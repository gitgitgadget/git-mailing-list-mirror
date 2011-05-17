From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add-interactive: shortcut to add hunk and quit
Date: Mon, 16 May 2011 22:09:58 -0700
Message-ID: <7vboz1j4k9.fsf@alter.siamese.dyndns.org>
References: <20110516162611.GA6960@mrq1.org> <vpq4o4uwqin.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>,
	git list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 17 07:10:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMCXv-0008Mq-2W
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 07:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717Ab1EQFKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 01:10:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1EQFKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 01:10:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A605133CC;
	Tue, 17 May 2011 01:12:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=scmDDeb1lzwSm+UhRiyvBKvyf6U=; b=SXQnes
	vFnV0CZ3EFX3y9n8T/1HBYeShX7TTOpq13aYu4AQJZN3jpdXN9ua+pKb0NTv4gLG
	CLBFmNFd+WHqnLGj58F/UXfD62UXHNe2p/M6sNYYeEGYGW9yPGQQwWV5eOCxS0+b
	cWH2s2NHi+F86i8xrzVeXfyZjNyTZ8jxxckqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OkBrD4b+C8ztlSTqffO/O85Ac6WmDu4q
	mjD0FPwY5gd4UzOhHfjP/uQfzrvrg7t1x0NStg+AnphE80h9+gFOy5IbSEHoERV5
	xobQllwyuydL5GPF3YEPX+m72+pzPCvydPZprNZlSdtQHZg+UTIACKzIPkERNF+z
	QL7+EJ6/iJA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73F3533CA;
	Tue, 17 May 2011 01:12:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5AE1533C7; Tue, 17 May 2011
 01:12:06 -0400 (EDT)
In-Reply-To: <vpq4o4uwqin.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 16 May 2011 18:37:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37D4F76E-8044-11E0-A5F8-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173783>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Hermann Gausterer <git-mailinglist@mrq1.org> writes:
>
>> this combines the two commands "y"+"q" to one.
>> i use this if i know that this is the last hunk to add.
>
> (please capitalize the "I", and actually, avoid saying "I" in a commit
> message)
>
> I'm not convinced this is useful enough to deserve a new command. The
> help message already starts being scary ...
>
>> +       Q - quit; stage this hunk but none of the remaining ones
>
> The explanation shouldn't start with "quit" I think. I'd say basically
> "stage this hunk and quit" or "stage this hunk but none of the remaining
> ones".

I agree with both points. Other than that, the changes in this round looks
good to me.

Hermann, care to re-roll for the last time?
