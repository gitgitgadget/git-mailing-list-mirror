From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: RFC: Making submodules "track" branches
Date: Wed, 09 Jun 2010 10:36:34 -0400
Message-ID: <4C0FA6F2.8060308@xiplink.com>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>	<201006080912.31448.johan@herland.net>	<4C0E630A.7020803@xiplink.com>	<AANLkTimtWrp1yimeooJ-ptAaDoxwpUc5KOP9HJUxx0X2@mail.gmail.com>	<4C0E9AC7.7080802@xiplink.com> <AANLkTilYHfDrtCAcPPxB1AZnzch2ELTEiIFTW3N5LBEc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 16:44:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMMWG-0000Fy-9V
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 16:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757919Ab0FIOo3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 10:44:29 -0400
Received: from smtp162.dfw.emailsrvr.com ([67.192.241.162]:39849 "EHLO
	smtp162.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757871Ab0FIOo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 10:44:27 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2010 10:44:27 EDT
Received: from relay6.relay.dfw.mlsrvr.com (localhost [127.0.0.1])
	by relay6.relay.dfw.mlsrvr.com (SMTP Server) with ESMTP id 79A9C3034B;
	Wed,  9 Jun 2010 10:36:47 -0400 (EDT)
Received: by relay6.relay.dfw.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 1363230514;
	Wed,  9 Jun 2010 10:36:46 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <AANLkTilYHfDrtCAcPPxB1AZnzch2ELTEiIFTW3N5LBEc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148780>

On 10-06-08 04:23 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jun 8, 2010 at 19:32, Marc Branchaud <marcnarc@xiplink.com> w=
rote:
>>
>> Opting in or out can't just be a monolithic setting for each submodu=
le.  A
>> submodule's branch tracking has to be on or off depending on the cir=
cumstances.
>=20
> I don't really get what the objection is exactly. How should "branch
> tracking" be achieved do you think?

Well, I outlined some ideas in my first message in this thread...

>> I guess what I'm saying is that duplicating svn's externals doesn't =
seem all
>> that useful to me and I'd rather see git do better.  I've no objecti=
on if
>> folks want to have such a feature, but to me it's not what "submodul=
es
>> tracking branches" should be about.
>=20
> Obviously I have no objection to doing better, but how specifically
> should that be done? If the semantics you want are "give me the lates=
t
> version of $URL, whatever that is" then the SVN semantics are pretty
> good.

The nuance is that the semantics aren't "*always* give me the latest ve=
rsion
of $URL" but rather "*sometimes* give me the latest version of $URL."

Anyway, others have raised issues that touch on this, and I'm happy to =
just
see where those discussions go.

		M.
