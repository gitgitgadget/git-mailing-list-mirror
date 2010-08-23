From: demerphq <demerphq@gmail.com>
Subject: Re: git strangeness
Date: Mon, 23 Aug 2010 21:58:45 +0200
Message-ID: <AANLkTina6iVO4Ekv1gVOoBFTV3t1F55sqEkwvf-Rrm_6@mail.gmail.com>
References: <AANLkTikrJ+hizEicws8PZAry-WOzOYoXAEW9b1L8OYcR@mail.gmail.com>
	<AANLkTim27gLuAwxrNZFmayufF3ctKDU5vmUSN4v4bQPY@mail.gmail.com>
	<AANLkTi=JQ0rAYmAz=uJc5riZC+UwxhEvsXCvzQ6310O8@mail.gmail.com>
	<AANLkTinwK0R4BGUn_ehBOvO7HrwUZZ6Va3okoiu=eu7P@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Perl5 Porteros <perl5-porters@perl.org>, Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: perl5-porters-return-163305-gclppp-perl5-porters=m.gmane.org@perl.org Mon Aug 23 21:58:58 2010
Return-path: <perl5-porters-return-163305-gclppp-perl5-porters=m.gmane.org@perl.org>
Envelope-to: gclppp-perl5-porters@lo.gmane.org
Received: from x6.develooper.com ([207.171.7.86] helo=lists-nntp.develooper.com)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <perl5-porters-return-163305-gclppp-perl5-porters=m.gmane.org@perl.org>)
	id 1OndAX-00053V-L9
	for gclppp-perl5-porters@lo.gmane.org; Mon, 23 Aug 2010 21:58:58 +0200
Received: (qmail 10783 invoked by uid 514); 23 Aug 2010 19:58:52 -0000
Mailing-List: contact perl5-porters-help@perl.org; run by ezmlm
Precedence: bulk
list-help: <mailto:perl5-porters-help@perl.org>
list-unsubscribe: <mailto:perl5-porters-unsubscribe@perl.org>
list-post: <mailto:perl5-porters@perl.org>
X-List-Archive: <http://nntp.perl.org/group/perl.perl5.porters/163305>
List-Id: <perl5-porters.perl.org>
Delivered-To: mailing list perl5-porters@perl.org
Received: (qmail 10771 invoked from network); 23 Aug 2010 19:58:52 -0000
Delivered-To: perl5-porters@perl.org
X-Spam-Status: No, hits=-0.1 required=8.0
	tests=DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS
X-Spam-Check-By: la.mx.develooper.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yZjKQTLcO4ZUYXJl2VH+47N1klLFk2gfiQyJAAYuRtc=;
        b=rERO+TtqTSkYOH1PMYLpoZHWBjaQBGZ124b5mMQlPyNaJh48kn+hRLddv57TMayqMl
         xXHENSrS+wUU/oCqd1CM+5NcSk7J3i4/7S4tL+JYbPw54xr+ncYCX9zsqV98N154kD0i
         YJtG/1uCG2QvWHoJcjBW5fvZMvvEoRJRg/HWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lob/oSGJmIjjoVvdbXbuhS83jE2rlJ/Dbz4I9depy0Zdj4COKYTY7eQM4A4R2WDQfD
         7OLiaRbY/I8gm9RYIWPy2ZM5McoEdtlCUuLT0cu7O/JDj1p3h+p3dXMI7rqfKRT2qifZ
         bJx1s7IXF2rlWB5j9MotGMryh7aPrIxKK8kM8=
In-Reply-To: <AANLkTinwK0R4BGUn_ehBOvO7HrwUZZ6Va3okoiu=eu7P@mail.gmail.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154249>

On 23 August 2010 21:43, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> w=
rote:
> On Mon, Aug 23, 2010 at 19:33, demerphq <demerphq@gmail.com> wrote:
>> On 23 August 2010 19:59, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com=
> wrote:
>>> On Sat, Aug 21, 2010 at 11:54, demerphq <demerphq@gmail.com> wrote:
>>>> Today I was trying to pull some updates over my wlan connection at the
>>>> hotel I'm in right now.
>>>>
>>>> For some reason it repeatedly hung. I tried using the git protocol,
>>>> and using ssh, each time it hung at the same point (object transfer -
>>>> and after the same number of objects).
>>>>
>>>> Eventually I opened a tunnel, with control master enabled to camel
>>>> (obviously not everybody can do this), and then tried to pull using
>>>> the established tunnel. At which point it pulled just fine - and damn
>>>> fast.
>>>>
>>>> Anybody else experienced strangeness like this? Could we have a glitch
>>>> somewhere?
>>>
>>> It would help to clarify what the strangeness is, but obviously you
>>> can't debug it *now*.
>>>
>>> If you have issues like this one useful thing is to try to use the
>>> plumbing tools to see if you can reproduce the issue. E.g. use
>>> git-fetch, and stuff like git-receive-pack / git-send-pack if you can.
>>
>> I actually did use git-fetch. Same thing. It was weird. I had about
>> 1200 objects to transfer, after, i think, 345 objects it just hung.
>> For minutes, after which i killed it. I tried again, and it hung
>> again, etc, and like I said until I had opened a tunnel to camel and
>> switched to ssh it huing every time, with ssh as the protocol and with
>> git as the protocol.
>>
>> I actually still have the repo in unpulled form, so ill try again,
>> what exactly should I do to obtain better diagnostics?
>
> To start with, add the Git mailing list to the CC-list, which I've
> just done.
>
> I don't know what you should do exactly, but...:
>
> =A0* If you rsync the perl.git repository from camel to somewhere else
> =A0 and use ssh+git to *there* does it still hang? Maybe you can make
> =A0 both copies of perl.git available online for others to try?
>
> =A0* How does it hang? Run it with GIT_TRACE=3D1 <your commands>, What
> =A0 process hangs exactly? Is it using lots of CPU or memory in top?
> =A0 How about if you strace it, is it hanging on something there?
>
> =A0* Does this all go away if you you upgrade git (e.g. build from
> =A0 master git.git) on either the client or server?
>
> =A0* If not, maybe run it under gdb with tracing and see where it hangs?
>
> ..would seem like good places to start.

Ill try some of the above and follow up... Well, as soon as i find the
usb stick with the unpulled repo copy. :-)

>>>> Also, I noticed that git-web, or perhaps our config of it, has a
>>>> glitch when using pick-axe. It seems to die in mid processing
>>>> (probably a timeout) and thus returns broken XML/HTML to the browser,
>>>> which in turn inconveniently means that firefox shows an XML error and
>>>> doesn't show the results that it /has/ found. Im wondering if there is
>>>> anything we should do about this?
>>>
>>> What were you looking at when you got the XML error? There was a
>>> recent report about this to the git list and it's been solved upstream
>>> IIRC. It was a simple matter of a missing escape_binary_crap()
>>> somewhere.
>>
>> I was doing a pick-axe search for PERL_STRING_ROUNDUP (however it is
>> actually spelled), after about 5 minutes the connection terminated and
>> resulted in broken output...
>
> What's the gitweb link for that? I'm not familiar with how to make it
> do a blame search.

Select "pickaxe" in the drop down on the perl5 gitweb, and then search
for PERL_STRLEN_ROUNDUP

The url generated is:

http://perl5.git.perl.org/perl.git?a=3Dsearch&h=3DHEAD&st=3Dpickaxe&s=3DPER=
L_STRLEN_ROUNDUP

Currently its running for me, and obviously wed prefer that we dont
have N-gazillion people doing the search at once....

Ah, it just finished... Same problem. I get the error:

XML Parsing Error: no element found
Location: http://perl5.git.perl.org/perl.git?a=3Dsearch&h=3DHEAD&st=3Dpicka=
xe&s=3DPERL_STRLEN_ROUNDUP
Line Number 81, Column 1:

And the last couple of lines of the HTML are:

</td>
<td class=3D"link"><a
href=3D"/perl.git/commit/7a9b70e91d2c0aa19f8cec5b0f8c133492a19280">commit</=
a>
| <a href=3D"/perl.git/tree/7a9b70e91d2c0aa19f8cec5b0f8c133492a19280">tree<=
/a></td>
</tr>
<tr class=3D"light">

seems to me like it timed out while searching....

Makes me think the search logic would work better as an incremental
asynchronous fetch....

Yves
--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
