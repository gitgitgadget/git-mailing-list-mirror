From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wincred: fix get credential if username has @
Date: Sun, 25 Jan 2015 20:25:53 -0800
Message-ID: <xmqqy4oqmalq.fsf@gitster.dls.corp.google.com>
References: <1415832746-5116-1-git-send-email-margtu-fivt@ya.ru>
	<1416433652-6840-1-git-send-email-margtu-fivt@ya.ru>
	<xmqq1toyreyh.fsf@gitster.dls.corp.google.com>
	<CABPQNSaNHU=eJtK=s4P=p0hesEB0fxnwRo1zx5sMDo7zXgYM_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Aleksey Vasenev <margtu-fivt@ya.ru>,
	GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Karsten Blees <blees@dcon.de>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 05:26:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFbFQ-0007l1-8Z
	for gcvg-git-2@plane.gmane.org; Mon, 26 Jan 2015 05:26:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbbAZEZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2015 23:25:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751810AbbAZEZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2015 23:25:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A53733B19;
	Sun, 25 Jan 2015 23:25:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U3x5wvQgNWqJIKT1+w4BjBe7JfY=; b=LlFopl
	gPehZ4yHK8oAFn+YiUFoGs0dEdM7pbgbt6Iby9/62QsCADI6IOjnSCD/P1zP+XMP
	Rl84HVdyVCIcHuoBVAOTvNtK7tv8QlWbraXOc6mM3CCAwWnIqJ2O/OsS7FLV5QZL
	N0BT2jjFzB0DiQlyaYqiMUha1W4qsxAZY4h7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W1CDas4ITcLuthgaLilt/A0yLZYILZLA
	P039uEZYbS8YVDYI82Rl44434S2t+ANDYj5RCSG9pSy4akY5unafMju3YAByhdlP
	M6k8PtEdhsMlg2Cq5NGfopZRrGJo9dj5carp0F/LLL5hdQ3GN36MgmmQxH0oOkMj
	TUg7Wm/7Coc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4150533B17;
	Sun, 25 Jan 2015 23:25:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4DDB33B16;
	Sun, 25 Jan 2015 23:25:54 -0500 (EST)
In-Reply-To: <CABPQNSaNHU=eJtK=s4P=p0hesEB0fxnwRo1zx5sMDo7zXgYM_A@mail.gmail.com>
	(Erik Faye-Lund's message of "Sun, 25 Jan 2015 22:12:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6B165404-A513-11E4-AC0B-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263025>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Sorry for the extremely delayed reply, I had a bug in my mail-filters.
> Hopefully fixed now.
>
> ...
>
> I noticed the breakage myself around the same time, and posted about it here:
>
> https://groups.google.com/d/msg/msysgit/YVuCqmwwRyY/HULHj5OoE88J
>
> Unfortunately, it stopped there.
> ...
>
> Looks reasonable enough to me.
>
> Acked-by: Erik Faye-Lund <kusmabite@gmail.com>

OK.  Will apply to my tree, so future Git for Windows would
hopefully have it as part of its upstream updates.

Thanks.
