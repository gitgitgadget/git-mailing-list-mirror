From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Thu, 22 Nov 2012 08:32:49 +0100
Message-ID: <50ADD521.8020909@alum.mit.edu>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <50092C8C.3000305@alum.mit.edu> <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com> <509B7E6B.1030407@alum.mit.edu> <CACBZZX5FihEMSyrws-D7GyWvxtpMCPwvaiM18ZqOBaoBcvEjDA@mail.gmail.com> <509BA2E7.4080102@alum.mit.edu> <CACBZZX4gzgTZCk78PYpYHnKdwQ0vScoLz02tuAuUQRXVVXSLVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 00:04:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbfor-0001AU-Hk
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 00:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480Ab2KVXEB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2012 18:04:01 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:63679 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752475Ab2KVXD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2012 18:03:59 -0500
X-AuditID: 1207440f-b7fde6d00000095c-0e-50add52580f6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 33.3F.02396.525DDA05; Thu, 22 Nov 2012 02:32:53 -0500 (EST)
Received: from [192.168.69.140] (p57A25F2E.dip.t-dialin.net [87.162.95.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAM7Wn2v026772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 22 Nov 2012 02:32:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <CACBZZX4gzgTZCk78PYpYHnKdwQ0vScoLz02tuAuUQRXVVXSLVg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsUixO6iqKt6dW2AwbMbAhbHn15nsVj77A6T
	RdeVbiaLht4rzBaXPq9ntWh8UmSx+vEddov3Z/8zO3B47Jx1l91j4pfjrB4XLyl7fN4k53Hg
	8mO2ANYobpukxJKy4Mz0PH27BO6Mq3d2sRRM46548/UtawPjL44uRg4OCQETiddTJbsYOYFM
	MYkL99azdTFycQgJXGaUmDzjETuEc5pJ4s+CH2wgVbwC2hLzZy5hArFZBFQlXnxexQJiswno
	SizqaQaLiwqESazZc4gJol5Q4uTMJ2A1IgLuEl//rmYCGcoscIhJ4tjGFWBFwgLOEivn7GCC
	2PaJSeL72x/sIAlOgUCJVe1TmEFOZRZQl1g/TwgkzCwgL9G8dTbzBEaBWUh2zEKomoWkagEj
	8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXRO93MwSvdSU0k2MkPDn38HYtV7mEKMAB6MSDy+z
	wtoAIdbEsuLK3EOMkhxMSqK81leAQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4FxUA5XhTEiur
	UovyYVLSHCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxVIEMFi1LTUyvSMnNKENJMHJwg
	w7mkRIpT81JSixJLSzLiQZEaXwyMVZAUD9BeL5B23uKCxFygKETrKUZLjg3r258wctz50QUk
	2/d1P2EUYsnLz0uVEuf1BGkQAGnIKM2DWwdLgq8YxYG+F+b1BqniASZQuKmvgBYyAS2Md1kN
	srAkESEl1cC4KunX3nSbtemFQtyX7948orTuZWLI7zU1n4OPsJteL/6yKFGXpcxt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210222>

On 11/08/2012 04:38 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Nov 8, 2012 at 1:17 PM, Michael Haggerty <mhagger@alum.mit.ed=
u> wrote:
>> On 11/08/2012 12:39 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote=
:
>>> But in addition to that we have our own custom E-Mail notification
>>> scripts for:
>>>
>>>  * People can subscribe to changes to certain files. I.e. if you
>>>    modify very_important.c we'll send an E-Mail to a more widely se=
en
>>>    review list.
>>>
>>>  * Invididuals can also edit a config file to watch individual file=
s /
>>>    glob patterns of files, e.g. src/main.c or src/crypto*
>>
[...]
>=20
> I think just sending the individual patch e-mails to all people who
> subscribe to paths that got changed in that patch that match their
> watchlist makes sense.

I forgot to mention, but Environment.get_revision_recipients() has all
the information needed to implement such a policy.  You could override
this method in your own Environment class to get the behavior that you =
want.

> That script *also* supports sending the whole batch of patches pushed
> in that push to someone watching any file that got modified in one of
> the patches, in case you also want to get other stuff pushed in pushe=
s
> for files you're interested in.

This is not yet possible without more intrusive code changes.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
