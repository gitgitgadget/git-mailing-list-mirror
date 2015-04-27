From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update git-multimail to version 1.0.2
Date: Mon, 27 Apr 2015 11:25:03 -0700
Message-ID: <xmqqoam9whs0.fsf@gitster.dls.corp.google.com>
References: <1430133445-21488-1-git-send-email-mhagger@alum.mit.edu>
	<xmqq618hxxya.fsf@gitster.dls.corp.google.com>
	<vpq383ltoxi.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:25:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmniY-0006uq-2v
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 20:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965083AbbD0SZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 14:25:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964867AbbD0SZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 14:25:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E082E4CB15;
	Mon, 27 Apr 2015 14:25:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MEJW432K4R941zHFnbsHfpNOrE8=; b=b0GZLI
	Is+/nCtjzPO8LV7vjsnW+M9TqiLzTG9YRWCrbIml5BOXfY1s94+Fuo8kykvK3HPb
	+euxVSCgc8lFBsBNQUKDx4yQpjaPJEevOSOXW+5TAhPSbmsQEUdqIft9519nyZRY
	iQOTb3/nVBhzqAVwAl4vuYa9ACj/Zoft1pVB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vwzyu4gUwrHW+Rc3vWdHDTPWkpx+x/uo
	xYNNIIJvLTYrMvUDvqDn9QQNFV4w8Z2T99uiM20y6x4CyFf18wi4K1tGQtOVR/DX
	eL0s7P4BYuQRZ12f5EpMPXXlrKt5PzYMVa2KlVv3y7EkQmC0glhIcOo5h4LHeGbv
	CnWZynHxf6Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D7BAF4CB14;
	Mon, 27 Apr 2015 14:25:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D61D4CB0F;
	Mon, 27 Apr 2015 14:25:04 -0400 (EDT)
In-Reply-To: <vpq383ltoxi.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	27 Apr 2015 20:18:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B9672752-ED0A-11E4-9F59-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267866>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> --- a/contrib/hooks/multimail/README.Git
>>> +++ b/contrib/hooks/multimail/README.Git
>>> @@ -3,13 +3,13 @@ section of the Git project as a convenience to Git users.
>>>  git-multimail is developed as an independent project at the following
>>>  website:
>>>  
>>> -    https://github.com/mhagger/git-multimail
>>> +    https://github.com/git-multimail/git-multimail
>>>  
>>>  The version in this directory was obtained from the upstream project
>>> -on 2014-04-07 and consists of the "git-multimail" subdirectory from
>>> +on 2015-04-27 and consists of the "git-multimail" subdirectory from
>>>  revision
>>>  
>>> -    1b32653bafc4f902535b9fc1cd9cae911325b870
>>> +    8c3aaafa873bf10de8dddf1d202c449b3eff3b42 refs/tags/1.0.2
>>
>> Huh, really?
>
> What's the problem with this hunk? I just checked, and the tag is there,
> with the right sha1.

The patch is to apply to a file in my tree, so "The version in this
directory" is "contrib/hooks/multimail/git_multimail.py" in my tree.

Was that obtained from the upstream project (i.e. you) and match
your 1.0.2 tag?

$ git rev-list -1 master contrib/hooks/multimail/
b513f71f6043c05c3918e670b332dfa7ec6b2661

which is b513f71f (git-multimail: update to version 1.0.0,
2014-04-07)
