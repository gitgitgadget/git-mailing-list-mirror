From: =?ISO-8859-1?Q?V=E4in=F6_J=E4rvel=E4?= <v@pp.inet.fi>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Fri, 24 Aug 2007 13:52:38 +0300
Message-ID: <0748D6C4-C72F-4271-9372-3EBFC249FFE2@pp.inet.fi>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
 <20070823203246.GB3516@steel.home>
 <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
 <7v8x81s7d1.fsf@gitster.siamese.dyndns.org>
 <9B94A29F-AF61-46C0-8497-C7372DF73250@pp.inet.fi>
 <Pine.LNX.4.64.0708241154410.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 12:58:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOWrn-0002Uk-3z
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 12:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845AbXHXK6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 06:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbXHXK6H
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 06:58:07 -0400
Received: from astana.suomi.net ([82.128.152.18]:45242 "EHLO astana.suomi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763AbXHXK6G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 06:58:06 -0400
Received: from tiku.suomi.net ([82.128.154.67])
 by astana.suomi.net (Sun Java System Messaging Server 6.2-3.04 (built Jul 15
 2005)) with ESMTP id <0JN9004O8YGFGN00@astana.suomi.net> for
 git@vger.kernel.org; Fri, 24 Aug 2007 13:57:51 +0300 (EEST)
Received: from spam1.suomi.net (spam1.suomi.net [212.50.131.165])
 by mailstore.suomi.net
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTP id <0JN900MLIYGSF1H0@mailstore.suomi.net> for git@vger.kernel.org;
 Fri, 24 Aug 2007 13:58:05 +0300 (EEST)
Received: from [192.168.0.138]
 (addr-213-139-166-27.baananet.fi [213.139.166.27])
	by spam1.suomi.net (Postfix) with ESMTP id 1B354241F3D; Fri,
 24 Aug 2007 13:53:15 +0300 (EEST)
In-reply-to: <Pine.LNX.4.64.0708241154410.16728@wbgn129.biozentrum.uni-wuerzburg.de>
X-Mailer: Apple Mail (2.752.3)
X-OPOY-MailScanner-Information: Please contact the OPOY for more information
X-OPOY-MailScanner: Found to be clean
X-OPOY-MailScanner-SpamCheck: not spam, SpamAssassin (not cached, score=-1,
	required 5, autolearn=not spam, BAYES_00 -1.00)
X-OPOY-MailScanner-From: v@pp.inet.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56570>

On Aug 24, 2007, at 12:55, Johannes Schindelin wrote:
> On Fri, 24 Aug 2007, V?in? J?rvel wrote:
>> I also think that maintaining a proper .gitignore is imporant, and =20
>> more
>> productive than using --only-tracked instead. But when I have =20
>> cruft that can't
>> be put in .gitignore, or it would ignore files that are supposed =20
>> to be shown
>> and tracked, I use --only-tracked.
>
> Would it not be better to imitate the "-x" and "-X" options of ls-=20
> files,
> then?  You could achieve the effect you desire by "git status -x =20
> \*" then.
>
> Ciao,
> Dscho

I haven't used that option, do I understand correctly, that with that =20
option, you should provide another exclusion file? That would remove =20
the dynamic ability of --only-tracked.

--
V=E4in=F6