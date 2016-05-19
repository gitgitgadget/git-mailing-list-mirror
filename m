From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 00/20] index-helper/watchman
Date: Thu, 19 May 2016 13:11:03 -0700
Message-ID: <xmqq1t4xizag.fsf@gitster.mtv.corp.google.com>
References: <1463084415-19826-1-git-send-email-dturner@twopensource.com>
	<1463684925.24478.81.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 19 22:11:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3UI4-0004v0-D5
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 22:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbcESULK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 16:11:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753942AbcESULH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 16:11:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76F161D96E;
	Thu, 19 May 2016 16:11:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ACzXvZyup0cIu8OnISx9Wsoh3mk=; b=mygH8S
	7NkzKDe4vdDfqY1CzTV6sUv/IQVxvKSw/cJ6BaGqwAp8m4hjQuz9lr2M5jeh63wL
	lcY3mpoN7Ef7e2uNajLZJ/o3xMCYYpak9TtQ8NkQWkH0rdca8rU+8/BeIIdtnCME
	Ob9GZ/4WRZHZt++w0CIzPPv0/JpODE+AJossY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TgC/UkTpqHeMdatIc8UQz87C00EPAVrq
	WURuoi/HsFtAwFG8Ac2+uvZqcVN9f6gywSYbieS2SrfyHp5TOzBGAWVhKiwEp5WV
	SRK2Sfb8B/LUmTeHi2WdYwuE/4fRp2Cqo9AvyCRbUJP7RoxrYIazKqlOo4EHviJu
	4+2PNUTPB/w=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E4E11D96D;
	Thu, 19 May 2016 16:11:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D956E1D96C;
	Thu, 19 May 2016 16:11:05 -0400 (EDT)
In-Reply-To: <1463684925.24478.81.camel@twopensource.com> (David Turner's
	message of "Thu, 19 May 2016 15:08:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D16EBB2E-1DFD-11E6-BB91-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295097>

David Turner <dturner@twopensource.com> writes:

> Do folks have any more comments on this version?

Not from me at the moment.

> Do I need to re-roll
> to replace 11/20 as I proposed and drop 20/20?  

FYI, I think I have the one taken from

    Message-Id:
    <1463174182-20200-1-git-send-email-dturner@twopensource.com>

aka http://thread.gmane.org/gmane.comp.version-control.git/294470/focus=294585

queued at 11/20.
