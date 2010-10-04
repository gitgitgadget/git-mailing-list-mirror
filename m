From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Documentation/git-clone: describe --mirror more verbose
Date: Mon, 04 Oct 2010 09:25:17 +0200
Message-ID: <4CA9815D.3040801@drmicha.warpmail.net>
References: <1285963983-5629-1-git-send-email-u.kleine-koenig@pengutronix.de>	 <AANLkTimN53bcadyzshHNVULkt=kzdfTQrUmZxUd+FKpY@mail.gmail.com> <1285967766.6750.2.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Darren Hart <darren@dvhart.com>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:25:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fQB-0003lS-56
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab0JDHZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 03:25:08 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:44562 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752824Ab0JDHZH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 03:25:07 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6DB2B74E;
	Mon,  4 Oct 2010 03:25:06 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 04 Oct 2010 03:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=XHaukocBwHD62A+go9/NiKc4ATk=; b=JTCCmCZWVRZWVcmo6m+IGWsriSuJ7ke6ftzztzJrck93/kPLK6XNs60tXjYanT33r+17/3u+TdClorEmbyrn5XrKLDJx7IENJEk/QE5CKde8nff26WxKiz2BwmAr/wW4WClRJuIuHFYZVGBtkhW9uhQfzzjlZxiwP2mWq6bfTho=
X-Sasl-enc: TS3L9+i7o4TqwxVZ9LddfPg62MLe4cQsaBooBu2iBQhA 1286177106
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AFE125E5BEE;
	Mon,  4 Oct 2010 03:25:05 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <1285967766.6750.2.camel@gandalf.stny.rr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157997>

Steven Rostedt venit, vidit, dixit 01.10.2010 23:16:
> On Fri, 2010-10-01 at 13:18 -0700, Darren Hart wrote:
>> 2010/10/1 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
>>> Some people in #linux-rt claimed that you cannot define "--mirror" =
with
>>> "mirror".
>>>

I'd say "mirror" is a commonly known term for an exact copy. Moreover,
the text below doesn't explain what a mirror is either, only how
"update" behaves in it.

>>> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>>
>> Acked-by: Darren 'Some People' Hart <darren@dvhart.com>
>=20
>   Acked-by: Steven Rostedt <rostedt@goodmis.org>
>=20
> -- Steve
>=20
>>
>>> ---
>>>  Documentation/git-clone.txt |   11 ++++++++++-
>>>  1 files changed, 10 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.=
txt
>>> index dc7d3d1..5eedfbd 100644
>>> --- a/Documentation/git-clone.txt
>>> +++ b/Documentation/git-clone.txt
>>> @@ -128,7 +128,16 @@ objects from the source repository into a pack=
 in the cloned repository.
>>>        configuration variables are created.
>>>
>>>  --mirror::
>>> -       Set up a mirror of the remote repository.  This implies `--=
bare`.
>>> +       Set up a mirror of the remote repository.
>>> +       Using
>>> +
>>> +               git remote update origin
>>> +
>>> +       (or `<name>` instead of `origin` if -o is given) in the res=
ulting

"remote" has no "-o" option. You probably mean the "clone" option, but
the way it's written it refers to the preceding command.

>>> +       repository overwrites the local branches without asking.
>>> +       This implies `--bare`.

Again, "this" refers to the preceding sentence. But the update behavior
does not imply "--bare". Specifying "--mirror" for "clone" implies "--b=
are".

>>> +       Without --mirror (but with --bare) git remote update doesn'=
t touch any
>>> +       branches at all.

That's not true. It just doesn't touch any local branches; it updates
the remote branches, of course.

I'm sorry but I can't consider this patch an improvement.

Michael
