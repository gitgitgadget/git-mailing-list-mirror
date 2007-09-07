From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 7 Sep 2007 14:55:01 +0200
Message-ID: <20070907125501.GA21142@diana.vm.bytemark.co.uk>
References: <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <46E0EEC6.4020004@op5.se> <Pine.LNX.4.64.0709071155570.28586@racer.site> <46E13C0F.8040203@op5.se> <E4A6490A-ABA9-4383-978E-C7F2E4BC9C23@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 14:56:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITdNG-00070P-Dj
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 14:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305AbXIGMzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 7 Sep 2007 08:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbXIGMzp
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 08:55:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3374 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132AbXIGMzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 08:55:44 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1ITdMT-0005fM-00; Fri, 07 Sep 2007 13:55:01 +0100
Mail-Followup-To: Wincent Colaiuta <win@wincent.com>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E4A6490A-ABA9-4383-978E-C7F2E4BC9C23@wincent.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58037>

On 2007-09-07 14:33:42 +0200, Wincent Colaiuta wrote:

> Well, you picked a very specific algorithm amenable to that kind of
> optimization: small, manageable, with a minimal and well-defined
> performance critical section that could be written in assembly. Note
> how a good chunk of the implementation was still in C.

And this is of course exactly the kind of spot where you _would_ use
assembly in the real world. 99.99% of code is better written in C than
assembler, but there is that 0.01% where hand-coded assembler is a
better choice.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
