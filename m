From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Make strbuf_cmp inline, constify its arguments and  optimize it a bit
Date: Mon, 8 Oct 2007 00:12:17 +0200
Message-ID: <EF81F7DD-73C7-4B6F-92D2-4A143CA05365@wincent.com>
References: <1190625904-22808-1-git-send-email-madcoder@debian.org> <1190625904-22808-2-git-send-email-madcoder@debian.org> <20071007140052.GA3260@steel.home> <20071007172425.bb691da9.tihirvon@gmail.com> <20071007143912.GB10024@artemis.corp> <87sl4nlyg0.fsf@catnip.gol.com> <857ilylxhm.fsf@lola.goethe.zz> <20071007215432.GC2765@steel.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, Miles Bader <miles@gnu.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 00:12:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeeMn-0002wh-Fj
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 00:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbXJGWMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Oct 2007 18:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755978AbXJGWMk
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 18:12:40 -0400
Received: from wincent.com ([72.3.236.74]:60157 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755971AbXJGWMj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Oct 2007 18:12:39 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l97MCUZX017301;
	Sun, 7 Oct 2007 17:12:31 -0500
In-Reply-To: <20071007215432.GC2765@steel.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60230>

El 7/10/2007, a las 23:54, Alex Riesen escribi=F3:

>> ... All the rest pretty much
>> was worse than what we started from in that it needed to reevaluate
>> more conditions and turned out more complicated and obfuscate even t=
o
>> the human reader.
>
> it _is_ smaller. And it is _measurably_ faster on that thing I have a=
t
> home (and old p4).

Can we see the numbers and the steps used to obtain them? I'm also a =20
little bit confused about how an inlined function can lead to a =20
smaller executable... or did you just mean lines-of-code?

Cheers,
Wincent
