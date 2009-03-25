From: John Tapsell <johnflux@gmail.com>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Wed, 25 Mar 2009 02:13:33 +0000
Message-ID: <43d8ce650903241913p13d8ac7g9473bb0354c2f2ea@mail.gmail.com>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com>
	 <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com>
	 <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com>
	 <alpine.LNX.1.00.0903241304090.19665@iabervon.org>
	 <43d8ce650903241726s122cc468q4ea9188e1561832@mail.gmail.com>
	 <alpine.LNX.1.00.0903242118270.19665@iabervon.org>
	 <7001b7a00903241901w107e2973i9912eab114c9cde0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Irene Ros <imirene@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 03:15:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmIe2-0003tY-TV
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 03:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbZCYCNh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2009 22:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754283AbZCYCNg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 22:13:36 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:3056 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525AbZCYCNf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 22:13:35 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3758582wff.4
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 19:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1cK1M8RD7OxcEmtz0JglcASOFl8hJp4jQAD5ZaH3eQY=;
        b=oLZanNU+pK/vvURaucZPZlTmy7Ge9BXDuuLL22xC++Tp/O0XXpGFrpX6XBoJYxNh9N
         SK0FC3ta4IRIr5Ml5dVbJU/8VDWCYsVxcc9bN/NsETykyE4G4AVftFfCmlAIw7+XR1pZ
         JSIm8n4ATkOfzNQWDcx2dUGjmdchCWwB3WHYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FyBXWmGe2oPFukBeeZJ64Ciihqry8I/j1e1lEMyOxPxP30WdexwaumRP9kL0gLoRtd
         hj0zLwkkkc9PEUacjZjkX97nAmHfTakJ/XIZunv/qdN23kaaAr4FpiwWcJwHAu/7IYg2
         XoOVf/ypPQ16EvZ7l3IzS3rDdVTlnnD9u1j38=
Received: by 10.142.68.5 with SMTP id q5mr3679597wfa.12.1237947213682; Tue, 24 
	Mar 2009 19:13:33 -0700 (PDT)
In-Reply-To: <7001b7a00903241901w107e2973i9912eab114c9cde0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114540>

2009/3/25 Irene Ros <imirene@gmail.com>:
> Hi All,
>
> Thank you for the good advice. I may be the case I am somehow misusin=
g

So, did you actually try:

git fetch

?

> git... I couldn't resolve the issue and so I created a new project of=
f
> of the same repo. Switching to the same branch in question yielded an
> even stranger result: In this new project, the commits were there (I
> could see them in git log and in git log origin/myBranch) whereas in
> the previous older project I did not... does that make sense? Our
> origin branches are located on a central server so can't quite figure
> out why viewing the log of the same remote branch from two different
> projects would yield different results. Any suggestions? At this
> point, I'm just really curious.
>
> -- Irene
>
>
>
> On Tue, Mar 24, 2009 at 9:24 PM, Daniel Barkalow <barkalow@iabervon.o=
rg> wrote:
>> On Wed, 25 Mar 2009, John Tapsell wrote:
>>
>>> 2009/3/24 Daniel Barkalow <barkalow@iabervon.org>:
>>> > On Tue, 24 Mar 2009, John Tapsell wrote:
>>> >
>>> >> 2009/3/24 Irene Ros <imirene@gmail.com>:
>>> >> > Hi all,
>>> >> >
>>> >> > I've been using git for some time now and haven't run into thi=
s issue
>>> >> > before, perhaps someone else here has:
>>> >> >
>>> >> > I have a branch that is ahead of its origin by a few commits:
>>> >> >
>>> >> > $ git status
>>> >> > # On branch myBranch
>>> >> > # Your branch is ahead of 'origin/myBranch' by 10 commits.
>>> >>
>>> >> Tried running: git fetch =C2=A0 ?
>>> >>
>>> >> For some weird reason =C2=A0"git push origin mybranch" =C2=A0doe=
sn't actually
>>> >> update origin/mybranch. =C2=A0It's more annoying :-)
>>> >
>>> > It should, so long as you're using the native transport and
>>> > origin/mybranch actually tracks mybranch on origin.
>>> >
>>> > "git push" doesn't update it, but the code that implements the na=
tive
>>> > transport does update it if it succeeds.
>>> >
>>> > (Actually, I'm not 100% sure that, if you update origin through s=
ome other
>>> > channel with exactly the commit that you now have in mybranch loc=
ally, and
>>> > then try the push, it will update the local tracking for that bra=
nch; is
>>> > that what you've hit?)
>>>
>>> I update via http - maybe that's why? =C2=A0origin/mybranch is neve=
r
>>> updated when I push. =C2=A0It's not just a once-off quirk.
>>
>> Yup, http doesn't have it. One of my series currently in next moves =
it
>> from the git-specific protocol to the common code, but there's still=
 work
>> to be done to allow the http push transport to report back to the co=
mmon
>> code what got updated successfully, which is largely a matter of mak=
ing
>> the http-push code run in-process instead of as a command run by
>> transport.c, and using the just-added API.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0-Daniel
>> *This .sig left intentionally blank*
>
