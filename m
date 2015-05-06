From: Junio C Hamano <gitster@pobox.com>
Subject: Re: forcing a user@ into the URL if not present
Date: Wed, 06 May 2015 10:18:18 -0700
Message-ID: <xmqqsib9bp5x.fsf@gitster.dls.corp.google.com>
References: <CABU7BddjAZOk0LyybQ8phO0S4705MrZtLSYEsjzUBKUD=H++RQ@mail.gmail.com>
	<CABU7BddHuiYK4s+_+Z9v15D+Nj8icMQSWNY13TZ77wq8Vo6r+A@mail.gmail.com>
	<20150430202342.GC5015@vauxhall.crustytoothpaste.net>
	<CABU7BdcuJp3f6_cN8TpJX-brDUWL6-0Q5M0Yvpg2ND-k--yEbw@mail.gmail.com>
	<CABU7BddLGe-+b4cEiPi9MCd6xY5kpBU6aZuy4Vn7j+NgPdLwuA@mail.gmail.com>
	<231730bb9947a6ddbbd8f3bda36c89f2@www.dscho.org>
	<xmqqmw1iex4m.fsf@gitster.dls.corp.google.com>
	<55499E10.2050003@web.de>
	<e8793cf6c07dcfcfa835dbc4c438918f@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Dan Langille <dlangille@sourcefire.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 06 19:18:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq2xr-0003Zm-R3
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 19:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692AbbEFRSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 13:18:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752372AbbEFRSU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 13:18:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 228BD4E50B;
	Wed,  6 May 2015 13:18:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ggnOF/iTNU/hugHzi8CgG9h0Z0=; b=Dy/fv2
	ISvJk3C7r9s7BfLxAZvg2LGJ2nvMzNJpeKdTc3dqsvY/uM2+I6nXoYVamvB/dL1A
	//pt9bNlpZCpI5G1tmf6xbjW+FXkWhmgoxCYK/jEiOvb0Sdd85DH1/MXD2+7e/5m
	qSi8jwXjDq6RDEwPQ8Gwg44vXugq/BAhr1JfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BaEVEddi49AUCPvjhx8qgN3lXPFgbnVc
	DQonSDuicgsJZOujjuPJZBe+8ELPUbpBTOzMr884vnvOSpGFX4d+teU6q+Jgp2+k
	8cYQ3irHd6YH8RLRBmxw+oHUw+ciJ28ZTVUde0Y8bakbqTerjxB5LQCcAL8sJirx
	I84iQTzabsU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19A7E4E50A;
	Wed,  6 May 2015 13:18:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 83A244E508;
	Wed,  6 May 2015 13:18:19 -0400 (EDT)
In-Reply-To: <e8793cf6c07dcfcfa835dbc4c438918f@www.dscho.org> (Johannes
	Schindelin's message of "Wed, 06 May 2015 07:29:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E40C1D9A-F413-11E4-A452-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268470>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>>> I haven't seen anybody use such a URL but I would say that is a
>>> natural thing to expect to work, as both username and password are
>>> missing so they should default to some sensible values, in this
>>> case "current user, shouldn't need password", just like
>>> "scheme://site:/" is "port missing so it should default to some
>>> sensible value, appropriate for the scheme".
>
> Yes, that makes total sense to me, too. In fact, I found it rather
> clever once I got over the surprise.

Yup, I'd happily call that "clever" ;-)

> TBH it does not seem overly urgent to add those tests for the HTTPS
> handling. From a cursory look it seems that neither
> transport_helper_init()` nor any code in `remote-curl.c` parses the
> "<user@password>" part of the URL, or for that matter puts
> restrictions on it.

Thanks for checking.
