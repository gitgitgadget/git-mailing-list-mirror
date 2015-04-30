From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2015, #04; Mon, 27)
Date: Wed, 29 Apr 2015 18:37:47 -0700
Message-ID: <xmqqpp6m2y6s.fsf@gitster.dls.corp.google.com>
References: <xmqqr3r5uyqg.fsf@gitster.dls.corp.google.com>
	<xmqqbni64kum.fsf@gitster.dls.corp.google.com>
	<CACRoPnR13XZURd4MxiqEQk3tYQmaO-3H4TrV63LMyd+VzvAJDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 03:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YndQH-0002XM-NF
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 03:37:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbbD3Bht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 21:37:49 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750996AbbD3Bht (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 21:37:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0F8E4DD32;
	Wed, 29 Apr 2015 21:37:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VZx+4SWox4TF6wfddPUkcq7Ggiw=; b=mL/8XG
	t0V+Uza3+E/lJlT4hl7w+CIvbnrp3+1o4n+ayfopYwUIhnzBNu4byPNWYsfEwAse
	PZZ/Y91P2r8L1GwYpIPENbJQOutA23a8Dt/7gRG0CsyQDztYY1HZ1me8IjVdsSdO
	kEhEeMyXNhTmksZIMuScXbvscCjpa8Tfm09k4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H53m/0Q9LbZTS6LPg7gLfu9pm3lT8Q5z
	3AwG2v3P2VVVRAXMYfxlTLfJYmN9omBClioKsuluglHaUiXdUkMEkmIXEZaKS/dy
	S0wSbX68iJ5JRaehMRytumHPXqSVczyHhQhr44qWrdDuJIlwVlbtXVUXoCS+EcpS
	/t+sKBYJ7iY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A9E684DD31;
	Wed, 29 Apr 2015 21:37:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DD264DD2B;
	Wed, 29 Apr 2015 21:37:48 -0400 (EDT)
In-Reply-To: <CACRoPnR13XZURd4MxiqEQk3tYQmaO-3H4TrV63LMyd+VzvAJDQ@mail.gmail.com>
	(Paul Tan's message of "Thu, 30 Apr 2015 08:18:25 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81DCC654-EED9-11E4-90E9-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268048>

Paul Tan <pyokagan@gmail.com> writes:

> Hi Junio,
>
> On Thu, Apr 30, 2015 at 6:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>> * pt/xdg-config-path (2015-04-12) 7 commits
>>>  - path.c: remove home_config_paths()
>>>  - git-config: replace use of home_config_paths()
>>>  - git-commit: replace use of home_config_paths()
>>>  - credential-store.c: replace home_config_paths() with xdg_config_home()
>>>  - dir.c: replace home_config_paths() with xdg_config_home()
>>>  - attr.c: replace home_config_paths() with xdg_config_home()
>>>  - path.c: implement xdg_config_home()
>>>  (this branch uses pt/credential-xdg.)
>>>
>>>  Seen some discussions.
>>>  Waiting for a reroll ($gmane/267518).
>
> Only the first patch of the series needed changes, though I'm waiting
> for any final reviews. Do you need me to resend the other patches?

I'd prefer the final submission to be a full series to avoid
mistakes on my end.

Just to be sure, there is no rush.  I just wanted to make sure none
of these is abandoned (and drop any that is).

Thanks.
