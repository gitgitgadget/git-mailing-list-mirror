From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Thu, 08 Nov 2012 11:46:08 -0500
Message-ID: <509BE1D0.60508@xiplink.com>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <50092C8C.3000305@alum.mit.edu> <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com> <509B7E6B.1030407@alum.mit.edu> <CACBZZX5FihEMSyrws-D7GyWvxtpMCPwvaiM18ZqOBaoBcvEjDA@mail.gmail.com> <509BA2E7.4080102@alum.mit.edu> <509BDCC3.1050107@xiplink.com> <CACBZZX75tytc=SMY6Y6TuaR3AQ5VL73NmjCT3dd3BRCrGkjpxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 17:56:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWVPI-0004xt-Ii
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 17:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756339Ab2KHQ4a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Nov 2012 11:56:30 -0500
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:33763 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764Ab2KHQ4a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 11:56:30 -0500
X-Greylist: delayed 582 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2012 11:56:29 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp28.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 03A18E0C63
	for <git@vger.kernel.org>; Thu,  8 Nov 2012 11:46:47 -0500 (EST)
X-Virus-Scanned: OK
Received: from smtp154.ord.emailsrvr.com (smtp154.ord.emailsrvr.com [173.203.6.154])
	by smtp28.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTPS id E0FBDE0C5E
	for <git@vger.kernel.org>; Thu,  8 Nov 2012 11:46:46 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 7A4D01983E4;
	Thu,  8 Nov 2012 11:46:05 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp24.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 07BC01983FD;
	Thu,  8 Nov 2012 11:46:03 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <CACBZZX75tytc=SMY6Y6TuaR3AQ5VL73NmjCT3dd3BRCrGkjpxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209173>

On 12-11-08 11:37 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Nov 8, 2012 at 5:24 PM, Marc Branchaud <mbranchaud@xiplink.co=
m> wrote:
>> I'd like there to be one list that always gets everything, and the o=
ther
>> lists should get subsets of the everything list.
>=20
> Since it supports multiple mailing lists per category you can always
> do (I can't remember the specific config keys, but it's not
> important):
>=20
>     commits =3D all-git-activity@example.com,git-commits@example.com
>     tags        =3D all-git-activity@example.com,git-tags@example.com
>=20
> etc.

True enough.  Still a bit awkward though, especially for folks who can'=
t set
up emails lists easily.  But I'm happy with this approach.

		M.
