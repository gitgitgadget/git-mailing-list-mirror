From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6006-*.sh: Fix truncation tests
Date: Tue, 20 May 2014 10:10:46 -0700
Message-ID: <xmqqr43o1ill.fsf@gitster.dls.corp.google.com>
References: <537B5E8C.3070803@ramsay1.demon.co.uk>
	<20140520141936.GA30187@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 19:11:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmnZ4-0005ID-5n
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 19:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbaETRKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 13:10:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59734 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbaETRKx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 13:10:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1FD017B29;
	Tue, 20 May 2014 13:10:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AiqLrjpWUYyjt3mMCI6/NYsW+1Y=; b=Ihw/xM
	djPUrVe5tksufIiGuqo2WpKR09dbCqbPtOiyslZXv+rp7llTNNz4m2NRnG+J7Gsm
	cavMqImbo6Ca8koZlE+5lKeOLP2544m3YDUAjPh/FuH4OG1XwA+0Ns+uN3wqsJQz
	Cljd7O7V2PM68XzYx17h26bCqVkx3oQQyEGZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vKiGmXx3bvuP5wa2Uja2nVdJUE/slsB1
	Z8l4LOz+ELcP6hc1BpLAJU+MHgQdTdszA8XFQlEQuEyZxwYBVCjshDAjQ7y98eJp
	W4Re4oxTw1eCUSas1Lc1m1Ch0AmcyXZLYnxrKXenNRTD/eaeFQ9Yj8npG4OaLs+G
	czJ/A5IfiAY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B629A17B28;
	Tue, 20 May 2014 13:10:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3966117B1F;
	Tue, 20 May 2014 13:10:48 -0400 (EDT)
In-Reply-To: <20140520141936.GA30187@ashu.dyn1.rarus.ru> (Alexey Shumkin's
	message of "Tue, 20 May 2014 18:19:36 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B00DF068-E041-11E3-97EA-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249705>

Alexey Shumkin <alex.crezoff@gmail.com> writes:

> AFAIU, Junio already applied my patches (existance of a branch
> as/pretty-truncate tells us that). So, we can only send other patches that
> fix errors brought with former patches.

No, NO, NOOOOO....

The existence of a branch merely means that I saw the patches, and
that I thought that the series was not completely useless.  In other
words, it indicates that I wanted to make sure that I won't forget
about the topic, and it was worth my time to create the branch and
apply there for that purpose.

Please do not read anything more than that.  Presense of a topic
branch by itself does not say that I _read_ the patches or I thought
they did not need reroll.

When such a branch is merged to 'next', that means I read the
patches myself, or I saw somebody whose judgement I and others in
the community trust read them and gave a positive response or an
Ack, and that I decided that the topic is in a good enough shape to
be worked on further with incremental updates.

You are talking about the latter state, but as/pretty-truncate is in
the former state.
