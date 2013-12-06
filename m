From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git reports
Date: Fri, 06 Dec 2013 12:36:56 -0800
Message-ID: <xmqqwqjh1ztj.fsf@gitster.dls.corp.google.com>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
	<20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
	<20131206210958.59f553060e3802d56f4a53b8@domain007.com>
	<CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
	<20131206215334.1a9031a1450d9c436943ce3d@domain007.com>
	<CAMAQ3nLgnpDo1jWFL1rqtEvmQm8LeEpZ41Uxo0GTQOk8ttpSZA@mail.gmail.com>
	<20131206192651.GK29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Muzaffer Tolga Ozses <tolga@ozses.net>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 06 21:37:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp299-0002ql-7H
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 21:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758463Ab3LFUhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 15:37:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44210 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789Ab3LFUhC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 15:37:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D881856F6E;
	Fri,  6 Dec 2013 15:36:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sjXgSkpRSyczJuWVD6OGrDf1D/0=; b=taqEdM
	BhJ4T2lB7Mq/9MvaDo7Lfox9FZoW7ee6bzusvDH4eLX7J3/RLVAmvOtqOFKLPTxZ
	Oy5IHhS3eyYezkxupTbyJUwifyQ92bzJqLYgk7prKJSEcnKNCbUINSeTiAiexaQ3
	VGuxwhPE9IxmmzqV+8M4lBaT9CMoJ/vLNTukg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rkVbQArmZ8nXnM/d2NwgFh1QqtkO6Tnz
	xuxDkPoiZ7zB/bUmjqu1L4z7goJfdiaKQVoyxOvRsAPJ1Qun06Mn6kwJazY8ZMzC
	BPyKaKMI7KA+oCmr3OIePaKfzdOUQpxJT5EPidLhu/1/5ZdYVrUhBqtAQHawBchK
	EwFLzpEvqcg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C78AB56F6D;
	Fri,  6 Dec 2013 15:36:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E2D156F68;
	Fri,  6 Dec 2013 15:36:58 -0500 (EST)
In-Reply-To: <20131206192651.GK29959@google.com> (Jonathan Nieder's message of
	"Fri, 6 Dec 2013 11:26:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 26EC3E00-5EB6-11E3-AE64-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238948>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Muzaffer Tolga Ozses wrote:
>
>> I am cloning over http
>
> I am guessing you are using the "dumb" (plain static file transfer)
> HTTP protocol.  With that protocol the server doesn't do anything
> other than shuttle out files, so it doesn't need to do its own
> progress reporting.
>
> Perhaps the client should do some progress reporting based on file
> sizes and amount downloaded so far, but it's hard to get excited
> about given the existence of "smart" (transfer only what is needed)
> HTTP protocol.  See git-http-backend(1) for details.
>
> Perhaps we can document this better?  (If so, where would it have been
> useful to learn about this, and do you have ideas for how it could be
> worded?  I'm thinking it might make sense to put a note on this in a
> new giturls(7) page with content that used to be in the git-clone(1)
> 'GIT URLS' section.)  Or if someone wants to work on a progress
> display, that would be nice, too. ;-)

I wouldn't be worried too much about progress display, but I would
think it might be a good idea to teach the http client side, perhaps
with a -v option, to report which variant of the protocol is in use,
primarily to warn those who have a server that is capable of running
the smart protocol but forgot to set it up, or unaware that smart is
generally a better option for them.
