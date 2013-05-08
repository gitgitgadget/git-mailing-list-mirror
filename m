From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull updates for Git 1.8.3 l10n round 2
Date: Tue, 07 May 2013 18:25:19 -0700
Message-ID: <7vhaiei7pc.fsf@alter.siamese.dyndns.org>
References: <CANYiYbFcJgiBXUSQWUtvPmGOT3qmrVeuB4xaEtYOymLOEqmYzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Byrial Jensen <byrial@vip.cybercity.dk>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Vincent van Ravesteijn <vfr@lyx.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	David =?utf-8?B?SHJiw6HEjQ==?= <david@hrbac.cz>,
	Harring Figueiredo <harringf@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 08 03:25:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZt8Y-00020e-DZ
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 03:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998Ab3EHBZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 21:25:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754943Ab3EHBZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 21:25:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52A44D931;
	Wed,  8 May 2013 01:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VwkOzK0Z6GpY5q8U5WQOUULnNhU=; b=ALopH7
	lGwyl7+koAXIIaOO6YEvgjzV8gTrTwg1Eb+XfHO4v1ht3kz+FL5i5jjSqgtO1A1W
	hVeV4SkUWakmSRfBjYFaMBIxHnLGjcN6cuZlomOTWevIVG+IN5D44tRe+8tChk11
	kMnJhOYZzib/hakvas8R9c6/+ays0Wpzj3toY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QoPgQchhTnVL2HWZ1+MSX/so7ixiTB1g
	oW6QKU+tszhpRXGV3wfqWhHlj/cR3Qq6u2rFNihMPpOc/eqoVRCwC3OlEa+kwPhZ
	wenONWFB4pvUnmqd33VVJrfLsbZVyO7+FOVmtIoeseNMeseVSyZp++prAhHdQMW5
	xFmg6dYoGh0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47581D930;
	Wed,  8 May 2013 01:25:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F117D92F;
	Wed,  8 May 2013 01:25:21 +0000 (UTC)
In-Reply-To: <CANYiYbFcJgiBXUSQWUtvPmGOT3qmrVeuB4xaEtYOymLOEqmYzw@mail.gmail.com>
	(Jiang Xin's message of "Wed, 8 May 2013 08:21:19 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26B45CD6-B77E-11E2-B4AA-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223635>

Jiang Xin <worldhello.net@gmail.com> writes:

> Hi Junio,
>
> The following changes since commit 7e6a0cc47da79dd22c0338aee8750fda92ced5d9:
>
>   git-completion.bash: add remote.pushdefault to config list
> (2013-04-29 09:57:47 -0700)
>
> are available in the git repository at:
>
>   git://github.com/git-l10n/git-po master
>
> for you to fetch changes up to 4dcdc3d8ccfb7e6ae3a2d151b5df59785548a040:
>
>   l10n: zh_CN.po: translate 44 messages (2080t0f0u) (2013-05-08 08:13:32 +0800)

Thanks, will pull.
