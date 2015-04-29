From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 3/5] cat-file: teach cat-file a '--allow-unknown-type' option
Date: Wed, 29 Apr 2015 12:38:54 -0700
Message-ID: <xmqqy4la4tdd.fsf@gitster.dls.corp.google.com>
References: <5540D397.8020104@gmail.com>
	<1430312006-23323-1-git-send-email-karthik.188@gmail.com>
	<CABURp0qCe3aLtnwueh8Jm6Hm-AN1--Dk1NV4Y=oA5XhMsLh1Aw@mail.gmail.com>
	<55411892.7060205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Phil Hord <phil.hord@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git <git@vger.kernel.org>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 21:39:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnXoz-0003S8-3M
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 21:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbbD2Ti5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 15:38:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751155AbbD2Ti4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 15:38:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E531F4C19A;
	Wed, 29 Apr 2015 15:38:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wTQ59CdyzaDAgiNm4FREDBGRAyg=; b=IemZqm
	IEu640B+8w5vMYNBnatvYZHsMDQVGkpwto5QUAvyY1qm1z2Oic3z9vvGFFqX9ICM
	ZtRjPmEFyLtLJJAfTrjjArQXB0AwxNCbVsbzcWxxvAu0ujy1JHfV5ubW/xKW7Py6
	D/WLrToEStf3qCrLv19CH7jpA2g/GXi4z7yGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kSxwIlYaN6pNXxFvBg1chErT0bPaYzUU
	6ye6W1Q3+zN6C0bpRQtnemFHnWSOjKC2tVaHaMWQq6l9Vp4oYls34qtFTO5jWico
	f0SK5AJau+GsR53lDddAlHUVwKnCCGiJmF3YIBHk47k28VmWZe1o1n6cVRmwsmWL
	aDk2IJy+AQM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DEA5D4C199;
	Wed, 29 Apr 2015 15:38:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6776E4C198;
	Wed, 29 Apr 2015 15:38:55 -0400 (EDT)
In-Reply-To: <55411892.7060205@gmail.com> (karthik nayak's message of "Wed, 29
	Apr 2015 23:14:50 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F564650-EEA7-11E4-BCEC-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267995>

karthik nayak <karthik.188@gmail.com> writes:

>> Respectfully, because I know English is a challenging beast sometimes,
>> and spelling is difficult even for many native speakers...
>>
> Thanks for that, Yes it does get a bit tricky with spellings, will
> find an editor with spellcheck and avoid nano :D

;-).

Reminds me of a pecurilar habit my old mentor had that I never
picked up, which is to run "spell" on the code, not just comments
and log messages, to catch misnamed variables.
