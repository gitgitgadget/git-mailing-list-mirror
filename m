From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] push: heed user.signingkey for signed pushes
Date: Fri, 24 Oct 2014 09:49:34 -0700
Message-ID: <xmqqfvedh0pt.fsf@gitster.dls.corp.google.com>
References: <787502533676138ad113e446eba71d92dee3b4de.1413989046.git.git@drmicha.warpmail.net>
	<7b3546cd125d1ad92dd62297ecbe624a78c6079b.1413989799.git.git@drmicha.warpmail.net>
	<xmqq7fzru5do.fsf@gitster.dls.corp.google.com>
	<544A6A4C.4070704@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 18:49:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xhi3Y-00011q-My
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 18:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbaJXQth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 12:49:37 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756015AbaJXQtg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 12:49:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F7F814035;
	Fri, 24 Oct 2014 12:49:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WJBbUc4boRzFidVPpyMKDS6vScg=; b=fy7KOO
	2+D2Mg8sVVm0Yzxj30axJkJpHCLNvn3q/uxpMMaG5Oqg53mnrOnhsSZ7kTx/hWAS
	guB1GZVy24Hs7/MjWMVR45U/lkGyeSn600NZbXrkjxydsZlglDvVken2vW2zdSZY
	b0c2Rhj+lUfU2tSAeIXAS200rYI9uXzmkqUQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OCkHyq369VtYRnGaQhK6uuBj1w3gLOaV
	gov3yw5CqlRXpOTKykSUExsVeaGJ0LLaXRwxRzBS5y+D/o4uwrLpF1cwffVqQnCS
	FEVGTQeOo137Wg3Ckb8S5p+n/tC+d79uuuD8OJWzDf63+yiVmwlrLXJTLDz1Knua
	veP83BXCdWk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 16C4C14034;
	Fri, 24 Oct 2014 12:49:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 655DC14031;
	Fri, 24 Oct 2014 12:49:35 -0400 (EDT)
In-Reply-To: <544A6A4C.4070704@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Fri, 24 Oct 2014 17:03:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BC3FC3F2-5B9D-11E4-9C93-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Ooops, I'm sorry. That must have sneaked in from running gpg with that
> home to see which keys we have in the test env. No change in trustdb
> intended. Probably gpg did some automatic trustdb recalculations, even
> though all I did was gpg --list-key.

OK, so it will be fine to queue the patch without the trustdb bits,
I guess.

Thanks.
