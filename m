From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 2/2] index-pack: handle duplicate base objects gracefully
Date: Sun, 31 Aug 2014 18:30:39 +0200
Message-ID: <54034DAF.7030203@web.de>
References: <20140829205538.GD29456@peff.net> <20140829205809.GB7060@peff.net> <xmqqegvz3qpp.fsf@gitster.dls.corp.google.com> <20140829220818.GA24834@peff.net> <CAJo=hJs3mM7=LcOop-WD=bipA=Wx-7MDh6ObQwFUE38tjurvcw@mail.gmail.com> <20140830131649.GA26833@peff.net> <5401F53B.6070707@web.de> <20140831151753.GA17449@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 31 18:31:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XO82K-0002xl-F3
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 18:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbaHaQbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Aug 2014 12:31:17 -0400
Received: from mout.web.de ([212.227.17.12]:56844 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230AbaHaQbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 12:31:16 -0400
Received: from [192.168.178.27] ([79.250.167.144]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MUFGo-1XnwcV4A5a-00R0ER; Sun, 31 Aug 2014 18:30:58
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <20140831151753.GA17449@peff.net>
X-Provags-ID: V03:K0:dg+Q2zllAe/MbY0F7J/M+G/8oKN3064LLZFSOrsJdZEpy9AygQN
 LtSWFUuNXE9tUgvwkMXLW72M7HO6OvXPs5Xd/tRuhjWtGoAgUZtdjvNfrSK4wSYFVoNLrf0
 4Lh8D3/17mQsTZcKCHYsRHDVevf92OH57c7VesizXmbgopwNFpF526Fir8LWcrwC1zDvJz5
 mlJTRrG3uO+Dyfr+NyutA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256294>

Am 31.08.2014 um 17:17 schrieb Jeff King:
> On Sat, Aug 30, 2014 at 06:00:59PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> My only nit with patch 2: Petr Stodulka <pstodulk@redhat.com> and Ma=
rtin von
>> Gagern <Martin.vGagern@gmx.net> should be mentioned as bug reporters=
=2E
>
> Yeah, I agree with that. And actually, you should get a Reported-by:
> on the first patch. :)
>
> However, I think there are some grave implications of this series; se=
e
> the message I just posted elsewhere in the thread. I think we will en=
d
> up dropping patch 2, but keep patch 1.

OK, but it would still be a good idea to replace the assert()s with=20
die()s and error messages that tell users that the repo is broken, not =
git.

Ren=C3=A9
