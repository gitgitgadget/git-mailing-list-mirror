From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2015, #02; Tue, 14)
Date: Wed, 15 Apr 2015 11:26:06 -0700
Message-ID: <xmqqfv81l03l.fsf@gitster.dls.corp.google.com>
References: <xmqqh9si1itr.fsf@gitster.dls.corp.google.com>
	<552E2211.7080704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 15 20:26:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiS0t-0003C3-Cg
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 20:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755745AbbDOS0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Apr 2015 14:26:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59897 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754441AbbDOS0I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Apr 2015 14:26:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1159C483E0;
	Wed, 15 Apr 2015 14:26:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rL0yvGSQQXIO
	LXOpMCrw4U0KPh8=; b=hoIlAGL9p/MM1TKQkykQ2b1WDGR4pwbQtmKpARE5JpY5
	L7wji1sE3jYsj5tPUbmiBlou0DT0amwciKpb19xpyIjZjAfVphFSDy09O5C7hRsz
	GwUyK8IGIzUgEdBCBjh0d1XB9jX2ZP+cZmV2x4Jxts2pt8xE+f5WPZGC5LyYvdE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZNbRV5
	RrqzRCrvBubgj6Z4f7H8UtZHS3eeIx3rPqbaWNmTQRkoCA5wueZ9T6kzoeTZXfVx
	MW7lBhpB0ij8g7M8P1c/4YV1UWw8u4H7hjz8jEG/V6xWJNRq5DT/zcfzhx3uNCmS
	F8WkfwBJlX05S9i8lBRLwptux9Z4IMfDrc6K8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A3C8483DF;
	Wed, 15 Apr 2015 14:26:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8474E483DE;
	Wed, 15 Apr 2015 14:26:07 -0400 (EDT)
In-Reply-To: <552E2211.7080704@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 15 Apr 2015 10:32:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E2175068-E39C-11E4-9ADB-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267227>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2015-04-14 23.49, Junio C Hamano wrote:
>> * tg/perf-lib-test-perf-cleanup (2013-09-19) 2 commits
>>  - perf-lib: add test_perf_cleanup target
>>  - perf-lib: split starting the test from the execution
>>=20
>>  Add test_perf_cleanup shell function to the perf suite, that allows
>>  the script writers to define a test with a clean-up action.
>>=20
>>  Will hold.
> Is there a chance to squeeze in a fix for this:
> ./t/perf/perf-lib.sh:185: error: echo -n is not portable (please use
> printf): echo -n " c$i"

Of course; please send a follow-up patch. The topic has been stalled
for too long.
