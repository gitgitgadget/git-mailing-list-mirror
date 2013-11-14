From: "Kent R. Spillner" <kspillner@acm.org>
Subject: Re: 64-bit support.
Date: Thu, 14 Nov 2013 08:40:15 -0600
Message-ID: <27C8BBEE-128F-4CC1-AACE-248CA0CD8FBE@acm.org>
References: <CAJc7Lbr9Ej8JHo6m4HFwdo9GE2tBQCkypEMxMW+jEXKB1Lry=g@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 15:47:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgyBv-0001fL-W6
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 15:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754358Ab3KNOqk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Nov 2013 09:46:40 -0500
Received: from smtp182.dfw.emailsrvr.com ([67.192.241.182]:52372 "EHLO
	smtp182.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab3KNOqj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Nov 2013 09:46:39 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Nov 2013 09:46:39 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp8.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id CC0BB82BF;
	Thu, 14 Nov 2013 09:40:20 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp8.relay.dfw1a.emailsrvr.com (Authenticated sender: sl4mmy-AT-zerosphere.org) with ESMTPSA id 400C782E5;
	Thu, 14 Nov 2013 09:40:20 -0500 (EST)
In-Reply-To: <CAJc7Lbr9Ej8JHo6m4HFwdo9GE2tBQCkypEMxMW+jEXKB1Lry=g@mail.gmail.com>
X-Mailer: iPhone Mail (11B511)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237851>

Can you be more specific about the limitation you suspect you are hitti=
ng?  32,768 is not the "max 32-bit value."


> On Nov 14, 2013, at 6:58, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=B8=D0=
=BD =D0=98=D0=B2=D0=B0=D0=BD  <abyss.7@gmail.com> wrote:
>=20
> Hi!
>=20
> Do you plan to implement the 64-bit support in git? - Right now I hav=
e
> a problems sometimes with a huge repo and renaming detection. If I
> merge more than 32768 files at once, then the renaming detection
> fails, because of limitation inside git. The limitation is put by max
> 32-bit value.
>=20
> I tweaked sources locally, to use 64-bit value as a number of merging
> files - generally, it works. But I'm not so brave to try to replace i=
t
> everywhere in git.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
