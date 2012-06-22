From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: start warning upcoming default change for
 push.default
Date: Fri, 22 Jun 2012 10:48:22 -0700
Message-ID: <7v7guzqluh.fsf@alter.siamese.dyndns.org>
References: <7vbokeyie3.fsf@alter.siamese.dyndns.org>
 <1340195750-846-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vehp9x3yz.fsf@alter.siamese.dyndns.org> <vpqpq8t96zw.fsf@bauges.imag.fr>
 <7va9zxvkyp.fsf@alter.siamese.dyndns.org>
 <7v62alvk2e.fsf@alter.siamese.dyndns.org> <vpqd34su0io.fsf@bauges.imag.fr>
 <7vobocsipo.fsf@alter.siamese.dyndns.org> <vpq62aksicy.fsf@bauges.imag.fr>
 <7vk3z0shri.fsf@alter.siamese.dyndns.org> <vpqlijfrd73.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 22 19:48:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si7yW-0003hX-13
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 19:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762632Ab2FVRse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 13:48:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41593 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762628Ab2FVRsY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 13:48:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A62A7602;
	Fri, 22 Jun 2012 13:48:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pYhsjdC7JMejshrHPCP92upnf2c=; b=vY/eKj
	xUWX32naZx9h1AzSPT+Oky3+1+quuE94AbcDiOjiRCFWwLsPraV5ABhAMYeKVR1D
	cySv16H2EPoqIs+62S6m2vhZ0OuNcZola6qEVX9790c6wcduOJEP8dGBAcF9zZ2S
	PsPmCUdRueEGAUZzzlJnHakg9Y+8nQDL8x3dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L1MviB5QuCzK6BzSWHJY3lc3Gx4PVUn1
	9xq+WDZzkGuWo/WfYXny6nI3uCbAq80T+XCnT3pDNpIK2E1QCggcQ4z4cuY0/7Go
	CYt7IUxSHljAybFT20qge+VwoOm88Tuvvu6GlY36ko+FB9QmDP+y3TdVoN0uogvn
	7FsLeDlP6r4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 517A17601;
	Fri, 22 Jun 2012 13:48:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEC9C75FE; Fri, 22 Jun 2012
 13:48:23 -0400 (EDT)
In-Reply-To: <vpqlijfrd73.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 22 Jun 2012 09:57:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7681A738-BC92-11E1-89AA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200449>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I do agree with that. My message tells the user to use 'current' instead
> of 'simple' when not appropriate, not to use 'current' instead of
> 'matching', which would indeed be a nonsense. I thought it was clear
> enough, but we can make that more explicit. How about:
>
>   (the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
>   'current' instead of 'simple' if you sometimes use older versions of Git)

Yeah, that would work (the minority that need to pick 'current'
cannot cut and paste, but that is not a big deal).

As I did not butcher the version you sent me when I queued it with
my rewrite, a follow-up patch to update it should be fairly minimal
;-)

Thanks.
