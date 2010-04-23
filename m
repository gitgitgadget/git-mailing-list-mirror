From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 22:17:41 +0200
Message-ID: <87aastx6sa.fsf@frosties.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221651590.7232@xanadu.home>
	<87vdbitu9v.fsf@frosties.localdomain>
	<25441792-181D-456D-8182-F33B49209EFF@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Goswin von Brederlow <goswin-v-b@web.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 22:17:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5PJu-0000HE-Lj
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 22:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab0DWURo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 16:17:44 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:51415 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab0DWURn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 16:17:43 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0EFBB14E23DD0;
	Fri, 23 Apr 2010 22:17:42 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O5PJl-0004pL-00; Fri, 23 Apr 2010 22:17:41 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O5PJl-0004zk-8u; Fri, 23 Apr 2010 22:17:41 +0200
In-Reply-To: <25441792-181D-456D-8182-F33B49209EFF@wincent.com> (Wincent
	Colaiuta's message of "Fri, 23 Apr 2010 18:01:57 +0200")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX1/O7QXJwUCKn0tekxo5xr4RHWsOjC1cXwRmM5YN
	Bkk9Ckvq4DgdJie9iXbhonN1LevfnRaeW/PcKsAs8Bh1Dv5vhm
	o64A+d4I4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145638>

Wincent Colaiuta <win@wincent.com> writes:

> El 23/04/2010, a las 11:03, Goswin von Brederlow escribi=F3:
>>=20
>> You all say the index is such a great thing. So I might use it
>> eventually. Other people might use it 1 out of 10 times. Yet other
>> people use it 9 out of 10 times. Can you at least accept that the us=
e of
>> the index feature is different for each person?
>>=20
>> My suggested change, with the --a-if-empty option, would not impose
>> anything on existing usage. But it would benefit those that rarely u=
se
>> an index and would like git to be smart enough to know when to use t=
he
>> index and when not. Yes, it would mean the use of the index ideology=
 is
>> not force upon people anymore. But isn't that a good thing? Free
>> software is about freedom. That should include the freedom not to us=
e
>> the index method.
>
> Not really. Git is free in the sense that: (1) it costs nothing; and =
(2) you can modify the code to do anything you want.
>
> But you've also got to recognize that along with your freedom to make=
 modifications, the maintainers are free to either accept or reject the=
m too.=20
>
> And in the event that the changes you want aren't accepted, you're fr=
ee to either fork the tool or pick another one which does conform bette=
r to your expectations.

But you are already rejecting it in the design phase before there even
is a patch.

> In the present case experience has shown that the index and the way i=
t can be exploited are an incredibly useful thing. Not only that, it's =
a differentiating feature of Git and it sets it apart from other SCMs, =
in a good way. We could mindlessly homogenize to be more like other sys=
tems, or less "surprising" for users coming from other systems, but we'=
d be throwing away something valuable in the process.

If I would ask to disable the indexing feature then you would have a
point. But I am not. I'm asking to add something that allows to use git
in a less "surprising" mode that, with the --a-if-empty option, does no=
t
alter anything else. Git would still have all its great, big, shiny,
differentiating features to set it apart from other SCMs without forcin=
g
them down the users throat.

> I personally don't see the point in having a bunch of SCMs that are a=
ll exactly alike. I _like_ that Git's different, and over the years hav=
e become so used to the benefits that working with the index "the Git w=
ay" bring, that it's hard to imagine how I ever lived without it.
>
> Cheers,
> Wincent

I personaly have to work with different SCMs every day and every time I
have to switch minds to work with each specific one. Making git commit
work less surprising would be one less thing to keep in mind.

You like that Git is different so don't use the --a-if-empty option. Yo=
u
will have lost nothing by allowing that option in. So far I have read
arguments from people saying they don't want to USE the option. But no
arguments why there could not be such an option. And I'm not the only
one that would welcome such an option. Is there no room for a compromis=
e?

MfG
        Goswin
