From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/Makefile: Allow custom XMLTO binary
Date: Wed, 19 Sep 2012 16:27:04 -0700
Message-ID: <7vvcf9egqf.fsf@alter.siamese.dyndns.org>
References: <1348074397-29978-1-git-send-email-dborowitz@google.com>
 <7vehlxhp0v.fsf@alter.siamese.dyndns.org>
 <CAD0k6qTMm7MKLYOOMaB72cWc=Z8nJfe8qseWfyM6x_NzCorgZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:27:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TETfp-0007hO-U5
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 01:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892Ab2ISX1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 19:27:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60008 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab2ISX1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 19:27:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D16679755;
	Wed, 19 Sep 2012 19:27:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RPRSBP1wuXymtrlJK+MLJyi/asg=; b=sPTN3g
	DN4PH31Tz6Jp2hh9Vi3PJKuPXNWf07an91CQymh+KUGwlZZluXkzssfctDvc9g7V
	cD0Xkx2KvK7eO/gyxyNq/dCqSw42ZcDlC/Hv7TkBCjQTwF9VPIdvgkrFwwZM+TXh
	1zG0ztfqJyjNh6tRBlTNx7mWtZJzFD5DA8XQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BTncvkBIOhW1l/w56lOE9/UUHK8gN9B4
	w02t801DEZ2wbqbw5wv7w/EsAm3mecIg9RqtQDanNgVLv1jSg7cNN6y2bHe2KEtm
	Km2xVcYOrCjcq8u1JVasbBXA4AaisBklclBO98wStUGv0/J5c9zXxcQEpuWiab3R
	upHNA6adwhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A32AA9754;
	Wed, 19 Sep 2012 19:27:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B6759753; Wed, 19 Sep 2012
 19:27:06 -0400 (EDT)
In-Reply-To: <CAD0k6qTMm7MKLYOOMaB72cWc=Z8nJfe8qseWfyM6x_NzCorgZg@mail.gmail.com> (Dave
 Borowitz's message of "Wed, 19 Sep 2012 13:49:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 865C4702-02B1-11E2-97D7-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206010>

Dave Borowitz <dborowitz@google.com> writes:

> On Wed, Sep 19, 2012 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> dborowitz@google.com writes:
>>
>>> From: Dave Borowitz <dborowitz@google.com>
>>>
>>> Signed-off-by: Dave Borowitz <dborowitz@google.com>
>>> ---
>>
>> Thanks; the patch sort-of makes sense but makes me wonder what your
>> use case is.  Do you have xmlto2 program you want to use in place of
>> xmlto or you have xmlto but not on your $PATH?
>
> The latter; I can easily symlink it into my $PATH of course. But since
> I was already specifying ASCIIDOC on the make command line for the
> same reason, I was surprised to find I couldn't also specify XMLTO,
> hence the patch.

OK.  Was just curious.
