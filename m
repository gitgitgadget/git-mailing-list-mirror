From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] fast-import.c: replace `git_config()` with `git_config_get_*()` family
Date: Wed, 13 Aug 2014 10:14:45 -0700
Message-ID: <xmqq8ums48hm.fsf@gitster.dls.corp.google.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
	<vpqppg4vdii.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 13 19:15:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHc8a-0001DK-JH
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 19:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbaHMRO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 13:14:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62428 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222AbaHMRO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 13:14:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB0B930B2B;
	Wed, 13 Aug 2014 13:14:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VYLaqrTgP6aeaIJoscGcloQKy+A=; b=swtJ01
	aQ9jwvwuzANq+C5k7cqUuBICCEHouiczzq6L1hWAKf4UhK9azSiNqMKlsVrWyfgN
	a4+9xoNLfkm/sAMB8j1mV2gXwarqwTPkBFlBUABTiCq4it893UCdxjvVPD8yzEeE
	aGfhyzkNfdHlOcdfxbQLcxqlMovX9zz7EOl6U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y0nXmrFH9CnsgsONZPuXVwnFTIEBktTD
	+bjV/YHbe6RYsRrM38g+dm0tMHAFC6Ycqfpl16E9wMYOinjUyO1R20C45pUlXmmF
	eVsIuzIDc3JXVJSvXhahvXGfQUmxbvIenTPfdqRPo0XVl2V8HzeblW05dOzTmPE2
	PrTHvBm3PGg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF7E730B29;
	Wed, 13 Aug 2014 13:14:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 037AC30B1F;
	Wed, 13 Aug 2014 13:14:46 -0400 (EDT)
In-Reply-To: <vpqppg4vdii.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	13 Aug 2014 13:24:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 537DE8E4-230D-11E4-A3ED-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255218>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Not that it's terribly important, but I think it's good that your
> refactoring also brings a few end-users benefits. It will help you show
> off when you tell your friends what you did this summer (not "I did
> useless code churn" ;-) ), and helps everybody see the benefits of your
> GSoC ;-).

;-)
