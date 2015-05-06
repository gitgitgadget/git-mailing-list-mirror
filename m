From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 4/4] t1006: add tests for git cat-file --allow-unknown-type
Date: Tue, 05 May 2015 21:37:14 -0700
Message-ID: <xmqqa8xicoed.fsf@gitster.dls.corp.google.com>
References: <55463094.9040204@gmail.com>
	<1430663402-26717-1-git-send-email-karthik.188@gmail.com>
	<1430663402-26717-4-git-send-email-karthik.188@gmail.com>
	<CAPig+cTOVFem74yr4HPqDRU3-4s_B58jQsx14ntp5FsB0WR6SA@mail.gmail.com>
	<55482984.1000600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 06:37:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypr5H-0002Vn-HY
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 06:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbbEFEhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 00:37:18 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751177AbbEFEhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 00:37:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F3D2D48C37;
	Wed,  6 May 2015 00:37:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Za6DZxz4dGBlwtwePVVNNaH/4Jk=; b=nSmZfI
	aapdq+TWq8UdaccYiZdFAL6B+5Fl8FibLvKR0EW4kPMvdAzUMXnhYRzd9OeaaXOM
	jbCK+EUppkCHidsbtWmDKu6XbdndujK/tnowVB+noZqYQn/Gs1LsYmiUHVONbarn
	7FEFKbvIkXnm5uzU6Fiqnz7dLW2c2xVio/u64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=horSVLHs6AYrBGp8J68PmPb3iKcEZQPJ
	SPbNhqdx9za8yXbN8Io3eVTRsOF2NeuK/yvElAQM+1BNBWjqrw2L5gdpQ/OYqauc
	yu8+feO3xyLKZa8GY8ZLQwFfijqkqpvq99vtSenbikVF5nXlL139eseP3hlqMF+S
	TseFZhto9iM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBF9448C36;
	Wed,  6 May 2015 00:37:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6F87848C35;
	Wed,  6 May 2015 00:37:15 -0400 (EDT)
In-Reply-To: <55482984.1000600@gmail.com> (karthik nayak's message of "Tue, 05
	May 2015 07:53:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9222546E-F3A9-11E4-A052-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268445>

karthik nayak <karthik.188@gmail.com> writes:

>>> +    test_expect_success "Type of $type is correct using --allow-unknown-type" '
>>> +       echo $type >expect &&
>>> +    git cat-file -t --allow-unknown-type $sha1 >actual &&
>>
>> Indentation is still botched in this test and the next one (as
>> mentioned previously [1]).
>>
>> [1]: http://article.gmane.org/gmane.comp.version-control.git/268005
> It only seems to have affected the test file, I made sure the
> indentation was correct after your previous suggestion, I have to see
> why this is happening. Thanks

Any other updates planned for this series?  If it were only the
indentation in the tests, I could locally amend to skip one
round-trip if I wanted to hurry, and that is why I am asking, as I
am planning to start merging topics down to 'next' soonish...

Thanks.
