From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 08:25:10 +0200
Message-ID: <46E0EEC6.4020004@op5.se>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 08:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITXHO-0001Me-AT
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 08:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbXIGGZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 02:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbXIGGZO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 02:25:14 -0400
Received: from mail.op5.se ([193.201.96.20]:60612 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbXIGGZN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 02:25:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E678319439E;
	Fri,  7 Sep 2007 08:25:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rglq-8bVA9C1; Fri,  7 Sep 2007 08:25:11 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 715F019435F;
	Fri,  7 Sep 2007 08:25:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57984>

Wincent Colaiuta wrote:
> El 7/9/2007, a las 2:21, Dmitry Kakurin escribi=F3:
>=20
>> I just wanted to get a sense of how many people share this "Git shou=
ld
>> be in pure C" doctrine.
>=20
> Count me as one of them. Git is all about speed, and C is the best=20
> choice for speed, especially in context of Git's workload.
>=20

Nono, hand-optimized assembly is the best choice for speed. C is just
a little more portable ;-)

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
