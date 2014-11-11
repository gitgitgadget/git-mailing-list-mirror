From: Junio C Hamano <gitster@pobox.com>
Subject: Re: mac test failure -- test 3301
Date: Tue, 11 Nov 2014 07:58:51 -0800
Message-ID: <xmqqmw7x7mpw.fsf@gitster.dls.corp.google.com>
References: <CAO2U3QhiWVvVKivBhE5R2xhjf8SPPtg6VSaQMxw7vbm_454jBQ@mail.gmail.com>
	<CAPig+cRxCj82F5aak0Y+Ce_SvUETtQ5dwM1RtzjUUvwtJ=WPYw@mail.gmail.com>
	<CALKQrgexnrCy-P6yTZB+U0--5peaTys9KqB+KGKqbAuyLA=NqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Nov 11 16:59:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoDqM-0001cC-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 16:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbaKKP6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 10:58:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751218AbaKKP6x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 10:58:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 24D571B430;
	Tue, 11 Nov 2014 10:58:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tY3KqWAVjAVdYYpefQ7f7Ofqv88=; b=ezy5Qb
	0k2aLckRbSLmaVNfA//tkCj47W3GMbk6wdAnv9z0fF+7LEh/wNJT/GyJi6MHMEqu
	GY7LsHTP7iIatyfKnjwi0vjqUjAbTycRYiCEbsq4CHTh7zUVq0ANIoFls3Xgc0Lk
	XbOCPpeoSGWANJCONQEGazQgrAU1XIy+QVOVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BcjM1NRz7M621fRTIkGnC3TIy1ZG6wi+
	sZcbpqmE/KrDtDUT1S4fQTE2nZKhMN24qTzSXZSSfc5R1WsVzzGQMgpOE7DmhX6f
	xahz3kbVrTqHZly0QAgFzRB8peggWeERPh/y1F1xhaTh3TFDD30XffWfR6ZV/gol
	KKdh5SPV00Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19FD01B42E;
	Tue, 11 Nov 2014 10:58:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 920821B42C;
	Tue, 11 Nov 2014 10:58:52 -0500 (EST)
In-Reply-To: <CALKQrgexnrCy-P6yTZB+U0--5peaTys9KqB+KGKqbAuyLA=NqA@mail.gmail.com>
	(Johan Herland's message of "Tue, 11 Nov 2014 02:40:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A2063BF2-69BB-11E4-8D2D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> Ah, thanks!
>
> I thought that quoting command output was a good idea in general. Am I
> wrong, or is this just one exception to an otherwise good guideline?

It is not a good practice to blindly follow any guideline ;-).

When you anticipate that different platforms throw you unnecessary
spaces around a single token you expect to see, not quoting is
obviously the right thing.  If you are unsure if the comamand gives
you one or multiple tokens, you obviously risk the output getting
split by not quoting.
