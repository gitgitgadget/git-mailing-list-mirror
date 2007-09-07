From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 11:19:43 +0200
Message-ID: <774D124B-B37E-40D4-9C0F-B8B2E9C70288@wincent.com>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <loom.20070907T055946-637@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Wankadia <junyer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 11:20:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITa0N-0000XO-Ff
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 11:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbXIGJTz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 05:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbXIGJTy
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 05:19:54 -0400
Received: from wincent.com ([72.3.236.74]:48264 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965016AbXIGJTy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 05:19:54 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l879JmLl028498;
	Fri, 7 Sep 2007 04:19:49 -0500
In-Reply-To: <loom.20070907T055946-637@post.gmane.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58009>

El 7/9/2007, a las 6:06, Paul Wankadia escribi=F3:

> Wincent Colaiuta <win <at> wincent.com> writes:
>
>>> I just wanted to get a sense of how many people share this "Git =20
>>> should
>>> be in pure C" doctrine.
>>
>> Count me as one of them. Git is all about speed, and C is the best
>> choice for speed, especially in context of Git's workload.
>
> I concur, but I also feel that D, Clean and OCaml are viable =20
> alternatives.

Yes, they have reputation for speed[1], but also a smaller number of =20
people know them[2].

[1] <http://shootout.alioth.debian.org/gp4/benchmark.php?=20
test=3Dall&lang=3Dall>
[2] <http://www.tiobe.com/tpci.htm>

Cheers,
Wincent
