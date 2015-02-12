From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git GSoC 2015
Date: Thu, 12 Feb 2015 11:53:20 -0800
Message-ID: <xmqq7fvmsy8f.fsf@gitster.dls.corp.google.com>
References: <20150212093435.GA20118@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 20:53:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLzpH-0007Nz-Vg
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 20:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbbBLTxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 14:53:23 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56277 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751492AbbBLTxX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 14:53:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44D1E37833;
	Thu, 12 Feb 2015 14:53:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kIcjyx1JeYasOv2vOGa8GV9ZZkQ=; b=nMNBlG
	ou8/wRalL82jMxm1PAQREHjJVg2TMfSmXKn7Qzv54HjW17+ssnH+y/CZCwjsk7c7
	md1SWF88b717I2pVLQM26lL+lAyhqFcO5iXUxbF1AVRmKhJzdb0oLJL7FEEX8vqV
	kb/344YBcyogz/f+MuL3rcsjCvTRo6PltxS5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cykdt5IJlK5sMjqo4AkeKMdpLZZSGCxB
	/p7rV8Y/hv80H8Sk0c0CqkbHE6uoxXRNcHA8qLRNeBPvvU1EEckvTpq6tnOQqRJN
	u2UPkPVIPbRx7YGzTRCFJFBT+UPM1lPHdgHDee6VSkSPf8tEjbTCJs+OL85uQXd8
	TLIUBdtBUa4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B00537832;
	Thu, 12 Feb 2015 14:53:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3FFA37830;
	Thu, 12 Feb 2015 14:53:21 -0500 (EST)
In-Reply-To: <20150212093435.GA20118@peff.net> (Jeff King's message of "Thu,
	12 Feb 2015 04:34:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CC4D47CE-B2F0-11E4-A7CA-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263757>

Jeff King <peff@peff.net> writes:

> The beginnings of the Google Summer of Code deadlines are upon us again.
> Organization applications are due February 20th (next Friday).
>
>  - Any thoughts on procedures or lessons learned from last year?
>
>    Personally, I really liked the "micro-project" system from last year.
>    It made it easy to drop spammy candidates (because they didn't bother
>    to do a micro-project at all), and it gave us some interaction with
>    the candidates before we had to make a decision.

Yes, I agree that the micro-project system was the best part of last
year's GSoC process.  In addition to the benefits you listed above,
it allowed students to be exposed the development style here, and
engage with the community very early in the program.
