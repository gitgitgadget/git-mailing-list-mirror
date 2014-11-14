From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --trust-exit-code not working
Date: Fri, 14 Nov 2014 12:41:16 -0800
Message-ID: <xmqq389l347n.fsf@gitster.dls.corp.google.com>
References: <20141114161235.GA30086@vimeitor>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Adria Farres <14farresa@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:41:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpNgJ-0005lD-Ux
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 21:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161884AbaKNUlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 15:41:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754377AbaKNUlT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 15:41:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 314E81E783;
	Fri, 14 Nov 2014 15:41:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f5jQ0iuPliHLDWpzUhyyS5A/+WU=; b=jAP7O9
	S/asvvMxu6ZoXoXJpIb3hN5xYSNTLcuc+88WYMQv98BZdZdsMFEnSaI8NdSJ1jRk
	d3Yo0F7RPqpKUcK6IKxc9Lpa/cOL5Ex9kcuijqmNKiwFfNNxUWEeedRjgDHCwE43
	jQMUwP1pYbiSIGHY8UZYa4er9ToF9kahmNr2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yxdb48JFgBDhaAYggEpFyett10ITtyJY
	ACOiLRyZlVjlwwlBRo73oGYKor40sW+LxNwy8ZRcJZv/N0XXMR82dXYbGl6HY2Ek
	djuvQjCJ1GHuigQAUyA+Dxbxvxa/egkNWQR+EHmnwvAuepHlPg1XqfLhZ0J1Xihw
	ofCtWbjE2CE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 265941E782;
	Fri, 14 Nov 2014 15:41:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99FA71E781;
	Fri, 14 Nov 2014 15:41:17 -0500 (EST)
In-Reply-To: <20141114161235.GA30086@vimeitor> (Adria Farres's message of
	"Fri, 14 Nov 2014 17:12:35 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 954AD302-6C3E-11E4-B4FD-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David, I think this is about your 2b52123f (difftool: add support
for --trust-exit-code, 2014-10-26).  If you have time can you help
Adria?

Thanks.


Adria Farres <14farresa@gmail.com> writes:

> Hello!,
>
> I sent an email last week, but I'm not sure if I sent it incorrectly, or the
> formatting was very bad, or it went unnoticed. A few days ago a great soul was
> kind enough to create the --trust-exit-code option that made git respect the
> exit code of the difftool. Unfortunately, I haven't been able to make it work.
> Exiting vimdiff with :cq doesn't seem to make git quit, as it keeps pushing new
> files to be diffed. I tried meld and the exact same thing. I'm confident that
> exiting with :cq gives an error, as I have checked it, and I'm using git
> 2.2.0.rc1.
>
> Am I missing something important? Has anyone managed to make it work with
> vimdiff and meld? Sorry for bringing that up so late and for being a
> disturbance.
>
> Thank you,
>
> Adria
