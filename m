From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2014, #04; Tue, 22)
Date: Wed, 23 Jul 2014 11:10:22 -0700
Message-ID: <xmqqegxcdjzl.fsf@gitster.dls.corp.google.com>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
	<B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:10:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA0zt-0008Ve-MQ
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 20:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbaGWSKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 14:10:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51250 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932563AbaGWSKd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 14:10:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 781722825A;
	Wed, 23 Jul 2014 14:10:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uaVMbH2kfuVliYwyCuwL2jcqfSw=; b=Q0HWg+
	AErb2qi2S57DmCPGeFGimHD65oVIUCFmzNyQDz4dNr2E6FhxQ+Mk5Dtxxk/IEcMb
	9Ufnz0yFCh1Ywcq16TjhRa5ZUiJmc3iBzWa+vDPZdDOLcvjAfcequ4UpCptw9Rw9
	vgnIRx3VE9v5rpFrqW9t4Hea7BlwDdku4UTQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KsiVEmwWdS6cFX3cxEeSKP0RTBQDUrXF
	O8MpJiiJOhJ40W4jjzpoWOiocY3L5jjslYXpcKxGY9NfII66qYftP6A6Ih7cB4IS
	1HJjoMTp0eSNdQYHS3gc39Ke6I4qTdUz1uf5Pvy7P4AAglbJ+CsSIBQQWqDf18+b
	Ib3Hgb1e5T4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6DD7028259;
	Wed, 23 Jul 2014 14:10:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CFFEA28244;
	Wed, 23 Jul 2014 14:10:24 -0400 (EDT)
In-Reply-To: <B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley> (Philip Oakley's
	message of "Wed, 23 Jul 2014 07:56:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9E527EC2-1294-11E4-9D47-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254099>

"Philip Oakley" <philipoakley@iee.org> writes:

>> * po/everyday-doc (2014-01-27) 1 commit
>> - Make 'git help everyday' work
>>
>> This may make the said command to emit something, but the source is
>> not meant to be formatted into a manual pages to begin with, and
>> also its contents are a bit stale.
>
>> It may be a good first step in
>> the right direction, but needs more work to at least get the
>> mark-up right before public consumption.
>>
>> Will hold.
>>
>
> It's not clear to me which bits of mark-up are 'wrong' and must be
> reworked,

It's been too long since I wrote the above and I left it without
updates (these comments are by default carried over from one issue
to the next of "What's cooking" report, unless there is some
development on the topic).  Now I read the output (admittedly, I
skimmed only the HTML version), I think the formatting / mark-up is
fine.

I at the same time found various command sequences used there are
rather classical and there are better ways to do the same with
modern tools, which still makes me feel hesitant to promote this
document without updating its contents, though.
