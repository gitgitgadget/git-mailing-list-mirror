From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] Re: user-manual: general improvements
Date: Thu, 21 May 2009 18:57:49 +0300
Message-ID: <94a0d4530905210857y51c22909ke65d643abd3e8cee@mail.gmail.com>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com>
	 <20090507072326.GA13123@vidovic>
	 <7veiv0cvdt.fsf@alter.siamese.dyndns.org>
	 <20090508042814.GA30031@vidovic>
	 <94a0d4530905131430q2250a43ei692265c3f32b5715@mail.gmail.com>
	 <20090514160609.GA12910@vidovic>
	 <7vvdnvtf2n.fsf@alter.siamese.dyndns.org>
	 <20090521041529.GD8091@sigill.intra.peff.net>
	 <94a0d4530905210017x1ce3e32bk3b1fbf9044377763@mail.gmail.com>
	 <4A155643.5030804@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu May 21 17:58:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Aed-0000yU-Lj
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 17:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbZEUP5v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2009 11:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754006AbZEUP5u
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 11:57:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:34497 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbZEUP5u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 May 2009 11:57:50 -0400
Received: by fg-out-1718.google.com with SMTP id 16so416114fgg.17
        for <git@vger.kernel.org>; Thu, 21 May 2009 08:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iOEdppEb72xWKIpObNVN08P99zvdqGjDVAkIvP18Lyg=;
        b=jvRbHfP634FTGZRO2IWeZsD5OtGcqAl3Pw0H9NJjmiRQisAFRBa3qotwWlt9KjvgvN
         PIQb2zyGC69iRzfttqo6t9rPhJCAsaDl62J/k2cVbr4LCGWmLe/p9NQRbEJ/H1tpjCnC
         /ICS1+JqSfhS98gi1APSj5tFXuqJ8f0coWyDs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=l/+e7N2jJI/sj+gzKw0WMoNxj3tys2ElW/xgyDpcAhzmNN2sejr/h0c10qOJXbv0/4
         793l4LFidafdEJZDzE6aamvMMysyrFTdttMzVDgJ41Ra9YFhdm2ikZ4YgDXywrLrhWyj
         fPnfQJJCP8R/0uve4f/G6yfXenR89Z9SyiBk0=
Received: by 10.86.57.9 with SMTP id f9mr2317633fga.33.1242921469148; Thu, 21 
	May 2009 08:57:49 -0700 (PDT)
In-Reply-To: <4A155643.5030804@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119694>

On Thu, May 21, 2009 at 4:25 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 21.05.2009 09:17:
>> On Thu, May 21, 2009 at 7:15 AM, Jeff King <peff@peff.net> wrote:
>>> On Wed, May 20, 2009 at 06:33:36PM -0700, Junio C Hamano wrote:
>>>
>>>>>> http://people.freedesktop.org/~felipec/git/user-manual-general-i=
mprovements/
>>>>>
>>>>> Thank you very much Felipe to take the time to upload the patches=
 there.
>>>>> I already have a copy there and I'll look at it soon.
>>>>
>>>> Has anybody looked at this? =C2=A0It's a bit large-ish and touches=
 all over the
>>>> place, so I am finding it a bit hard to concentrate on it myself r=
eally
>>>> nitpicking, but from the cursory look after formatting the result =
looked
>>>> Ok.
>>>
>>> I started to, but the first commit message is lacking something tha=
t I
>>> think would make reviewing much simpler: what are the general class=
es of
>>> changes that are being made?
>>>
>>> I see some doublequotes becoming backticks, and some becoming singl=
e
>>> quotes. And some becoming tex-quotes (``...''), and even some becom=
ing
>>> doublequotes _with_ single quotes. It would be easier to verify tha=
t
>>> they are doing the right thing if the commit message briefly descri=
bed
>>> the rules it followed for changing each one. I think they are somet=
hing
>>> like:
>>>
>>> =C2=A0- tex-quotes if it was really a prose-style quotation
>>>
>>> =C2=A0- backticks (causing monospace) for branch names, commands, e=
tc in
>>> =C2=A0 =C2=A0prose
>>>
>>> but that leaves me confused. Some things which I thought should be =
in
>>> monospace backticks are in single-quotes (causing emphasis). Like
>>> 'master' or 'linux-2.6'. And some things are emphasized and in doub=
le
>>> quotes in the prose, like '"o"' or '"branch A"'. What is the rule t=
o
>>> decide which text should have visible doublequotes but also be
>>> emphasized, as opposed to just having double-quotes or just being
>>> emphasized?
>>>
>>> Maybe this was even discussed earlier in the thread (I didn't go ba=
ck to
>>> look), but it should definitely be part of the commit message.
>>
>> The rule I followed is: change it to whatever looks best.
>>
>> I followed some guidelines such as: make common text monospace, such
>> as gitk and master. And emphasize whatever needs emphasizing, such a=
s
>> fb47ddb2db. Examples are both monospace *and* emphasized.
>>
>> Sometimes the end result still didn't look good so I just used
>> whatever looked best.
>
> I think that's a bit of a "quick and dirty" approach. Man pages and u=
ser
> manual should use semantic markup. The matter of "looks" is up to the
> documentation tool chain, i.e. the style sheets etc. for the various
> backends.
>
> So we would need:
>
> - a documentation "style guide" which tells you how to do the semanti=
c
> markup, such as `cmd` for commands, 'foo' for emphasis etc.
>
> - maybe some changes to the style sheets etc. which make the semantic
> markup "look good"
>
> The standard transformations which come with asciidoc/docbook can ser=
ve
> as a guide.

There's already a guide: the asciidoc user-guide... you can only go as
far as asciidoc lets you. `` for monospace, '' for emphasis, ``'' for
double quotes.

I have a problem with clear-cut rules such as: `cmd` for commands.

Do you think all these are the same?
The `git clone` command allows you to...
You can do that by doing '"git commit -a -m Example"'
Please refer to linkgit:git-add[1]

If you are reading the text you'll see that the 3 usages have different=
 intents.

>> Have you actually looked at the end result?
>>
>
> No. My attempts at doing systematic changes (rather than modifying
> single pages without a clear target) have failed, so I've been keepin=
g
> out of this business...

It's one click away:
http://people.freedesktop.org/~felipec/git/user-manual/user-manual.html

--=20
=46elipe Contreras
