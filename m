From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 12:53:43 -0700
Message-ID: <xmqqlhumegqg.fsf@gitster.dls.corp.google.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
	<536106EA.5090204@xiplink.com>
	<536129068cc28_1404fdd310fd@nysa.notmuch>
	<vpqha5akamh.fsf@anie.imag.fr>
	<5361416a172fe_f9b15012ec7e@nysa.notmuch>
	<xmqq38gufxbm.fsf@gitster.dls.corp.google.com>
	<53614fb5e204_2aa5fa32f0df@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:53:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfaZl-0001Rp-Ff
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 21:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759299AbaD3Txt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 15:53:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38407 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759042AbaD3Txr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 15:53:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D31F7FBFC;
	Wed, 30 Apr 2014 15:53:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Gwcy4wN5G2xpTQvjU0vAbd1/tU=; b=QmFlIt
	3SLv03dXrDRzzhVrRyawliS/jiohoKUCUrgtMDopCqk2eA+MjXWNWTKUbgNOmtJq
	h30/3EIf/hAfHd1w5fopiM+4YJTW3slwFnQb4k4i7SSMHoRKkYImnD0HOlnqe7Rl
	UEbqaqhbuIO2nb5SG3A6G3/bhLtWG+hqltb8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cKOtXUsUtaurhMbGym8MfsjGoUBRmP4A
	eaTojjeRKCoZe1gnqt7JZnX4XohwPYaeoiHJN9irhE3BU3XCbBYCXJ/hx+pDiXbJ
	6bigMh87aKuPh7BngOnOS/DM/JA8jU1RQ4hVReVMyeM+GNZUlZ/zjYpwhz3zsSvf
	PRY2Emf40Kw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F6127FBFB;
	Wed, 30 Apr 2014 15:53:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA1FB7FBF7;
	Wed, 30 Apr 2014 15:53:44 -0400 (EDT)
In-Reply-To: <53614fb5e204_2aa5fa32f0df@nysa.notmuch> (Felipe Contreras's
	message of "Wed, 30 Apr 2014 14:32:05 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 232BCF94-D0A1-11E3-859C-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247767>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> > Matthieu Moy wrote:
>> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> ...
>> >> > Yes, this has been discussed many times in the past, and everyone agrees
>> >> > the default behavior is not correct.
>> >> 
>> >> You definitely have a strange notion of "everyone".
>
>> While I do not quite see the previous discussion as deciding the
>> particular implementation is good without further tweaks, I would
>> say that everybody agrees that the default behaviour is not good for
>> everybody and therefore should (or for Linus, "it is OK to") change.
> ...
> I said 'everyone agrees the default behavior is not correct', which is
> true.

Isn't that what I said a few lines above?  Why are you still
arguing?
