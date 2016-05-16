From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] difftool: handle unmerged files in dir-diff mode
Date: Mon, 16 May 2016 14:53:45 -0700
Message-ID: <xmqqd1ol1xg6.fsf@gitster.mtv.corp.google.com>
References: <20160516180537.22212-1-davvid@gmail.com>
	<20160516180537.22212-2-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>, Jan Smets <jan@smets.cx>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 23:54:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2QSd-0004PO-Oj
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbcEPVxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:53:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62352 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816AbcEPVxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:53:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 495381CED7;
	Mon, 16 May 2016 17:53:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=XjCT7f
	Y5UJrKOLHoYs3c79XLvPDaWyhFhR6DDRePfJXloajB/hg1K+a2PyKq3Rnoe96bwD
	CfdI5xeXAZhwMhpuS0jPtU/RPQhB9v1FBb8FLC3AhXytKShDpDiUbkh5WuP81UH+
	9b4jMAP3UfpxqJcmpVa+26HAMxb0hXNHa8rHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pSWarwrqMeLPuA4VVTrhYS8iXJG/TQUa
	vQ/M4ERBgfkvUHsMSrXBdFj3lWO7E2AXy/AqZ3S4qDxRyb3GeGsGzC4DQxtqZce7
	6TsuwrCp/KmyTcpTGoQ+yW9JLiLGjYacOakniV8V3siBGge2rKrDnP5uVwnyOXdg
	C/TnxwTXB0A=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4108C1CED6;
	Mon, 16 May 2016 17:53:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B66E31CED0;
	Mon, 16 May 2016 17:53:47 -0400 (EDT)
In-Reply-To: <20160516180537.22212-2-davvid@gmail.com> (David Aguilar's
	message of "Mon, 16 May 2016 11:05:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AAF2A7D4-1BB0-11E6-87A4-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294802>

Thanks, will queue.
