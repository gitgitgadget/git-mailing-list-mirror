From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 3/4] t0027: test cases for combined attributes
Date: Wed, 20 Apr 2016 17:52:16 +0200
Message-ID: <d0d290f7-9c13-610d-8f22-059270bf2c6c@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
 <1461072362-2835-1-git-send-email-tboegi@web.de>
 <xmqq4maxz3lt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, tboegi@web.de
X-From: git-owner@vger.kernel.org Wed Apr 20 17:52:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asuQh-0001VJ-F7
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 17:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbcDTPwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 11:52:31 -0400
Received: from mout.web.de ([212.227.15.4]:56793 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751535AbcDTPwa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 11:52:30 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LrpKY-1bsxSa20vm-013iTA; Wed, 20 Apr 2016 17:52:22
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqq4maxz3lt.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:4zYN2963kg2yhDakbEtG81tk+xwCeC0opxm5/rh9dLaxBoh9hJf
 Evb9Hq5UJZX36uc00IMYq30GH3vK3G8j6yAkoiLxMXTMeLgKP1I6JukiwTCJDxfMK6rP37O
 KtWHIWDTy4fHfeH9gTz8NtYxWGhTj6zvF+/jpNLLZeSZIFYig8mUc4NB9riRUbjaEIK2xCt
 Ln+L+S1lT/tCVrQJamMYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Y0FlajciDWA=:PjTNdkM1fE0aDiyHz3mbL4
 iSuN8ZNeBTX0EPhlLCURas399CTfzbh10aT1YNZ5HsUjpavhiHp/MzJV7Int8C7OhX/r5ZVg6
 7HGmh+5YGRC216ELsH0wJq2BcO4DbchyDVfRg85a2A+vh2Xen+LTg7+OcZctVhHw8DTLq3NnN
 h1KaRNcLpcm6TEQr9IL/C6iB8L8jRg8yRHWwQcXURbHbPoYDZCWzrc42/cDxSKp3/MOoQxd6h
 /My9lEWhwHYHVwFUDKxBw3L6hD7DS2w+9PpyZa1CpagQcKPvZJQLtb0n9igJP4wK9ki9flxfW
 cGI9guNYh7ZiTJsdJWCBg1llnJ7XLwkexD3xVhlLM274QxXEmxAqxSV/mHdV1B78fyhx5Qk/x
 LLOwwlXe5cE9zYLCNRUrCQTmfBHmAvdr5NWnGLS6QKeTF58qqtbMrMfcSMIoGQ/nI5J5pOPxw
 A9JE87szi3xqG6HWJ6NHim2mliab7amIzGF3nWDAMH3bZeYmZfC+uc+GwH/yNci5tpOe4QiDZ
 Zj9aAfjZyO/EOrPr1Cc69ZsqXk88HLfM5ccnL+fXeyXBg4S7jqPS/cqk+UhUQzFhbMDfhGFH6
 6tQB+tu9RTPjXyoUBNroWunquW5m3E1wJgov5J/2MN+lvgVeWDYdgmcdICnk2bFsZcm1m7+Gt
 D/REbQAvYoAJsuNpQw6DI+uP68BHQTnJebt8cTLn/Sx0drhRjCz8qlQDPm7YZDNp7v9/EuDVi
 4+XaigAGNOoLSunKghndVAbPnxrFggtSf/3Qzo3eaaIHZSkiteZ2bjzsssC9HWlBmNTQwqcq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292034>


>> Currently "* text=auto eol=lf" does the same as "* text eol=lf",
>> as the eol attribute overrides "text=auto", this will change in
>> future.
> Will change in future in what way?  In patch 5/4?
>
>
Yes, kind of.
I'm fighting to get the test passed under Windows,
and if this 4/4 could make it into pu, I don't need to
resend all of it.
