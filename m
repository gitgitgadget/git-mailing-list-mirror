From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Our cumbersome mailing list workflow
Date: Fri, 28 Nov 2014 10:42:44 -0500
Message-ID: <547897F4.5000305@xiplink.com>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>	<546F4B5B.2060508@alum.mit.edu> <xmqq61e81ljq.fsf@gitster.dls.corp.google.com> <5473CD28.5020405@alum.mit.edu> <54776367.1010104@web.de> <54788743.5090703@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	=?windows-1252?Q?Torsten_B?= =?windows-1252?Q?=F6gershausen?= 
	<tboegi@web.de>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 16:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XuNlL-0005Cd-G5
	for gcvg-git-2@plane.gmane.org; Fri, 28 Nov 2014 16:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbaK1PrL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Nov 2014 10:47:11 -0500
Received: from smtp74.ord1c.emailsrvr.com ([108.166.43.74]:35988 "EHLO
	smtp74.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750812AbaK1PrK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2014 10:47:10 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Nov 2014 10:47:10 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp26.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 55FAE3803A7;
	Fri, 28 Nov 2014 10:41:33 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp26.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A434038030B;
	Fri, 28 Nov 2014 10:41:32 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.3.2);
	Fri, 28 Nov 2014 15:41:33 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <54788743.5090703@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260367>

On 14-11-28 09:31 AM, Michael Haggerty wrote:
> On 11/27/2014 06:46 PM, Torsten B=F6gershausen wrote:
>> On 2014-11-25 01.28, Michael Haggerty wrote:
>> []
>>> Let me list the aspects of our mailing list workflow that I find
>>> cumbersome as a contributor and reviewer:
>>>
>>> * Submitting patches to the mailing list is an ordeal of configurin=
g
>>> format-patch and send-email and getting everything just right, usin=
g
>>> instructions that depend on the local environment.
>> Typically everything fits into ~/.gitconfig,
>> which can be carried around on a USB-Stick.
>> Is there any details which I miss, or howtows we can improve ?
>=20
> I used to need one setup at work and a different one at home (because=
 of
> how my email was configured), and sometimes had to switch back and fo=
rth
> as I carried my notebook around.
>=20
>>> [...]
>>>   * I do "git fetch gitster", then try to figure out whether the br=
anch
>>> I'm interested in is present, what its name is, and whether the ver=
sion
>>> in your tree is the latest version, then "git checkout xy/foobar".
>> There are 12 branches from mh/, so it should be possible to find the=
 name,
>> und run git log gitster/xy/fix_this_bug or so.
>> Even more important, this branch is the "single point of truth", bec=
ause
>> this branch may be merged eventually, and nothing else.
>=20
> I know it's *possible*. The question is whether it could be made easi=
er.
>=20
>>> * Following patch series across iterations is also awkward. To comp=
are
>>> two versions, I have to first get both patch series into my repo, w=
hich
>>> involves digging through the ML history to find older versions, fol=
lowed
>>> by the "git am" steps. Often submitters are nice enough to put link=
s to
>>> previous versions of their patch series in their cover letters, but=
 the
>>> links are to a web-based email archive, from which it is even more
>>> awkward to grab and apply patches. So in practice I then go back to=
 my
>>> email client and search my local archive for my copy of the same em=
ail
>>> that was referenced in the archive, and apply the patch from there.
>>> Finding comments about old versions of a patch series is nearly as =
much
>>> work.
>> In short:
>> We can ask every contributor, if the patch send to the mailing list
>> is available on a public Git-repo, and what the branch name is,
>> like _V2.. Does this makes sense ?
>=20
> That would be helpful, but it would put yet *another* requirement on =
the
> submitter (to send patch emails *and* push the branch to some accessi=
ble
> repository). We regulars could script this pretty easily, but people =
who
> only contribute occasionally or who are trying to get started will be
> even more overwhelmed.

A bot could subscribe to the list and create branches in a public repo.
(This idea feels familiar -- didn't somebody attempt this already?)

Integrate the bot into the list manager, and every PATCH email sent thr=
ough
the list could have the patch's URL (maybe in the footer, or as an X- h=
eader).

Could this make a decent GSoC project?

		M.
