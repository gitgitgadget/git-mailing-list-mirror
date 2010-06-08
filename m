From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: RFC: Making submodules "track" branches
Date: Tue, 08 Jun 2010 15:32:23 -0400
Message-ID: <4C0E9AC7.7080802@xiplink.com>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com>	<201006080912.31448.johan@herland.net>	<4C0E630A.7020803@xiplink.com> <AANLkTimtWrp1yimeooJ-ptAaDoxwpUc5KOP9HJUxx0X2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 21:32:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM4XO-0002Yc-Fe
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 21:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab0FHTcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 15:32:32 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:59722 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab0FHTcc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 15:32:32 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 051F51DEACC;
	Tue,  8 Jun 2010 15:32:31 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id C63B21E6164;
	Tue,  8 Jun 2010 15:32:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <AANLkTimtWrp1yimeooJ-ptAaDoxwpUc5KOP9HJUxx0X2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148704>

On 10-06-08 12:09 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Tue, Jun 8, 2010 at 15:34, Marc Branchaud <marcnarc@xiplink.com> w=
rote:
>>
>> So, back to the issue at hand: Sometimes I want static (non-tracking=
)
>> submodules, and sometimes I want dynamic (tracking) submodules.  IMO=
, this
>> makes =C3=86var's proposed configuration-based approach impractical.=
  (Of course,
>> I'm not looking to replicate svn's externals...)
>=20
> I'm proposing that you be able to configure how you want to handle
> submodules on a per-submodule basis.

Yes, and that's precisely the problem.  For a given submodule, sometime=
s it
should track a branch and sometimes it shouldn't.  Having to edit a
configuration to change that is impractical.

> The exact semantics that I proposed may be impractical for some
> reason, but the idea is that it'd be opt in. We'd perhaps have
> multiple approaches (via config) to submodules, instead of the curren=
t
> monolithic scheme.

Opting in or out can't just be a monolithic setting for each submodule.=
  A
submodule's branch tracking has to be on or off depending on the circum=
stances.

> So if you didn't want a svn:externals like "always track trunk"
> repository you'd just not set your superproject up to treat the
> submodule like that.

Yes, of course.

I guess what I'm saying is that duplicating svn's externals doesn't see=
m all
that useful to me and I'd rather see git do better.  I've no objection =
if
folks want to have such a feature, but to me it's not what "submodules
tracking branches" should be about.

>>  - It *may* be good enough to assume that matching branch names in t=
he
>> super-repo and the submodules are in fact submodule-spanning branche=
s.
>=20
> That won't work for submodules that you don't control. I have a
> repository that includes a lot of foreign code, they have a lot of
> different names for their "main branch" between them. So it needs to
> be configurable in the superproject.

Good point.  I agree.

		M.
