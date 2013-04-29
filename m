From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Mon, 29 Apr 2013 11:43:40 -0700
Message-ID: <7vmwshi3dv.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
	<7vvc7baahc.fsf@alter.siamese.dyndns.org>
	<CALkWK0=NWSZsARu9w0DwpEmJHKnvpB8yoNfEa31LDQA=cV-90Q@mail.gmail.com>
	<CALkWK0ntZKaEzA0Jupj6poOMydqUumEGVVJ-uhBE12sPJ0ntjw@mail.gmail.com>
	<7vppxj6thv.fsf@alter.siamese.dyndns.org>
	<CALkWK0n9xqQr30QWEuhuM9c1xrAJ=SpYVBjkiRk+tP5E7DtBGw@mail.gmail.com>
	<7vhaipl2ks.fsf@alter.siamese.dyndns.org>
	<CALkWK0npQwFnFNpEzT5mgh5HvGUKf=Jz7v4Mn62BDBzb+qjY_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:44:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWt3M-0000hX-GH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672Ab3D2Snp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:43:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932407Ab3D2Snm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:43:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0240E158FB;
	Mon, 29 Apr 2013 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Xoc0G5SKRiV7PK6vaZCaitdQkjs=; b=YnTpVS
	DddgwGHD0RK0IxiCVY456LnOHODikXoxz5QDISGUwbJ6Ol+wXJSq6tKC432cNR/M
	X35TLG86atsrsTlQlHyTXhxK5K2T4U7cBg4n1YoWi7aXqCgIuCUk7wSq5XbigBkH
	HJ1khPM6Br5hcCXBAqYLS6HJHcQWJFxcmk2wE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n8Uk35qJM8C3QN7NwtEiulLJaRGBlw/B
	EXnKvnd/I0aiBfY90q9JKVTifgKSFQntMMKR3O9v+D4JbzAH2E9Ham9n5vpu4Bpt
	lyRt5lRTIbxDEBwKX4hnfu4RrhC6XUm9JaPzGq69sd/kbtobqeE4H584YPrZ14Ag
	OZVSVLQXLig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED35E158F9;
	Mon, 29 Apr 2013 18:43:41 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7172A158F4;
	Mon, 29 Apr 2013 18:43:41 +0000 (UTC)
In-Reply-To: <CALkWK0npQwFnFNpEzT5mgh5HvGUKf=Jz7v4Mn62BDBzb+qjY_A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 29 Apr 2013 23:51:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B681D416-B0FC-11E2-AF6D-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222844>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

>>> $ git log rebase.autostash ^$(git merge-base rebase.autostash master)
>>
>> Depending on which one of B or C is chosen it is either one of these:
>>
>>  - range "^B H" which lists "H G D C"
>>  - range "^C H" which lists "H G D B"
>>
>> neither of which is more useful than "H G D", as it shows irrelevant
>> "other merge base" you did not pick.
>
> Correction:
>
> Range "^B H" lists "H G D A..C" while range "^C H" lists "H G D A..B".

Now you confused me.  A is reachable from B (or C) and you
are saying "^B H" (or "^C H").  Why does either of it show A?

Wait.  What does "lists H G D A..C" even mean?  H, G and D I would
understand, but how does "log" ever "list" A..C???

Now you really confused me.

A is not listed (it is explicitly marked uninteresting by being on
the left side of double-dots).  So we see either "H G D C" or "H G D
B".  We see no A in either case, no?

> In reality, it shows A..B, which is what I want and what am claiming
> is "useful".

What does it mean "log" "In reality" shows A..B?  Didn't you just
say it either lists "H G D C" or "H G D B"?  Neither B nor C is what
you did since you forked?  Now, what did you do since you folked
(which is the question you are asking)?  You made commit D,
back-merged from upstream to record G, and then made another commit
H.  That "H G D", which is what you get from "log F..H", isn't it??
