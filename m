From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] doc: fix 'git status --help' character quoting
Date: Mon, 20 Oct 2014 12:54:10 -0700
Message-ID: <xmqq38ai34bh.fsf@gitster.dls.corp.google.com>
References: <1413728235-1504-1-git-send-email-philipoakley@iee.org>
	<xmqqwq7vr91j.fsf@gitster.dls.corp.google.com>
	<8D139BC1FB1E4335B4375FB0F056BB0B@PhilipOakley>
	<xmqqy4sa3bpk.fsf@gitster.dls.corp.google.com>
	<DB0FCB7CEC8C453D9237CA4FFA687EDC@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "GitList" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 21:54:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgJ23-0006TZ-Lb
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 21:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbaJTTyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 15:54:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60260 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751540AbaJTTyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2014 15:54:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C86D617B60;
	Mon, 20 Oct 2014 15:54:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DpwJYS/Iy2Uw0CxqGxrtNbDc4jI=; b=g1ZHXd
	cRw5QYqUvR08FjUhfxWgBdmqHQ1WdaZuISQERlF9IKrFw8Q5HGTBb7nWzc1G+xju
	diTkpUdE1aV7jQmTtSzOLpwJdNVLR83831rR9th8NFWtJpMiwMMm+grdwodhYYce
	MIb8yilLRfRipNc9MWPYdsjnKf3fdMg1V5iQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vTrkcamKO9fe8fjWX9OCV8ZZBn1h+xXf
	OotAjX4/n7aUKwSfh8vIc8CeVMxOeCLDym+Ynb2RJg2xdzgBDstakYiWJPOqU3NS
	vs8WoZa6akVeBn3PschURVpaB/hzaohQAvuGmTKMM3ORjIvxJ2c1f5/KNyUJ4+t4
	Z2ar1qEJeLw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF96617B5F;
	Mon, 20 Oct 2014 15:54:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 496D017B5E;
	Mon, 20 Oct 2014 15:54:11 -0400 (EDT)
In-Reply-To: <DB0FCB7CEC8C453D9237CA4FFA687EDC@PhilipOakley> (Philip Oakley's
	message of "Mon, 20 Oct 2014 20:28:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC56A128-5892-11E4-9E2F-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
> ...
>> I think it is just the font. I just opened the above page with
>> Chrome and futzed the text from '0' to '0123456789' to see how it
>> look.  That round thing is consistent with how other digits are
>> rendered.
>>
>> https://plus.google.com/u/0/+JunioCHamano/posts/dzNXV2FwP6K
>>
>> (sorry for a URL to plus)
>>
>>> https://www.kernel.org/pub/software/scm/git/docs/git-status.html
>>> (which IIUC is out of date) has an unformatted 0.
>> --
>
> I've just had a look at how it formats when the zero is back-tick
> quoted s /ASCII 0/ASCII `0`/ and it looks OK with both Chromium and
> Firefox on my hack Ubuntu laptop - the character is colourised and
> full sized, and the --man page output looks unchanged and clearly a
> zero.
>
> my hacky attempt at an in-line patch (squash in?) below:

You'd need a matching change to 34 in the same document to preserve
the consistency the original patch sought, though ;-)
