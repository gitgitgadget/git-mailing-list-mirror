From: demerphq <demerphq@gmail.com>
Subject: Re: git strangeness
Date: Mon, 23 Aug 2010 22:19:01 +0200
Message-ID: <AANLkTimWFAdTtaUKtHB87hQDtXvzDSDnVR7vuthVc4x8@mail.gmail.com>
References: <AANLkTikrJ+hizEicws8PZAry-WOzOYoXAEW9b1L8OYcR@mail.gmail.com>
	<AANLkTim27gLuAwxrNZFmayufF3ctKDU5vmUSN4v4bQPY@mail.gmail.com>
	<AANLkTi=JQ0rAYmAz=uJc5riZC+UwxhEvsXCvzQ6310O8@mail.gmail.com>
	<AANLkTinwK0R4BGUn_ehBOvO7HrwUZZ6Va3okoiu=eu7P@mail.gmail.com>
	<AANLkTina6iVO4Ekv1gVOoBFTV3t1F55sqEkwvf-Rrm_6@mail.gmail.com>
	<AANLkTinPizD8JECut5Yc2pgzne4=QL6arcHiG8iUUcKB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Perl5 Porteros <perl5-porters@perl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 22:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OndU6-0006l8-2Y
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 22:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691Ab0HWUTE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Aug 2010 16:19:04 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:51548 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab0HWUTD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Aug 2010 16:19:03 -0400
Received: by qyk9 with SMTP id 9so3048926qyk.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=t3FlSJzXc2OXjkRAt18jqYde05iQDnj/Jnv4NkekUTA=;
        b=tZ5JwAHFMfYm6ZSQeLBgnUH+u3opWUq/OPaIzPqIJ+imcvqTwIHde9EcCa0ZJ5WbTe
         Oo7+S2IwdBlKuirxNSbA/1vR1yxixvXKwfsf6eFQEPWFj2qzqmANPODwS1nUKzqzoTM+
         JH/jwDQ3Ukj1fCXbbpYm3zCkKEQyW1wTXvoRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wzAktdUp+4O9pcU0IubWfcfC4zldnGzToOzSCWwieHi7Hc18LdZ2gFWBMPu+xWRgTg
         UAn8J5mWpptYoAUq6b1eiChfTTOaWGbeAm6V0YOSyaV9LcZG0Y27an6Z1eskjdMNqR/y
         iQc9++FeoP6Uu2oppPNM3AOW7xrV5ADjD67d0=
Received: by 10.224.10.204 with SMTP id q12mr3743269qaq.169.1282594741256;
 Mon, 23 Aug 2010 13:19:01 -0700 (PDT)
Received: by 10.229.81.83 with HTTP; Mon, 23 Aug 2010 13:19:01 -0700 (PDT)
In-Reply-To: <AANLkTinPizD8JECut5Yc2pgzne4=QL6arcHiG8iUUcKB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154252>

On 23 August 2010 22:16, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.co=
m> wrote:
> On Mon, Aug 23, 2010 at 19:58, demerphq <demerphq@gmail.com> wrote:
>> On 23 August 2010 21:43, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail=
=2Ecom> wrote:
>>> On Mon, Aug 23, 2010 at 19:33, demerphq <demerphq@gmail.com> wrote:
>>>> On 23 August 2010 19:59, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gma=
il.com> wrote:
>>>>> On Sat, Aug 21, 2010 at 11:54, demerphq <demerphq@gmail.com> wrot=
e:
>>>>>> Today I was trying to pull some updates over my wlan connection =
at the
>>>>>> hotel I'm in right now.
>>>>>>
>>>>>> For some reason it repeatedly hung. I tried using the git protoc=
ol,
>>>>>> and using ssh, each time it hung at the same point (object trans=
fer -
>>>>>> and after the same number of objects).
>>>>>>
>>>>>> Eventually I opened a tunnel, with control master enabled to cam=
el
>>>>>> (obviously not everybody can do this), and then tried to pull us=
ing
>>>>>> the established tunnel. At which point it pulled just fine - and=
 damn
>>>>>> fast.
>>>>>>
>>>>>> Anybody else experienced strangeness like this? Could we have a =
glitch
>>>>>> somewhere?
>>>>>
>>>>> It would help to clarify what the strangeness is, but obviously y=
ou
>>>>> can't debug it *now*.
>>>>>
>>>>> If you have issues like this one useful thing is to try to use th=
e
>>>>> plumbing tools to see if you can reproduce the issue. E.g. use
>>>>> git-fetch, and stuff like git-receive-pack / git-send-pack if you=
 can.
>>>>
>>>> I actually did use git-fetch. Same thing. It was weird. I had abou=
t
>>>> 1200 objects to transfer, after, i think, 345 objects it just hung=
=2E
>>>> For minutes, after which i killed it. I tried again, and it hung
>>>> again, etc, and like I said until I had opened a tunnel to camel a=
nd
>>>> switched to ssh it huing every time, with ssh as the protocol and =
with
>>>> git as the protocol.
>>>>
>>>> I actually still have the repo in unpulled form, so ill try again,
>>>> what exactly should I do to obtain better diagnostics?
>>>
>>> To start with, add the Git mailing list to the CC-list, which I've
>>> just done.
>>>
>>> I don't know what you should do exactly, but...:
>>>
>>> =A0* If you rsync the perl.git repository from camel to somewhere e=
lse
>>> =A0 and use ssh+git to *there* does it still hang? Maybe you can ma=
ke
>>> =A0 both copies of perl.git available online for others to try?
>>>
>>> =A0* How does it hang? Run it with GIT_TRACE=3D1 <your commands>, W=
hat
>>> =A0 process hangs exactly? Is it using lots of CPU or memory in top=
?
>>> =A0 How about if you strace it, is it hanging on something there?
>>>
>>> =A0* Does this all go away if you you upgrade git (e.g. build from
>>> =A0 master git.git) on either the client or server?
>>>
>>> =A0* If not, maybe run it under gdb with tracing and see where it h=
angs?
>>>
>>> ..would seem like good places to start.
>>
>> Ill try some of the above and follow up... Well, as soon as i find t=
he
>> usb stick with the unpulled repo copy. :-)
>
> Sweet, thanks.
>
>>>>>> Also, I noticed that git-web, or perhaps our config of it, has a
>>>>>> glitch when using pick-axe. It seems to die in mid processing
>>>>>> (probably a timeout) and thus returns broken XML/HTML to the bro=
wser,
>>>>>> which in turn inconveniently means that firefox shows an XML err=
or and
>>>>>> doesn't show the results that it /has/ found. Im wondering if th=
ere is
>>>>>> anything we should do about this?
>>>>>
>>>>> What were you looking at when you got the XML error? There was a
>>>>> recent report about this to the git list and it's been solved ups=
tream
>>>>> IIRC. It was a simple matter of a missing escape_binary_crap()
>>>>> somewhere.
>>>>
>>>> I was doing a pick-axe search for PERL_STRING_ROUNDUP (however it =
is
>>>> actually spelled), after about 5 minutes the connection terminated=
 and
>>>> resulted in broken output...
>>>
>>> What's the gitweb link for that? I'm not familiar with how to make =
it
>>> do a blame search.
>>
>> Select "pickaxe" in the drop down on the perl5 gitweb, and then sear=
ch
>> for PERL_STRLEN_ROUNDUP
>>
>> The url generated is:
>>
>> http://perl5.git.perl.org/perl.git?a=3Dsearch&h=3DHEAD&st=3Dpickaxe&=
s=3DPERL_STRLEN_ROUNDUP
>>
>> Currently its running for me, and obviously wed prefer that we dont
>> have N-gazillion people doing the search at once....
>>
>> Ah, it just finished... Same problem. I get the error:
>>
>> XML Parsing Error: no element found
>> Location: http://perl5.git.perl.org/perl.git?a=3Dsearch&h=3DHEAD&st=3D=
pickaxe&s=3DPERL_STRLEN_ROUNDUP
>> Line Number 81, Column 1:
>>
>> And the last couple of lines of the HTML are:
>>
>> </td>
>> <td class=3D"link"><a
>> href=3D"/perl.git/commit/7a9b70e91d2c0aa19f8cec5b0f8c133492a19280">c=
ommit</a>
>> | <a href=3D"/perl.git/tree/7a9b70e91d2c0aa19f8cec5b0f8c133492a19280=
">tree</a></td>
>> </tr>
>> <tr class=3D"light">
>>
>> seems to me like it timed out while searching....
>>
>> Makes me think the search logic would work better as an incremental
>> asynchronous fetch....
>
> Ah, sounds like it's running a really expensive operation and then
> running into the cgi time execution limit on the webserver (or maybe
> in gitweb), so when the connection closes the browser ends up with
> invalid XHTML.

Yeah, exactly, thats what i meant by "timeout".

> An async fetch would only make sense in that case if your gitweb and
> webserver timeouts made sense, i.e. the gitweb timeout was say 1-2 se=
c
> less than the webserver timeout.

Well i was thinking it could search for a single item, and then stop,
and the search again from there, etc... So each search would be
lighter weight...

> Anyway, it has nothing to do with the escaping bug I cited above.

Nod, I suspected as much.

Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
