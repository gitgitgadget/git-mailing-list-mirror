From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-log: added --none-match option
Date: Fri, 09 Jan 2015 14:55:20 -0800
Message-ID: <xmqqk30vbm3r.fsf@gitster.dls.corp.google.com>
References: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com>
	<1420349268-13479-1-git-send-email-ottxor@gentoo.org>
	<xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
	<CANgp9kxXzt7x9JnnxjrcRLse4m86eDAgWyC4FwKw2U48NjV=ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christoph Junghans <ottxor@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Jan 09 23:55:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9iSq-0001zv-Bp
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 23:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758290AbbAIWzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 17:55:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758277AbbAIWzY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 17:55:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 409DF2D8CE;
	Fri,  9 Jan 2015 17:55:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qAN83HfCMVnOZLd7MQoIuuoUDu4=; b=RQwR36
	5Ef2odFArDvWCRtESgZcIEm7TaMwalsMxWihtLEHrrxTNlN2JXdDRBQ8D19c8jft
	YNxOeDJ0WLTdKHSPt+hXsFJy4gU1IgKI8W1y7QBDpzMMn5vcq5682bhhmlio53V4
	MHB6V01k905fB9OcympTJ7k6tgm5Luoyj12lo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SYZ5udPVXcDlMWQ2J3yqaQqz2KGQi7XU
	GQ9Zgjh2Ri9BUGzFmVdTEJyjWuXll0rWfpVX96jIyGz+pqbDwR7lZGUEpTvZIlOm
	k79Q2LPawHPlvJjjpOkbMtMCc/6sBKQQTdSXWPcLB0uSaM2Da3kDPvZagtteDDx4
	RgIEAWuOxwg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 358572D8CD;
	Fri,  9 Jan 2015 17:55:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BACBF2D8C7;
	Fri,  9 Jan 2015 17:55:21 -0500 (EST)
In-Reply-To: <CANgp9kxXzt7x9JnnxjrcRLse4m86eDAgWyC4FwKw2U48NjV=ew@mail.gmail.com>
	(Christoph Junghans's message of "Fri, 9 Jan 2015 15:33:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9719AA92-9852-11E4-8BA3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262249>

Christoph Junghans <ottxor@gentoo.org> writes:

> The only useful thing I could image is using it in conjunction with
> --files-with-matches, but that is what --files-without-match is for.

Yes, "-l" was exactly what I had in mind and I was hoping that "git
grep -l --no-match -e WIP -e TODO -e FIXME -e NEEDSWORK" may be a
way to find perfect files without needing any work.

You can say "git grep -L -e WIP -e TODO -e FIXME -e NEEDSWORK"
instead.  I missed that "-L" option.

Thanks.
