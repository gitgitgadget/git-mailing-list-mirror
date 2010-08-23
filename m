From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git strangeness
Date: Mon, 23 Aug 2010 20:16:09 +0000
Message-ID: <AANLkTinPizD8JECut5Yc2pgzne4=QL6arcHiG8iUUcKB@mail.gmail.com>
References: <AANLkTikrJ+hizEicws8PZAry-WOzOYoXAEW9b1L8OYcR@mail.gmail.com>
	<AANLkTim27gLuAwxrNZFmayufF3ctKDU5vmUSN4v4bQPY@mail.gmail.com>
	<AANLkTi=JQ0rAYmAz=uJc5riZC+UwxhEvsXCvzQ6310O8@mail.gmail.com>
	<AANLkTinwK0R4BGUn_ehBOvO7HrwUZZ6Va3okoiu=eu7P@mail.gmail.com>
	<AANLkTina6iVO4Ekv1gVOoBFTV3t1F55sqEkwvf-Rrm_6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Perl5 Porteros <perl5-porters@perl.org>, Git Mailing List <git@vger.kernel.org>, 
	Jonathan Nieder <jrnieder@gmail.com>
To: demerphq <demerphq@gmail.com>
X-From: perl5-porters-return-163307-gclppp-perl5-porters=m.gmane.org@perl.org Mon Aug 23 22:16:30 2010
Return-path: <perl5-porters-return-163307-gclppp-perl5-porters=m.gmane.org@perl.org>
Envelope-to: gclppp-perl5-porters@lo.gmane.org
Received: from x6.develooper.com ([207.171.7.86] helo=lists-nntp.develooper.com)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <perl5-porters-return-163307-gclppp-perl5-porters=m.gmane.org@perl.org>)
	id 1OndRS-0004RS-QW
	for gclppp-perl5-porters@lo.gmane.org; Mon, 23 Aug 2010 22:16:27 +0200
Received: (qmail 19838 invoked by uid 514); 23 Aug 2010 20:16:21 -0000
Mailing-List: contact perl5-porters-help@perl.org; run by ezmlm
Precedence: bulk
list-help: <mailto:perl5-porters-help@perl.org>
list-unsubscribe: <mailto:perl5-porters-unsubscribe@perl.org>
list-post: <mailto:perl5-porters@perl.org>
X-List-Archive: <http://nntp.perl.org/group/perl.perl5.porters/163307>
List-Id: <perl5-porters.perl.org>
Delivered-To: mailing list perl5-porters@perl.org
Received: (qmail 19822 invoked from network); 23 Aug 2010 20:16:20 -0000
Delivered-To: perl5-porters@perl.org
X-Spam-Status: No, hits=-0.1 required=8.0
	tests=DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS
X-Spam-Check-By: la.mx.develooper.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bV0MpuFoz3TR5QRuR8J8Pc3j5X+FYezJG33gDLbEpIA=;
        b=CoeVdzS8+knwf4GQUzCxTbhx3vHNvzn4u44CjGVJ/e4uFMJs5sE67ZzsaGnwFDSvFD
         7+OkOmscRx0ICWaFR1hP4/kjgxQJVDU+GyiJukENx317CA1seOrkIQTL9zehgSPy+7h0
         +hoCL1MOwAqdaXcQeQijqhMG89M0MJmYWPIbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IVPyRAlEeOPrXjAiPxzAeCdlGpz/++LoUgkqadQaQ+4VDKFMBGyPiX8WmFjq000xgt
         ybw+zpiyl3MAvwSjUxrt5PhG2fIxY2S1eOYXkRiReT9vR9rVLnhWe4cSdbfAGYDf5rNs
         h2wOWMEj5HV6KXCqbxBnG3Hq9+7mcmGEOcvto=
In-Reply-To: <AANLkTina6iVO4Ekv1gVOoBFTV3t1F55sqEkwvf-Rrm_6@mail.gmail.com>
X-Virus-Checked: Checked
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154251>

On Mon, Aug 23, 2010 at 19:58, demerphq <demerphq@gmail.com> wrote:
> On 23 August 2010 21:43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>> On Mon, Aug 23, 2010 at 19:33, demerphq <demerphq@gmail.com> wrote:
>>> On 23 August 2010 19:59, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>>>> On Sat, Aug 21, 2010 at 11:54, demerphq <demerphq@gmail.com> wrote:
>>>>> Today I was trying to pull some updates over my wlan connection at th=
e
>>>>> hotel I'm in right now.
>>>>>
>>>>> For some reason it repeatedly hung. I tried using the git protocol,
>>>>> and using ssh, each time it hung at the same point (object transfer -
>>>>> and after the same number of objects).
>>>>>
>>>>> Eventually I opened a tunnel, with control master enabled to camel
>>>>> (obviously not everybody can do this), and then tried to pull using
>>>>> the established tunnel. At which point it pulled just fine - and damn
>>>>> fast.
>>>>>
>>>>> Anybody else experienced strangeness like this? Could we have a glitc=
h
>>>>> somewhere?
>>>>
>>>> It would help to clarify what the strangeness is, but obviously you
>>>> can't debug it *now*.
>>>>
>>>> If you have issues like this one useful thing is to try to use the
>>>> plumbing tools to see if you can reproduce the issue. E.g. use
>>>> git-fetch, and stuff like git-receive-pack / git-send-pack if you can.
>>>
>>> I actually did use git-fetch. Same thing. It was weird. I had about
>>> 1200 objects to transfer, after, i think, 345 objects it just hung.
>>> For minutes, after which i killed it. I tried again, and it hung
>>> again, etc, and like I said until I had opened a tunnel to camel and
>>> switched to ssh it huing every time, with ssh as the protocol and with
>>> git as the protocol.
>>>
>>> I actually still have the repo in unpulled form, so ill try again,
>>> what exactly should I do to obtain better diagnostics?
>>
>> To start with, add the Git mailing list to the CC-list, which I've
>> just done.
>>
>> I don't know what you should do exactly, but...:
>>
>> =C2=A0* If you rsync the perl.git repository from camel to somewhere els=
e
>> =C2=A0 and use ssh+git to *there* does it still hang? Maybe you can make
>> =C2=A0 both copies of perl.git available online for others to try?
>>
>> =C2=A0* How does it hang? Run it with GIT_TRACE=3D1 <your commands>, Wha=
t
>> =C2=A0 process hangs exactly? Is it using lots of CPU or memory in top?
>> =C2=A0 How about if you strace it, is it hanging on something there?
>>
>> =C2=A0* Does this all go away if you you upgrade git (e.g. build from
>> =C2=A0 master git.git) on either the client or server?
>>
>> =C2=A0* If not, maybe run it under gdb with tracing and see where it han=
gs?
>>
>> ..would seem like good places to start.
>
> Ill try some of the above and follow up... Well, as soon as i find the
> usb stick with the unpulled repo copy. :-)

Sweet, thanks.

>>>>> Also, I noticed that git-web, or perhaps our config of it, has a
>>>>> glitch when using pick-axe. It seems to die in mid processing
>>>>> (probably a timeout) and thus returns broken XML/HTML to the browser,
>>>>> which in turn inconveniently means that firefox shows an XML error an=
d
>>>>> doesn't show the results that it /has/ found. Im wondering if there i=
s
>>>>> anything we should do about this?
>>>>
>>>> What were you looking at when you got the XML error? There was a
>>>> recent report about this to the git list and it's been solved upstream
>>>> IIRC. It was a simple matter of a missing escape_binary_crap()
>>>> somewhere.
>>>
>>> I was doing a pick-axe search for PERL_STRING_ROUNDUP (however it is
>>> actually spelled), after about 5 minutes the connection terminated and
>>> resulted in broken output...
>>
>> What's the gitweb link for that? I'm not familiar with how to make it
>> do a blame search.
>
> Select "pickaxe" in the drop down on the perl5 gitweb, and then search
> for PERL_STRLEN_ROUNDUP
>
> The url generated is:
>
> http://perl5.git.perl.org/perl.git?a=3Dsearch&h=3DHEAD&st=3Dpickaxe&s=3DP=
ERL_STRLEN_ROUNDUP
>
> Currently its running for me, and obviously wed prefer that we dont
> have N-gazillion people doing the search at once....
>
> Ah, it just finished... Same problem. I get the error:
>
> XML Parsing Error: no element found
> Location: http://perl5.git.perl.org/perl.git?a=3Dsearch&h=3DHEAD&st=3Dpic=
kaxe&s=3DPERL_STRLEN_ROUNDUP
> Line Number 81, Column 1:
>
> And the last couple of lines of the HTML are:
>
> </td>
> <td class=3D"link"><a
> href=3D"/perl.git/commit/7a9b70e91d2c0aa19f8cec5b0f8c133492a19280">commit=
</a>
> | <a href=3D"/perl.git/tree/7a9b70e91d2c0aa19f8cec5b0f8c133492a19280">tre=
e</a></td>
> </tr>
> <tr class=3D"light">
>
> seems to me like it timed out while searching....
>
> Makes me think the search logic would work better as an incremental
> asynchronous fetch....

Ah, sounds like it's running a really expensive operation and then
running into the cgi time execution limit on the webserver (or maybe
in gitweb), so when the connection closes the browser ends up with
invalid XHTML.

An async fetch would only make sense in that case if your gitweb and
webserver timeouts made sense, i.e. the gitweb timeout was say 1-2 sec
less than the webserver timeout.

Anyway, it has nothing to do with the escaping bug I cited above.
