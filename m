From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] msvc: Fix compilation error due to missing mktemp()
 declaration
Date: Tue, 11 Jan 2011 12:14:51 -0800
Message-ID: <7vaaj742pw.fsf@alter.siamese.dyndns.org>
References: <4D1F8F06.9090700@ramsay1.demon.co.uk>
 <4D2CA28A.4070401@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, kusmabite@gmail.com
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 11 21:15:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pckca-00074V-3e
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 21:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab1AKUPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 15:15:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab1AKUPE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 15:15:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72F87383A;
	Tue, 11 Jan 2011 15:15:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wdWQdRfMUuVKC4qHrMu1fMrnUYA=; b=P+BV1w
	98sKNam/D+2tA0cZ2SLm6XAhhlqIdUa1fJaGzkMb982q8EtF9l4ruk/6GXehu3tQ
	LXXs8mIWD7n7WQFeqwVALN3qsdqoZ+4oRP/JzZJHfaWXKHIkATyeqIAGTGoml0YL
	78zoX+FfL06aVN/N7LB5rBCrh75dAsOHiGcLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ngyXtrjx49Ym5YBjHrw7qgUHVzuHLHp+
	5rOWVdF3J8UDJwTVTwZlQrjDyPIZy1ORe9gl3IUL4xhcx49n3LSlBgQrSWk4/9+Q
	PeeK2gw08gsSMRacMXAs171Sum+6/vy+60rREx9L+Wd19ELpRqmb/yHDjlaPN6Ix
	QIReoulF4UU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 409E83838;
	Tue, 11 Jan 2011 15:15:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EA93C3832; Tue, 11 Jan 2011
 15:15:33 -0500 (EST)
In-Reply-To: <4D2CA28A.4070401@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue\, 11 Jan 2011 18\:33\:46 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8EC3365E-1DBF-11E0-8056-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164988>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> ping... Are there any remaining concerns regarding this patch?

I dunno.  Is everybody on the Windows side happy with it?
