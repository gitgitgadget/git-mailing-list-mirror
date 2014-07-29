From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 0/2] git config cache & special querying api utilizing the cache
Date: Tue, 29 Jul 2014 14:37:59 -0700
Message-ID: <xmqqsilj26dk.fsf@gitster.dls.corp.google.com>
References: <1406542239-17024-1-git-send-email-tanayabh@gmail.com>
	<vpqegx5vivp.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 29 23:38:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCF65-0003pU-PK
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 23:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbaG2ViJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 17:38:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63705 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbaG2ViI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 17:38:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE96B2D860;
	Tue, 29 Jul 2014 17:38:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dL+pjhWFnUHkYNj8iGNRXJAMxiA=; b=wsRoXl
	IrjNPa5rY5fqnx9yx1Ty0osun+VeBq+EanvTrvcez0J4l2Ekeqa/uRZ6kai5CqQ3
	2jKTn+8/SPRUuzWaCJQ9Zm+Um8Q5HnljAQ/lXaeKlZW8WeIqvyl1wgn6CJML7byo
	vO5O937O4TguKIhMN9PzmoTYmTSw7tq9VunF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pq6w4CmHjd7GPB0qztSv1wi6BzdWB4/k
	Rt1iE7uCxZjVg87W4AmO+1MWf4n32K+PEnqYXDV4tj1QsNpWV610jhxYnkrDjMyM
	WjX+X2Ed+NejoJDWB6Vc4Wn1A2ylcSCizoYDg4iEl5s+2VwSYdYDNQEBfaNcgHUH
	7fJgq+7moiU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A551A2D85F;
	Tue, 29 Jul 2014 17:38:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 440A82D858;
	Tue, 29 Jul 2014 17:38:01 -0400 (EDT)
In-Reply-To: <vpqegx5vivp.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	28 Jul 2014 13:10:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D6959C6-1768-11E4-B49F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254472>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Tanay Abhra <tanayabh@gmail.com> writes:
>
>> [v13]: v12 was rejected because of redundant implementation of the new functions,
>> 	hope this one is okay.
>
> It is to me at least.
>
> Thanks,

OK, will replace.
