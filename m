From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 14:28:34 -0700
Message-ID: <xmqqzj77cq9p.fsf@gitster.dls.corp.google.com>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
	<CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>
	<xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>
	<CAJUTLVUK4+OiS_LDaFsRo_pwxF4nO2vR0zyumHBxBc9+8C3FUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Schneider <thosch97@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 22:28:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ4TH-0001hM-2j
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 22:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbbCTV2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 17:28:37 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751090AbbCTV2h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 17:28:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71C3E4232C;
	Fri, 20 Mar 2015 17:28:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mjL8IdQDELjFUaZVAQEg8yQcd64=; b=CVHaG8
	cVR1kWS6p/mqzUrYtWH2U+xR4PzbTBDGpRgOpqrnAb6ELH+3lBVfdOWBndSbablf
	2NZGtclbsJQYJ062nJTGN6w6wkfnWZQBsdLSpEENi0jF1Lopch16/z5ImGV8Vedv
	UbONbLCCUsndgqXz7uPEvKjuKuLXM7I1iaqKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T3YXXtBUAROEhvmQXfnqIvOlm56xrGKq
	4KXCN2t4UfSGCSUXQ3HH12zNUX7/q82wP2NWuDnssTOhU5i6v6BVna5BIA6ZOSli
	SysjDcjCTHxmBUHFOjGd1DCXV+YNezaP9eGlLxUcGsJbFMW+47lBBVmFkM5/7yYj
	mM1kysxZ8YE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A3AC4232B;
	Fri, 20 Mar 2015 17:28:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B67A34232A;
	Fri, 20 Mar 2015 17:28:35 -0400 (EDT)
In-Reply-To: <CAJUTLVUK4+OiS_LDaFsRo_pwxF4nO2vR0zyumHBxBc9+8C3FUw@mail.gmail.com>
	(Thomas Schneider's message of "Fri, 20 Mar 2015 22:18:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 10FDB8AE-CF48-11E4-8230-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265966>

Thomas Schneider <thosch97@gmail.com> writes:

>> Personally, I honestly am not quite sure why anybody wants to
>> generate manpages in the PDF format like this patch does, unless
>> they are planning to print them on paper, in which case the existing
>> manpages (git.1 and friends) or html pages (git.html and friends)
>> should be an already available source format.
> Somebody in the #git IRC channel...
> ... So, maybe most people are fine with the other formats, but those who
> need PDF can directly generate them.

I think you misunderstood me.  I am not dismissing the need for PDF;
I am just saying that there is no need to directly generate them
from asciidoc sources, especially when there are already manpages
and html pages available as source to "print" to PDF.
