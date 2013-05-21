From: Junio C Hamano <gitster@pobox.com>
Subject: Re: activate color.ui by default (Re: What's cooking in git.git (May 2013, #05; Mon, 20))
Date: Tue, 21 May 2013 08:52:49 -0700
Message-ID: <7vli78qqi6.fsf@alter.siamese.dyndns.org>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
	<vpqd2skzh9c.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 21 17:53:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueorx-0001T3-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 17:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab3EUPwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 11:52:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483Ab3EUPwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 11:52:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 378931E2A2;
	Tue, 21 May 2013 15:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RYOPe08i9Yh4+ffkVEGH2hhJ/xk=; b=hpPfkG
	wujXx8Ny1P5K2cbc803e34ZU9ctfTUGehKyeAxLjWu9hH6bzNf0kz4xRkIjBJInG
	D/ru5Wj4XtKti9/L9ZtzVYqyCIjWHAKzg5VVrq5r6bsVN0egSFeOcv3gsHz95gKc
	chn/ichix4kubQy9trcKs6UNO5hvoMMUQIZLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w1LLCtkt3u619VCweZWoLFpYzylWffHB
	CU1q2MTGrDQTOdhLiusLRhVMTgp1JHwgqTVKt39m8e3tMCwRDmWFjCOhviPvCTZc
	trFeEbDHV77WY+kkwuMPQlGSTnUkfoPNuiqY/CjgeLRycrkZ9Jn16nvD1QgUy9He
	QvertgYccNQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2ACC91E2A1;
	Tue, 21 May 2013 15:52:51 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 863D01E29D;
	Tue, 21 May 2013 15:52:50 +0000 (UTC)
In-Reply-To: <vpqd2skzh9c.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Tue, 21 May 2013 13:47:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D92FBBA-C22E-11E2-AFE5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225035>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * mm/color-auto-default (2013-05-15) 2 commits
>>  - make color.ui default to 'auto'
>>  - config: refactor management of color.ui's default value
>>
>>  Flip the default for color.ui to 'auto', which is what many
>>  tutorials recommend new users to do.
>>
>>  I think this is ready for 'next', but we may want to audit tutorials
>>  to see if we need to adjust them if they suggest to set color.ui as
>>  the first thing to do when they meet Git.
>
> The little grepping I did in our docs didn't show much about color.ui,
> and nothing about its default value (just technical documentation, not
> beginner-oriented).
>
> Other than that, the patch makes the doc say "... `auto` (this is the
> default since Git 2.0)". I'm slightly in favor of delaying the change
> until Git 2.0 and keeping it as-is, but I'm OK with letting it in the
> next minor version if other people think it should

I do not have a strong opinion on this either, but slightly in favor
of saying 2.0 is for changes that are more important than this kind
of thing so we balance out ;-)

> (I did not see strong
> opinion on that, but I think the general opinion from the discussion was
> it would be OK). If so, I can resend without the 2.0 mention (or Junio
> can edit it locally).
