From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: git push default behaviour?
Date: Thu, 08 Mar 2012 10:00:07 -0500
Message-ID: <4F58C977.8000400@xiplink.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>  <87k42vs8pi.fsf@thomas.inf.ethz.ch>  <CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>  <1331202483.21444.11.camel@beez.lab.cmartin.tk>  <CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com> <1331203321.21444.13.camel@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremy Morton <jeremy@configit.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5evR-0001zo-Pg
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 16:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386Ab2CHPGg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 10:06:36 -0500
Received: from smtp142.dfw.emailsrvr.com ([67.192.241.142]:44942 "EHLO
	smtp142.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab2CHPGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 10:06:35 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Mar 2012 10:06:35 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp24.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id B220E180629;
	Thu,  8 Mar 2012 10:00:08 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp24.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 2F3F6180662;
	Thu,  8 Mar 2012 10:00:08 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <1331203321.21444.13.camel@beez.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192606>

On 12-03-08 05:42 AM, Carlos Mart=C3=ADn Nieto wrote:
> On Thu, 2012-03-08 at 10:38 +0000, Jeremy Morton wrote:
>> But 'push --force' WILL try to push your (probably outdated) master
>> upstream, killing any changes there made since you last updated.  Th=
at
>> alone is so dangerous it seems like reason enough to avoid it by
>> default.
>
> Then don't use --force without specifying exactly what you want.
> Anything with that option needs to be used carefully.

I agree with Jeremy that the default is dangerous, or at the very least=
=20
surprising.

Perhaps --force should be changed to require an explicit ref if=20
push.default =3D matching (and the code finds that it needs to use=20
push.default's value)?

By itself that change would make it impossible to use --force to=20
force-change all matching refs (i.e. the current default behaviour woul=
d=20
disappear completely).  I'm OK with that, personally.

		M.
