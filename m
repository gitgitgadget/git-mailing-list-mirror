From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git.txt: document GIT_TRACE_PACKET
Date: Sun, 09 Jun 2013 16:16:38 -0700
Message-ID: <7v61xmoox5.fsf@alter.siamese.dyndns.org>
References: <20130609053621.GA1854@sigill.intra.peff.net>
	<1370757210-2994-1-git-send-email-pclouds@gmail.com>
	<20130609055509.GA17617@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 10 01:16:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uloqr-0001Hk-Dl
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 01:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab3FIXQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 19:16:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34834 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371Ab3FIXQk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 19:16:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AAA526A7B;
	Sun,  9 Jun 2013 23:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o0kLnI6X0YgTfvI4prmDtRHNRNg=; b=ZDIL2E
	kkIrW3Ve+c1VWxGSoygW1xIuh4RErCh/7qjTm/MOyc2fx9oK46iZQDHJLbNy3a7v
	p+USQ8Y0zQLp+e+o7zFGVNI1grrkJmgZAcAwkm9XqCZZN/8LVt2ZEW6wFXP9g7EI
	7cU0DPAb+zWxxC3YF4N4HXxDxmr5al/NFa39g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Vcq23FoDuRSSc/G+6yx8FOI5au026Sc9
	S1l8U/RpMm6bEJ6/w3q/milkYFysG5odSxJPWQSuZFX83ePOhY0HomnbtkpcVnd6
	ucLRyzSgTnEj1jTNnC73bgMSwDvotRrI1r3ZnpMLZd7wnXMT2jhcrhMUO0wCGQpe
	ZPbSM5WZ9Q4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41EE926A78;
	Sun,  9 Jun 2013 23:16:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B927B26A77;
	Sun,  9 Jun 2013 23:16:39 +0000 (UTC)
In-Reply-To: <20130609055509.GA17617@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 9 Jun 2013 01:55:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A3AA8DFA-D15A-11E2-9713-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227207>

Thanks, both.  Will queue both after re-reading 1/2.
