From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/2] git-p4: kill watchdog and suppress irrelevant output
Date: Mon, 21 Dec 2015 12:31:37 -0800
Message-ID: <xmqqh9jbfsra.fsf@gitster.mtv.corp.google.com>
References: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 21 21:31:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB77Q-0003CS-Pa
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 21:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbbLUUbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 15:31:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751233AbbLUUbk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 15:31:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8302A32E74;
	Mon, 21 Dec 2015 15:31:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sJpXKQh0LhnosBfe4lMZts+INCQ=; b=JFmkwv
	llCtNrscynn0SrluUx2aFzytFWMU2febye5xnsSp+0h9uq39Qh1D32fdVUbp1apH
	3mmMou9uRqmOkplYVUwjpZKR9evEJ4U+e8FyToK52rbzwT+FETvbe6uWPhS4NVRV
	+zKd2Y5um4PkK4aTf2wIYwRvzGtMgWLRlnIqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a3tGbEiQ0EV6FHFQZsCmnq8OzWvdy1oy
	DnOZ0G8Tjp1rSkbk/qHjW4bYZVJ6b1dQjcZ756z0OU11fjZ4+ToSRD8bTF4KrfOA
	x0iazASYMl2E3oIvQRqbD5Ojcm94pzmnKXjDEdYHM65/v7zQdHfvVI8X4KlZhdJK
	7ry+JaYZpuQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B42932E73;
	Mon, 21 Dec 2015 15:31:39 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DF85832E72;
	Mon, 21 Dec 2015 15:31:38 -0500 (EST)
In-Reply-To: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Sun, 20 Dec 2015 17:44:27
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D669894E-A821-11E5-A58E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282815>

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Hi,
>
> these patches extend "git-p4: add trap to kill p4d on test exit" (dfe90e8)
> and therefore should be applied on master.

Wait, wait.  Please be a bit more careful when you use such a
phrasing.  Did somebody review these and said that these are
trivially correct improvements?

This depends on what you exactly meant "extend" and "improve" (for
the other one); if the "improvement" were to make something that
used to be unusable to usable, then the more sensible way forward
during the -rc stabilization period might be to revert the earlier
merges to 'master' that brought in undercooked topic.

Thanks.

>
> Thanks,
> Lars
>
> Lars Schneider (2):
>   git-p4: kill p4d watchdog on cleanup
>   git-p4: suppress non test relevant output
>
>  t/lib-git-p4.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> --
> 2.5.1
