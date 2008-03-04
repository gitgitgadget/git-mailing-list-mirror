From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [PATCH] Configure test for FREAD_READS_DIRECTORIES
Date: Tue, 4 Mar 2008 12:48:53 +0100
Organization: NextSoft
Message-ID: <200803041248.54197.michal.rokos@nextsoft.cz>
References: <200803041048.53399.michal.rokos@nextsoft.cz> <200803041217.37027.michal.rokos@nextsoft.cz> <7v7igi911y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 12:49:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVeQ-0007iF-Mp
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbYCDLtE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2008 06:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756894AbYCDLtD
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:49:03 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:51184 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbYCDLtB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2008 06:49:01 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id E1BE78D6; Tue,  4 Mar 2008 12:48:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id DE2318E2;
	Tue,  4 Mar 2008 12:48:58 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07929-10; Tue, 4 Mar 2008 12:48:58 +0100 (CET)
Received: from 89-24-113-79.i4g.tmcz.cz (89-24-113-79.i4g.tmcz.cz [89.24.113.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 97FB46A9;
	Tue,  4 Mar 2008 12:48:58 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v7igi911y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76071>

Hello,

On Tuesday 04 March 2008 12:32:57 Junio C Hamano wrote:
> Michal Rokos <michal.rokos@nextsoft.cz> writes:
> >> On how many different platforms was this configure check tested on=
?
> >
> > Test works on Linux (no FREAD_READS_DIRECTORIES) and HPUXes
> > (FREAD_READS_DIRECTORIES): HP-UX B.11.23 ia64 (Itanium) and HP-UX B=
=2E11.11
> > 9000/800 (PaRisc)
> >
> > Do you want me to resend with "."?
>
> Probably resending with "." and asking the list audiences for help in
> testing would help you gather success reports on different platforms.

Will do... Did that.

Do you think that there's some reason not-to merge it? I mean if fopen(=
".")=20
throws an error, FREAD_READS_DIRECTORIES will NOT be defined - as is it=
 now.

I don't know how many people cares about configure script since there a=
re=20
missing bits in it again and again. I believe it could receive good amo=
unt of=20
testing only when it's merged in.

I'm trying to make GIT working on HPUX - next patch in my queue is abou=
t=20
broken vsnprintf() that returns -1 on maxsize overrun. Do you think tha=
t it's=20
more likely that patch will be accepted when I omit "broken vsnprintf()=
"=20
detection code from configure.ac?

MR

--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
