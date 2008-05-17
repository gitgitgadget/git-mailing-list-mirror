From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Sat, 17 May 2008 17:08:23 +0200
Message-ID: <393B2C1A-49D3-48A7-BF7D-7938D212AF82@wincent.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>  <e2b179460805060631l506e2a6leaafc9c0acf3b05b@mail.gmail.com>  <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>  <alpine.DEB.1.00.0805161125320.30431@racer>  <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org> <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com> <alpine.DEB.1.00.0805171102480.30431@racer>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>,
	Kevin Ballard <kevin@sb.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 17 17:09:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxO2F-0008IU-Tm
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 17:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506AbYEQPId convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 May 2008 11:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbYEQPId
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 11:08:33 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:45607 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521AbYEQPId convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2008 11:08:33 -0400
Received: from cuzco.lan (62.pool85-53-9.dynamic.orange.es [85.53.9.62])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m4HF8OZO002335
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 17 May 2008 11:08:26 -0400
In-Reply-To: <alpine.DEB.1.00.0805171102480.30431@racer>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82350>

El 17/5/2008, a las 12:04, Johannes Schindelin escribi=F3:
> Hi,
>
> On Sat, 17 May 2008, Andr=E9 Goddard Rosa wrote:
>
>> Is this user interface set on stone? I think we should reserve the =20
>> right
>> to improve always.
>
> Umm.
>
> As has been mentioned, this is not a "user interface".  The message =20
> you
> are seeing comes from a _plumbing_ program, i.e. something _not_ =20
> meant for
> human consumption.

That would indicate a problem, if stuff not intended for human =20
consumption is being dished up for exactly that: human consumption.

> I still think that it might be better to add a command line option =20
> with a
> custom message, because that would _not_ break backwards-=20
> compatibility.

Sounds like clutter to me. I'd instead favor just holding back this =20
patch until 1.6, when (minor) "compatibility breaking" changes would =20
be acceptable.

Wincent
