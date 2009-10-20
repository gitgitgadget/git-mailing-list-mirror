From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git fsck not identifying corrupted packs
Date: Tue, 20 Oct 2009 13:56:53 +0200
Message-ID: <vpq1vkygtx6.fsf@bauges.imag.fr>
References: <loom.20091019T094924-194@post.gmane.org>
	<4ADC2D45.3020803@viscovery.net>
	<alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
	<7v7hur1a0h.fsf@alter.siamese.dyndns.org>
	<vpqy6n6shri.fsf@bauges.imag.fr>
	<7vfx9esgvt.fsf@alter.siamese.dyndns.org>
	<81b0412b0910200225g47220cc9wa2e82290a853c85d@mail.gmail.com>
	<alpine.DEB.1.00.0910201221250.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 20 14:06:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0DOr-0005BI-3e
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 14:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbZJTMBC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 08:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbZJTMBC
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 08:01:02 -0400
Received: from imag.imag.fr ([129.88.30.1]:53674 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751344AbZJTMBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 08:01:00 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n9KBurTP001860
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 20 Oct 2009 13:56:53 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1N0DKf-0007cc-LS; Tue, 20 Oct 2009 13:56:53 +0200
In-Reply-To: <alpine.DEB.1.00.0910201221250.4985@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Tue\, 20 Oct 2009 12\:22\:40 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 20 Oct 2009 13:56:54 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130788>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 20 Oct 2009, Alex Riesen wrote:
>
>> On Tue, Oct 20, 2009 at 08:45, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> > Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> >>> It probably is also a good idea to add a "--loose" option that d=
oes what
>> >>> "fsck" currently does without "--full". =A0It is a good name
>>=20
>> --no-full works
>
> It works.  Technically.  For human users, though, --loose-objects-onl=
y=20
> (with a shortcut "--loose") would be better.

OTOH, the advantage of "--no-full" is that it's compatible with
existing Git versions. If I learn Git 1.6.6 with --no-full, and use it
in a script, then my stript works also with older Gits.

But anyway, I think very few people are actually interested in "git
--no-full" (or call it whatever you like), so I don't think this is
very important.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
