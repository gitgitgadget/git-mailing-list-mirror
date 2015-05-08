From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A note from the maintainer
Date: Fri, 08 May 2015 09:25:43 -0700
Message-ID: <xmqqfv77m3y0.fsf@gitster.dls.corp.google.com>
References: <xmqqzj5pxumj.fsf@gitster.dls.corp.google.com>
	<CAP8UFD15C5vU2uiKWZYKQR5MBsV_WKyGKekyCW4UAAsCBrnFxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 18:25:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yql5z-0003Z9-AW
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 18:25:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbbEHQZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 12:25:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932076AbbEHQZq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 12:25:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 960E94CDEE;
	Fri,  8 May 2015 12:25:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6NpXIbkb2GXgVnjgJbjGYgu5Rt4=; b=mCXRNS
	ZSjwQiwWdc5nYzWYa2wCfzFe0kW0Q/cI3itDyWJ7ar2vvicxqZ27TRq3uB2DIuRj
	a/XmqZfYMYUy97dobg7rsvj76JURRww/sjM9E7PzOKncBxsFBlORh4nET2XdCg5h
	LN+5ftZaOG8vUa9DkhCWqQrYIN/bx8JrFiNDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AA+MYBizB8RUTylhTOfzhC6zjG9Ri0xF
	jJhXuMs9CyadlSxHZ6ZQSu4nOUEYAsJV2LiD3SH3bWvrFPnxOmbMmo8OBvm3N8hI
	2LZDmHU52VXPcJUgXWv7QjpEfydoH4YU/fFyGHU/hYuKHiw/1oyTZU5UAgpzopT1
	7JMxGlrRO1U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89C094CDED;
	Fri,  8 May 2015 12:25:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D2784CDEC;
	Fri,  8 May 2015 12:25:44 -0400 (EDT)
In-Reply-To: <CAP8UFD15C5vU2uiKWZYKQR5MBsV_WKyGKekyCW4UAAsCBrnFxw@mail.gmail.com>
	(Christian Couder's message of "Fri, 8 May 2015 16:46:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E0A7F1E2-F59E-11E4-885B-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268623>

Christian Couder <christian.couder@gmail.com> writes:

> I am still wondering if it has been truncated on purpose or not.

The document is already too large and people come and go over time.
Maintaining that list becomes time sink, absorbing time better spent
on reviewing and polishing their patches rather than their names in
that list.  Rather than keeping a stale list forever, at some point
I decided to trim and start afresh, perhaps mentioning very notable
contribution from people there if there were any around the time the
message goes out to the list, which hasn't happened.

And with Git Rev News, I probably do not have to worry about it too
much, I hope ;-)
