From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Wed, 01 Apr 2015 10:03:52 -0700
Message-ID: <xmqqpp7nn5l3.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<871tkblapv.fsf@javad.com> <55147D27.1060204@kdbg.org>
	<87lhidlebw.fsf@javad.com>
	<xmqqh9t1rv0r.fsf@gitster.dls.corp.google.com>
	<xmqq8uedrtdb.fsf@gitster.dls.corp.google.com>
	<87vbhgks0v.fsf@javad.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sergey Organov <s.organov@javad.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 19:04:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdM3d-000865-2N
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 19:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbbDARD4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 13:03:56 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58830 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753026AbbDARDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 13:03:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D61643D13;
	Wed,  1 Apr 2015 13:03:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U9/o45kOPpJu94Lt8U1nRARF7QY=; b=VLUMKx
	y+QkbeHfNOEJ66Hav8fu7N6pUCg5F/BoeZEtEFXBn3Ru/I2+QnNp+0vCODspft56
	3jVQdTWbo5su8fwKF920LFbAi9nBMmw/2IwguePZnRFV7AXzlITUyoXfBDwDptXO
	iCVZOPJMC0b2sQn5o6/9ArGVaDnkKtAYCc1ls=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M3kFNY7hArZS5eti4ARbvwDGdrUstjpp
	tGXcUsByAr0Urg4mojUxx6zq83SxsFNhKFf0YPWzy14dTmPc9Ny8d+4JlJwlCtRF
	tunJS17hxnbYEgvhIeoiyN/H/mqEAcwOlXo4UUS7INl+U/gfVtFWWuud9wJGldrx
	PSmzHfAjyAo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7530643D12;
	Wed,  1 Apr 2015 13:03:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E313E43D0E;
	Wed,  1 Apr 2015 13:03:53 -0400 (EDT)
In-Reply-To: <87vbhgks0v.fsf@javad.com> (Sergey Organov's message of "Wed, 01
	Apr 2015 14:27:28 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13A63B92-D891-11E4-BB99-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266611>

Sergey Organov <s.organov@javad.com> writes:

> Nope. It seems like cherry-pick takes care of that:
> ...
> What do I miss?

The fact that cherry-pick did not flag it as a potential conflict
situation where a manual verification is required (the cherry-pick
process can be fooled by textual similarity and either add the same
thing twice or fail to add one thing that is needed).
