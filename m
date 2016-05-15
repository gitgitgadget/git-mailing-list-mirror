From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSOC Update] Week 2
Date: Sun, 15 May 2016 12:17:38 -0700
Message-ID: <xmqqk2iv5dwt.fsf@gitster.mtv.corp.google.com>
References: <1462706822-5189-1-git-send-email-pranit.bauva@gmail.com>
	<1463334359-14033-1-git-send-email-pranit.bauva@gmail.com>
	<vpqr3d32obm.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	larsxschneider@gmail.com, andrew.ardill@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun May 15 21:21:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b21bZ-0005pq-4O
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 21:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbcEOTRm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 15:17:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751220AbcEOTRl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 15:17:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 21A391B62A;
	Sun, 15 May 2016 15:17:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yhJIcrDb62zbN/7e/TbzMADEGnk=; b=czEt9Q
	2UTKJYrGApHCahFZq7eXtLWiJE4owNICZD56CI0jh69IYqLZSPq4f2lJc4uXXJZJ
	aCHKOtQzrbI5q/c2hrzs0bpomJwILZAos2GM5+51IBwyAPk8UgFCsMJH/wOsA7n0
	tZkpx8dsvz14CfxA9IaQ819sDcMYYisBt6T44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NRUn7rOD5QXQFaOCIPSXGquaDmyd1UA5
	0/9tz+0/FoqxLsA7iydddi9ucgk3OAN1j45UpA9S2lF9HfPIO3d34miaFmO0Mh76
	ybVhWGyL2pgWBx/dqqI6ueQGstjVfD8L6+68ZaCyh7JfoSrBxriyKQ2QlooT52EG
	JUaaNsK7RsQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1281D1B629;
	Sun, 15 May 2016 15:17:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 898301B628;
	Sun, 15 May 2016 15:17:40 -0400 (EDT)
In-Reply-To: <vpqr3d32obm.fsf@anie.imag.fr> (Matthieu Moy's message of "Sun,
	15 May 2016 20:01:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B14C3DDC-1AD1-11E6-B5FA-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294679>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> ================================= SUMMARY ==================================
>> My micro project on adding config variable to git-commit for verbose options
>> is going to be merged with the master branch soon and will be available for
>> git 2.8.3 .
>
> Nit: being merged to master doesn't mean you'll be in the next minor
> release, but in the next _major_ one. 2.8.3 will only contain bugfixes
> compared to 2.8.2.

Correct.

Recent "What's cooking" lists the topic as "Will merge to 'master'"
but this does not promise in which timeframe it will be merged to
'master', so it may not even be in 2.9.0 at all.

Generally, what is in 'next' is marked as "Will merge to 'master'"
by default, until a reason not to do so is found, at which time the
mark is changed to "Will hold", etc., so saying "master branch soon"
upon seeing "Will merge to 'master'" is a bit of overstatement.

In fact, "git log maint..pb/commit-verbse-config" shows that this
new feature is not ineligible for the maintenance track.  It will
never be in 2.8.3 or any 2.8.x series.
