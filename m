From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: html page display via cgit
Date: Wed, 1 Sep 2010 10:06:39 +0000
Message-ID: <AANLkTinjVPAOJfmiHFOe3Pci_y-KwzGr5LzDryG8oN+A@mail.gmail.com>
References: <AANLkTinJx0ZKjCtpq9k6nwigodnu42EvqchpgQtwGp5S@mail.gmail.com>
	<AANLkTik-02dJZF_0m=xccg4N5Mdaj=b2JzZaMKp=vuww@mail.gmail.com>
	<9D2F75AD-B25E-4730-82FA-E8C5F73FCE1B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shivdas Gujare <shivdas.tech@gmail.com>, git@vger.kernel.org
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 12:09:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqkGN-0000eO-6A
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 12:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767Ab0IAKGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 06:06:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37853 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab0IAKGj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 06:06:39 -0400
Received: by iwn5 with SMTP id 5so6682472iwn.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 03:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NFQRdWb0SotYyftHezMZmeWppSF0F0VRSPD0+/onNPc=;
        b=Cs8KtmKKL0GwDFaibCkayYsz3Yr4YE6/qvqI+QeIWDcbqj/AGuyBmlAuc24wym3DON
         TNocnlsfuaykq0HhuK4mOOI8k2Hpjp4G1NVWcPhZHLHTxVIR1wcyEZa6MPrfdpQoo270
         M2R4Wf+LNQHeQmQzIzygI3PWV63KIPYH1FXYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SmO4tFfaijukNTDOjVYsI+7ncIbYn1KX2bCFXVy6Ejly9XThpdo3GzX0aP6UUAs1c8
         426WHxp2coJSlS41AxW16Xe2Nu1LlW2iBvFTQszbvyTGs9L/F3c8t0S0h2rUYS37QjVX
         QWYWLHc9QWAqgZYd41FyVeZJJ9Pzxaex9dRwQ=
Received: by 10.231.79.213 with SMTP id q21mr8722306ibk.137.1283335599211;
 Wed, 01 Sep 2010 03:06:39 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Wed, 1 Sep 2010 03:06:39 -0700 (PDT)
In-Reply-To: <9D2F75AD-B25E-4730-82FA-E8C5F73FCE1B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155032>

On Wed, Sep 1, 2010 at 10:00, Joshua Juran <jjuran@gmail.com> wrote:
> On Sep 1, 2010, at 2:46 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wr=
ote:
>
>> On Wed, Sep 1, 2010 at 09:32, Shivdas Gujare <shivdas.tech@gmail.com=
>
>> wrote:
>>
>>> I hope, this is the right mailing list for cgit as well.
>>> I am trying to add some "html logs" inside cgit, but I can't open
>>> these logs via cgit inside firefox, i.e. cgit open every files in
>>> "plain" format,
>>> would like to know if it is possible to open "html" pages inside cg=
it
>>> so that if I click on html page added into git, it opens in html an=
d
>>> not in plain format.
>>>
>>> for example:
>>> if I click on "download.html" from
>>> "http://cgit.freedesktop.org/~lb/mesa/tree/docs" it shows a raw fil=
e
>>> as "http://cgit.freedesktop.org/~lb/mesa/tree/docs/download.html"
>>> and if I click on "plain" it opens in firefox like
>>> "http://cgit.freedesktop.org/~lb/mesa/plain/docs/download.html"
>>> but here I am trying to open this "download.html" inside cgit so th=
at
>>> I can view it like html web page and not as "plain" text file.
>>>
>>> Thanks for any help or pointers.
>>
>> I don't know, but that's probably deliberate. You're viewing a /plai=
n/
>> link, which should be the equivalent of "git show".
>>
>> There's also XSS security implications to serving things as text/htm=
l
>> on a shared hosting site if the main site serves cookies or otherwis=
e
>> has user logins.
>
> One solution is parse the content server-side and re-render as saniti=
zed
> HTML. =C2=A0In addition to stripping out scripts and frames, this wou=
ld avoid
> sending broken markup produced by someone else under your name, or se=
rving
> up otherwise well-formed XHTML as text/html.

Yes, but have you seen programs that try to secure arbitrary
user-supplied HTML like this? It isn't pretty, and very hard to get
right.
