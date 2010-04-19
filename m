From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: GSoC 2010: "Integrated Web Client for git" proposal
Date: Mon, 19 Apr 2010 23:40:33 +0530
Message-ID: <o2le72faaa81004191110t1da6c2f9i3f5f8491df7a2681@mail.gmail.com>
References: <201004150630.44300.chriscool@tuxfamily.org>
	 <201004180246.18263.jnareb@gmail.com>
	 <20100418005917.GO10939@machine.or.cz>
	 <201004180324.54722.jnareb@gmail.com>
	 <20100418021223.GP10939@machine.or.cz>
	 <n2le72faaa81004180152pb84cef2cn2a7eb95da64420b1@mail.gmail.com>
	 <20100418223120.GB3563@machine.or.cz>
	 <u2ve72faaa81004182346zdf4bd0b3m3341717b1555c0a9@mail.gmail.com>
	 <20100419115727.GB10939@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Shawn O Pearce <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, Sam Vilain <sam@vilain.net>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Apr 19 20:10:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3vQe-0000XT-Ng
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 20:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab0DSSKg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Apr 2010 14:10:36 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34838 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770Ab0DSSKf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 14:10:35 -0400
Received: by gwj19 with SMTP id 19so331460gwj.19
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/ta4a0EADHEdoR6dK6vH1JekxtTtGXD705EPd9ih/Bo=;
        b=dy6m6RVxqP79L5nctvvAjnc5Tuqy0UAqDMhp3P3oc4+DbVeLjr8PZRFAh/927+lHnr
         hICkHldAYHjJ0FmwzjbxY6vZIG38eIit2uTpGzibpTKoO2/009Mo1KuO0RRniMD96vki
         uwbZvhvErigpAcB2QVbsGnAggV9lLIhbJhoIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I8qRGiQRPfXigy5TqiNPh4ZdW9lRYvv0WRXdVXnFy76/QhE0xEZ9zmXDvqh+aVtSbr
         ktRbeaCD3xvGtqb7NIGp3mtiL76FdTKYE/2/0MszyJChYd+gX7v5Tc+x73O+PwcIWxDE
         1QQoQ/RGfBED7clQi7wWsM+A6uO2mEV2w1ptk=
Received: by 10.90.118.4 with HTTP; Mon, 19 Apr 2010 11:10:33 -0700 (PDT)
In-Reply-To: <20100419115727.GB10939@machine.or.cz>
Received: by 10.91.14.8 with SMTP id r8mr3290554agi.60.1271700633967; Mon, 19 
	Apr 2010 11:10:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145321>

Sorry for late reply, I actually skipped this mail.

2010/4/19 Petr Baudis <pasky@suse.cz>:
> On Mon, Apr 19, 2010 at 12:16:31PM +0530, Pavan Kumar Sunkara wrote:
>> On Mon, Apr 19, 2010 at 4:01 AM, Petr Baudis <pasky@suse.cz> wrote:
>> > Frankly, I'm not very excited from this. First, I recommend that y=
ou
>> > completely separate splitting of gitweb to smaller pieces (without=
 any
>> > major conceptual changes) both in the proposal and in actual
>> > submissions.
>> >
>> > Second, you should justify the introduction of session management =
and
>> > templating. What is the point and why is it neccessary for your pr=
oject
>> > goals?
>> >
>>
>> Session management reduces the length of URL and templating reduces
>> the amount of HTML in the actual code.
>
> ...which is bad?
>
> I don't see the value in session management; making the URL contain l=
ess
> information is not _good_, it is _very_ _bad_, since you can't use th=
e
> Uniform Resource Locator to locate resources anymore.
>
> Introduction of templating would mean huge changes (not only addition=
 of
> the templater) for seemingly no warranted reason. I mean, if we were =
to
> start writing gitweb from scratch, perhaps a templater engine *might*
> warrant some consideration, but I don't see any itch we want to scrat=
ch
> by introducing templating now. And no connectoin with the project at
> hand.
>
>> >> b) Write modules of the client:
>> >> =A015. Search for a part of code [git grep]
>> >
>> > This is already supported by gitweb. And it's not a "write" operat=
ion.
>> > ;-)
>>
>> I wrote it here because I would like to integrate it with content
>> history browser functionality later.

If you remember, there is a gsoc idea named "Content History Browser"
in ideas wiki page that is listed by you. It's about starting giddy
from scratch to use pickaxe interface to see the history of a specific
content. I would like to integrate this with that pickaxe interface.

> I don't understand, can you elaborate?
>
>> >> c) Read modules of the client: (most of this need not be written,=
 just
>> >> need to be organised)
>> >>
>> >> =A0 1. See the status of repository [git status]
>> >
>> > How will you integrate this with the existing 'tree' action?
>>
>> No, there will be a seperate page for it which executes git status c=
ommand.
>
> And just passes through its plaintext output? Well, I suppose that co=
uld
> do for starters.

No. It won't be just plain text. Every line will have links beside it
to either stage or unstage or add or ignore or see diff for that file.

>> > --
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Pet=
r "Pasky" Baudis
>> > http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
>> >
>>
>> Please ask me if you have any other doubts regarding this proposal.
>
> Could you clarify your attitude to the support for mode without check=
ed
> out working copy, using just the index, that we are discussing with
> Jakub and I already mentioned to you in the past?

Yes, I remember it. TO be frank, I don't know the git commands to
implement this. So, If you can explain it to me more detailedly, Then
I can implement it for sure.

> --
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Petr "=
Pasky" Baudis
> http://pasky.or.cz/ | "Ars longa, vita brevis." -- Hippocrates
>

Thanks
-pavan
