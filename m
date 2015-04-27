From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update git-multimail to version 1.0.2
Date: Mon, 27 Apr 2015 11:44:50 -0700
Message-ID: <xmqqk2wxwgv1.fsf@gitster.dls.corp.google.com>
References: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq618hxxya.fsf@gitster.dls.corp.google.com>
	<vpq383ltoxi.fsf@anie.imag.fr>
	<xmqqoam9whs0.fsf@gitster.dls.corp.google.com>
	<vpqh9s1s9by.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:45:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymo1a-0000C2-9j
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 20:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbbD0Sox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 14:44:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964801AbbD0Sox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 14:44:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 294F44B31E;
	Mon, 27 Apr 2015 14:44:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QHLwxiwpop8gF6Oe7C3+k80JwYY=; b=YMQLQ7
	2i+6nePiI8RDLddrNd0LP9mjtemnzcMtZ197OzEzSdYHJRS2o2WwkPfMGeKw4VN2
	yJKlY01dSzVDvPOexKM2KzyxcR1eXTsS19AUxdd/ZuAFSXjcE0XSN68e6nWbFL9h
	6LSAdjQmv24sgmaWQI/BB+2tSaKiaC1kTUauQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AP269UG6VvVcaiMi/LSqlT7t3UcnjxKF
	C+xtoPP3MchiZhe35yeeDr/qxSB/MAQQM68x6chPSTvvzbRaRXrtDB9QjykFy2G0
	dFZaikLoes9OILddQKLytR6NUOZ6kJ1mIOkJrc2ofiFeKoYEgUhqOTBcFTATOLH0
	L7x5b2fhQiY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 225924B31D;
	Mon, 27 Apr 2015 14:44:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99CE64B31C;
	Mon, 27 Apr 2015 14:44:51 -0400 (EDT)
In-Reply-To: <vpqh9s1s9by.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	27 Apr 2015 20:41:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7D0E94F4-ED0D-11E4-A79C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267869>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>>> --- a/contrib/hooks/multimail/README.Git
>>>>> +++ b/contrib/hooks/multimail/README.Git
>>>>> @@ -3,13 +3,13 @@ section of the Git project as a convenience to Git users.
>>>>>  git-multimail is developed as an independent project at the following
>>>>>  website:
>>>>>  
>>>>> -    https://github.com/mhagger/git-multimail
>>>>> +    https://github.com/git-multimail/git-multimail
>>>>>  
>>>>>  The version in this directory was obtained from the upstream project
>>>>> -on 2014-04-07 and consists of the "git-multimail" subdirectory from
>>>>> +on 2015-04-27 and consists of the "git-multimail" subdirectory from
>>>>>  revision
>>>>>  
>>>>> -    1b32653bafc4f902535b9fc1cd9cae911325b870
>>>>> +    8c3aaafa873bf10de8dddf1d202c449b3eff3b42 refs/tags/1.0.2
>>>>
>>>> Huh, really?
>>>
>>> What's the problem with this hunk? I just checked, and the tag is there,
>>> with the right sha1.
>>
>> The patch is to apply to a file in my tree, so "The version in this
>> directory" is "contrib/hooks/multimail/git_multimail.py" in my tree.
>>
>> Was that obtained from the upstream project (i.e. you) and match
>> your 1.0.2 tag?
>
> Yes. Isn't that what the text above says?

Well, the patch does not update git_multimail.py at all.  Requoting
the part you omitted from my response

    $ git rev-list -1 master contrib/hooks/multimail/
    b513f71f6043c05c3918e670b332dfa7ec6b2661

    which is b513f71f (git-multimail: update to version 1.0.0,
    2014-04-07)

it matches what "was obtained from the upstream project on
2014-04-07".

Or did you forget to include the update to the software in the
patch?
