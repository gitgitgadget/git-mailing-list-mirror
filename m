From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git on Mac OS X 10.4.10
Date: Thu, 14 Aug 2014 16:18:59 -0700
Message-ID: <xmqqppg21wyk.fsf@gitster.dls.corp.google.com>
References: <53ECA7DB.7060407@jump-ing.de> <53ECCA14.40900@web.de>
	<53ED0257.3070505@jump-ing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Hitter <mah@jump-ing.de>
X-From: git-owner@vger.kernel.org Fri Aug 15 01:19:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XI4Id-0004TX-Rs
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 01:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbaHNXTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2014 19:19:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61054 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbaHNXTL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 19:19:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6873631614;
	Thu, 14 Aug 2014 19:19:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dp0ZMugPTrLdc8pVxNK5EyBKk8A=; b=dc3yFW
	BY3Jt7vEEFx0tPz20FljPQ9Llsw07ZshEoFxeSzxbaOPl7Cp/Ui+Pf6Qbc8TUlYt
	CT2YOYBD2kP1WYGSmE/N+vrbJYaJ/Fs9cYP74IDg/iGNkSTSf5zvXBtbx7jOfFqc
	26GKGLHTAV5OxpX/XoRHCEpInvksauqa+P6M8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kF2opixqkNlotZ55VFca03o7b65ynnx0
	VlRLhUpOj88KIu8IyEU60HZI8hLhqRi/xcGoaBWWAArcBTHrkctnErxRdajpc/wy
	RkWzuo9uSiANDcTYSi/JoZilR1O9zopjqntEcIkPN5JbA/5Gkexo3nHt5qgvaPIZ
	Hbphv4dgD0I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D26BB31612;
	Thu, 14 Aug 2014 19:19:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C6F6231603;
	Thu, 14 Aug 2014 19:19:00 -0400 (EDT)
In-Reply-To: <53ED0257.3070505@jump-ing.de> (Markus Hitter's message of "Thu,
	14 Aug 2014 20:39:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5FC922E2-2409-11E4-A0FA-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255278>

Markus Hitter <mah@jump-ing.de> writes:

>> The  <CommonCrypto/CommonHMAC.h> is in Mac OS X 10.6 .. 10.9,
>> but not in 10.4 (I don't know about 10.5).

Is this about platform dependency, or what the end user happens to
choose to install (in other words, is there an add-on users of 10.4
can choose to add, which allows them to use that header)?
