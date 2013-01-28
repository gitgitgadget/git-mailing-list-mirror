From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [feature request] git add completion should exclude staged
 content
Date: Mon, 28 Jan 2013 09:52:54 -0800
Message-ID: <7vd2wpxki1.fsf@alter.siamese.dyndns.org>
References: <20130126172137.GB5852@mobster.11n_AP_Router>
 <7vip6iteod.fsf@alter.siamese.dyndns.org> <5106444F.2040007@gmail.com>
 <51067487.9050505@drmicha.warpmail.net> <510684FB.80104@gmail.com>
 <5106A5CE.3000800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Manlio Perillo <manlio.perillo@gmail.com>,
	wookietreiber <kizkizzbangbang@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 18:53:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzstS-0004Os-OH
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 18:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757600Ab3A1Rw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 12:52:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62934 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757360Ab3A1Rw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 12:52:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22228C58A;
	Mon, 28 Jan 2013 12:52:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BAwrzEK3mqX7uk1IE22hSEtCDPw=; b=ZMGFgk
	pQEfSzoc6hgMJ+buaYWSB7SQisE1CZXFIgt0WJtuYst2yfScDOIraGhfpyEyehTr
	NfHWkST846SrjJqkoN2F1n2lWFxhLROOnk4mHTvnIzpFhfVwTfeiCj+IgLrf0Y94
	xvwKMiieVg8VpN1rn0yh+i/8MlfOpiHmOK/qI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l+hEhUgb/KX6ySvNEFwyC9gmaGXmwuXc
	eGSQYp5MZHkkNkm2gm2xnV397WRqFyLxOsvH1dZqltD9T+Y8OzF12iyY9vjEDYlb
	RNJpjWItuZCKksyiBpTpBcV9bOOfKrZc5RcZHEQIB1DbEOTTOQFUhyQLA+Cugab9
	KMjwLo35/Ms=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C6EC589;
	Mon, 28 Jan 2013 12:52:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80BF6C586; Mon, 28 Jan 2013
 12:52:55 -0500 (EST)
In-Reply-To: <5106A5CE.3000800@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon, 28 Jan 2013 17:22:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B651480-6973-11E2-AB4B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214842>

Michael J Gruber <git@drmicha.warpmail.net> writes:
> Manlio Perillo venit, vidit, dixit 28.01.2013 15:02:
>> Please, test it and report any behaviour you think is incorrect.
>
> OK, that seems to work and to be quite helpful.
>
> Minor nit: "git add -u" could use the same fileset as "git commit". But
> I don't know whether completion can act upon the presence of options.
> Currently, it also includes untracked files (just like without -u) but
> omits unmodified and ignored ones, which is already quite an improvement.
>
> I won't be able to review the completion code but may contribute a few
> lines to t/t9902-completion.sh, possibly.

Thanks both for commenting.  I'll find time to read it over again
and perhaps we can merge it to 'next' and advertise it in the next
issue of "What's cooking" report to ask for wider testing to move it
forward.
