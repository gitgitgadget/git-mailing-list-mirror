From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git ignore help
Date: Tue, 24 Mar 2015 13:54:13 -0700
Message-ID: <xmqqbnji5d6y.fsf@gitster.dls.corp.google.com>
References: <47F.3lxhK.7IviRa5Gutr.1L2}X3@seznam.cz>
	<CAPig+cRU38sNHRsn=8=60wPO_AoQt-zn1dicFHwjG0OK-9tecQ@mail.gmail.com>
	<CACsJy8CGuuRTGycj13cT9d-n=HavzL4LVWC7xjD4Ac=KQGEhBg@mail.gmail.com>
	<CAPig+cT5=3kzEu4CzfYW3QtKqDDHn5uSwocoscFLU-T9M-+wiw@mail.gmail.com>
	<CACsJy8DDC2FbKnu7o1cJR6F6Lh-NabaYtMYOKbm0xbn8PuKoEg@mail.gmail.com>
	<CAPig+cQE6-BaOPZQuQJV-ENX+M7oXhozuZmY0LwkdbwDp8xQhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, mdconf@seznam.cz,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 21:54:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaVq9-0002up-O7
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 21:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbbCXUyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 16:54:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52664 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752212AbbCXUyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 16:54:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B56443D08;
	Tue, 24 Mar 2015 16:54:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wFM7EYSSTk3DVRO/7OMo5O5sQks=; b=DRb+8D
	oB8tUbrCGgIjOlwyRtIt65SAf0vh7r6DhijjGlCUcG2ZVNFbhKFNnBjGgeUGHOSU
	v2B4H2EQkaoxVFbAcBDRonujB1QFAcd6ks+GcYUmY0arjlHg1xEMa2coRp6w9XHJ
	FyTMHyOWPdqFfqVdEAAy17PDkaxcQ08YfcOVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i9y0o1XS57LKnrAMxTCrn2DC+8D/ZiIr
	Al+yf0Hmzq7WcCldfL89FkOLo/ew2puzuWw1yveUSt9gJ8GqndYRp11Scp8DDsHV
	3M+As1smIRs8fhuDvXOgELrhhXxrdwe7pInF9XuGdkQDqo4yonvhFvqj2q4hibGy
	ToECEPn+jYI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33D9B43D07;
	Tue, 24 Mar 2015 16:54:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD46B43D04;
	Tue, 24 Mar 2015 16:54:14 -0400 (EDT)
In-Reply-To: <CAPig+cQE6-BaOPZQuQJV-ENX+M7oXhozuZmY0LwkdbwDp8xQhw@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 24 Mar 2015 13:37:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EE2B756E-D267-11E4-A3CE-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266227>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 24, 2015 at 5:39 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Tue, Mar 24, 2015 at 8:55 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> e.g. "db", "reports" or "scripts", we could keep going for a while. I
>>>> think I attempted to do this in the past and failed (don't remember
>>>> exactly why). Maybe I'll try again some time in future.
>>>
>>> I also was pretty sure that you had attempted this, but couldn't find
>>> a reference to it, so I didn't mention it in my response. However,
>>> with some more digging, I finally located it[1].
>>>
>>> [1]: http://article.gmane.org/gmane.comp.version-control.git/259870
>>
>> Thank you. I only looked at my repo and no branch name suggested it
>> (if only there is google search for a git repository..). So I gave up
>> because of performance reasons again but that was for enabling it
>> unconditionaly. If we enable it via a config variable and the user is
>> made aware of the performance implications, I guess it would be ok. So
>> it's back in my back log.
>
> How much does a config variable actually help? In a sense, one could
> argue that this is already an opt-in feature since it requires
> crafting gitignore in a particular fashion. Existing projects which
> have (properly) functioning gitignore rules won't trigger this
> behavior. In many cases, Git already allows people to shoot themselves
> in the foot if they desire, thus, as long as the potential performance
> impact is properly documented, this could be considered another such
> instance.

Yeah, as I re-read that old thread, I really do not think anything
wrong with the reasoning expressed in the proposed log message.  It
is pointless to hunt for "!do-not-exclude-me-please" in D/.gitignore
when "D/" appears in .gitignore in the higher level, but if these two
i.e.

	D/
        !D/do-not-exclude-me-please

appear together in .gitignore in the higher level, we can pay
attention to that and pick up that single path.  And doing so would
be a lot more intuitive to the end user.

My comment in the thread was only about the documentation being
unclear and not about the feature, but somehow we failed to
follow-up the topic to completion X-<.
