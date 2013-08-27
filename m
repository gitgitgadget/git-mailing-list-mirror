From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/11] Use "git merge" instead of "git pull ."
Date: Tue, 27 Aug 2013 12:06:33 -0700
Message-ID: <xmqqob8jc5s6.fsf@gitster.dls.corp.google.com>
References: <1403569571.34349.1377625974290.JavaMail.ngmail@webmail19.arcor-online.net>
	<1685937666.34465.1377626298173.JavaMail.ngmail@webmail19.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, martinvonz@gmail.com, jrnieder@gmail.com,
	wking@tremily.us, philipoakley@iee.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 21:06:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEObB-0007uQ-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 21:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab3H0TGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 15:06:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103Ab3H0TGh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 15:06:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A283A3C987;
	Tue, 27 Aug 2013 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DM4vbaeSC0u8ul+VVMa8DdnqYag=; b=oJ25XD
	sL+LxuV85wEEbnoMN8KUtk0aPy36NgglYgXRwL7GNxuoxtz9IZvwkhvfXYeDubEE
	wIDrAlc/RUPAc3Ug+kvQL1ux8/6LIjXJkrlBveUVLePFzg3L8k7kXrXHAMWxWq42
	ShVFAq84Lfn53mZPrTTsklVcjV0+1ZpVJOMhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nn97Y94clS6UnqxlvQJ73G/N7x9HjU+m
	UeOyr31F3dTuqd2jitT7bdphnOmfYargb75Joc1tObGa7S33evkLSSBDCzNWVw6V
	jh7QaehEKSanf468sI0nlcU7+Jo/M2vGTrbvzDQZMqsmhQLrd/11VUCyFd2oihSK
	GtyoUuNRJyY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94D0B3C985;
	Tue, 27 Aug 2013 19:06:36 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05CF13C984;
	Tue, 27 Aug 2013 19:06:35 +0000 (UTC)
In-Reply-To: <1685937666.34465.1377626298173.JavaMail.ngmail@webmail19.arcor-online.net>
	(Thomas Ackermann's message of "Tue, 27 Aug 2013 19:58:18 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CAD63472-0F4B-11E3-A443-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233136>

Thomas Ackermann <th.acker@arcor.de> writes:

> "git pull ." works, but "git merge" is the recommended
> way for new users to do things. (The old description
> also should have read "The former is actually *not* very
> commonly used".)

It does not matter that you are unaware other people use it often.
I'd suggest dropping the first hunk altogether.
