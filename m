From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failure: Test #3 in t1304-default-acl
Date: Mon, 01 Oct 2012 09:07:29 -0700
Message-ID: <7vehlidvlq.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n0bH3xPLarv35Th_agnhKCkRjgcKTJR7Xy=B_NkBHkOg@mail.gmail.com>
 <vpqy5k8raig.fsf@grenoble-inp.fr>
 <CALkWK0=h6iU_J=X6MFgLXPfo0rh236cTuVaU3nNSnAaikjKH5w@mail.gmail.com>
 <vpqd31kr7v4.fsf@grenoble-inp.fr>
 <CALkWK0=ROz8fxXgnqt-+AthU-hgq_mzFg0GhBQCrAshH_mRBPQ@mail.gmail.com>
 <vpqvcfcps2z.fsf@grenoble-inp.fr> <7v4nmwwqox.fsf@alter.siamese.dyndns.org>
 <vpqipbcpp69.fsf@grenoble-inp.fr> <7vvcfctmka.fsf@alter.siamese.dyndns.org>
 <CALkWK0m9tkRXFZw-d_XADR9LXqxa0j_82bhhrd0FoEoHsO6yPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 18:09:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIiX6-0004N1-7s
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 18:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab2JAQHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 12:07:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab2JAQHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 12:07:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6801D9D1B;
	Mon,  1 Oct 2012 12:07:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d1WAdBJjoN2se/chCXXb5jACC90=; b=E1zqnr
	ntbLaaGItDQ+uttEdj0MT674hnQj2a3a/22oflIU1XLWmnvA+jphVT1FjykbkzMq
	WMA0+2O1bJezdqL4KhhHaPkZDVBcqsE02h2fvu4AIN296STgJQ2TLoPLSf7JN+lZ
	7PPJUu0ZjjitjT/sz4NpCUpTP3Eoalecrauo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WRRHfiggRKY6XwiAILoES/d4Q2ktX6Ub
	/ze2JfspA+qzC1bI0nxWNDbX43doVHN1Fwu19+85+zfsaOwm5slqkUuhM8el15Hf
	2HAGH+eGH0Gu1EU0xqBOn3nbghOpA4etX3/44+/TymahT04cwlPW1Qx80BPE1T/p
	+cRguSj5GKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 560CA9D1A;
	Mon,  1 Oct 2012 12:07:31 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA6E99D17; Mon,  1 Oct 2012
 12:07:30 -0400 (EDT)
In-Reply-To: <CALkWK0m9tkRXFZw-d_XADR9LXqxa0j_82bhhrd0FoEoHsO6yPg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 1 Oct 2012 13:08:21 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A62890A-0BE2-11E2-A277-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206739>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi Junio,
>
> Junio C Hamano wrote:
>> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> I haven't been paying attention, but does that mean on that system,
>>>> a total stranger kseygold can write, modify, and remove whatever Ram
>>>> owns?  I am hoping that is not the case.
>>>
>>> I can see two reasons for having the same UID for two login names:
>>>
>>> 1) the sysadmin really messed up, and as you say, a total stranger has
>>> complete ownership of your files. Ramkumar, you should check that this
>>> is not your case.
>>>
>>> 2) the sysadmin explicitely gave two login names to the same physical
>>> person, as kinds of aliases for the same UID (e.g. the person got
>>> married, changed her name and login, but expects ~oldlogin to continue
>>> working). I'm not sure how common this is, and to which extend we want
>>> to support this in our test scripts.
>>
>> I've only been assuming (1), but (2) feels like a legitimate (if
>> confusing) way to configure your system.
>>
>> It is a separate issue if it is worth bending backwards to support
>> it in the test, though.
>
> For what it's worth, `sudo` is "broken" on my system.

Not very surprised ;-)
