From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 05:06:28 +0200
Message-ID: <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 05:08:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITUBN-0001zL-Kc
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 05:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbXIGDGw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 6 Sep 2007 23:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbXIGDGw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 23:06:52 -0400
Received: from wincent.com ([72.3.236.74]:47553 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932709AbXIGDGw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 23:06:52 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8736XtD020587;
	Thu, 6 Sep 2007 22:06:34 -0500
In-Reply-To: <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57967>

El 7/9/2007, a las 2:21, Dmitry Kakurin escribi=F3:

> I just wanted to get a sense of how many people share this "Git shoul=
d
> be in pure C" doctrine.

Count me as one of them. Git is all about speed, and C is the best =20
choice for speed, especially in context of Git's workload.

Cheers,
Wincent
