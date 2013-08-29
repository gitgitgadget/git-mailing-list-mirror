From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 22:03:22 +0200
Message-ID: <521FA90A.9040903@web.de>
References: <20130829180129.GA4880@nysa> <vpqli3kqqkp.fsf@anie.imag.fr> <521f998d25eb4_174378fe7481879@nysa.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 22:04:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF8Rh-0002hp-9W
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 22:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986Ab3H2UDx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Aug 2013 16:03:53 -0400
Received: from mout.web.de ([212.227.15.4]:63868 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755557Ab3H2UDw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 16:03:52 -0400
Received: from [192.168.2.102] ([79.253.158.66]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MBTD4-1VMFyS0DKQ-00AVi4 for <git@vger.kernel.org>;
 Thu, 29 Aug 2013 22:03:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <521f998d25eb4_174378fe7481879@nysa.mail>
X-Provags-ID: V03:K0:6viKRYr9kqKRh6tv390H8PYsKlkjxAOMKsui8h2OiJB++kaI+2P
 aHgqwtnwzj09K2XJaOveH2I2Rk4FBMpZgJzALx3z9iv2sHNkqAKE3pS3Z+m0LQx50Mjqg4E
 Ec7KviRGtzDHRbpuRCWT5bdfh95QfA14S3cnFtJ7nf5xnVv/Mo1CuwofoAAXYMPfAK9Aw9q
 OaDzySHfhju4PCRCKi+/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233354>

Am 29.08.2013 20:57, schrieb Felipe Contreras:
> Matthieu Moy wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>> Moreover, the --stage and --work
>>
>> --work alone sounds weird. At least to me, it does not immediately i=
mply
>> "working tree". It is tempting to call the option --work-tree, but g=
it
>> already has a global option with that name (git --work-tree=3Dfoo ba=
r).
>
> Yes, --work sounds weird, but so does --cherry. I thought about --wt,=
 but I
> felt --work was more understandable, and --work-tree doesn't really g=
ive much
> more value, except more characters to type =3D/

If you have a --work-tree option then parseopt accepts --work as well,=20
unless it's ambiguous, i.e. another option starts with --work, too.  So=
=20
you can have a descriptive, extra-long option and type just a few=20
characters at the same time.

Ren=C3=A9
