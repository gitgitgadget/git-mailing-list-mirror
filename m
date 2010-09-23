From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC PATCH] sit-send-email.pl: Add --to-cmd
Date: Thu, 23 Sep 2010 17:50:05 +0000
Message-ID: <AANLkTinCx=+n6bMZw4tQqrQ7WC1o_aeGG_n_PxywTyb8@mail.gmail.com>
References: <AANLkTinsM5jdU194FR8L3hTvBXk0Tr_oV2E5752NOUpq@mail.gmail.com>
	<AANLkTikkJNwF4LS9rx5=bHM2R0Pm751Y1u9V8iAt0w1A@mail.gmail.com>
	<1285227413.7286.47.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231054230.15528@ask.diku.dk>
	<20100923090931.GA29789@albatros>
	<20100923120024.GA26715@albatros>
	<1285253867.31572.13.camel@Joe-Laptop>
	<Pine.LNX.4.64.1009231757090.11585@ask.diku.dk>
	<1285262237.31572.18.camel@Joe-Laptop>
	<AANLkTin_Y8w4ujNGTqGJPNDNfYz7hcjBVLcOG0emBjYn@mail.gmail.com>
	<1285263993.31572.25.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Julia Lawall <julia@diku.dk>, git <git@vger.kernel.org>,
	Vasiliy Kulikov <segooon@gmail.com>,
	matt mooney <mfmooney@gmail.com>,
	kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Thu Sep 23 19:50:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oypw0-0004A9-KO
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 19:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755887Ab0IWRuI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 13:50:08 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53620 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab0IWRuG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 13:50:06 -0400
Received: by iwn5 with SMTP id 5so1620171iwn.19
        for <multiple recipients>; Thu, 23 Sep 2010 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XQtgyscrBTs2HfsXPpP44z6MqTZyFtOxWqDMKQt81GI=;
        b=oe1nfPIFke8DbeclFEG0AJoD8kPLu7PTJTzivfkCrIhTMBSIkOmGUnw/MySMmvUqmk
         1qO4ETmv/eABv03xrNy16i77WieY7S0DpYiqkfaFNL2/Zdb27Aa/8Mbr9jch4rjDivVQ
         y2nzIv1xJnCCUYrWMrvNQcw7MLud0Y/daxz28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F7+8S1AUkiIX9PUOnr6q0YeKy1cqYT9ihUGqlvP5tphHL8gUYbGvspAOWZ+FyPVS1z
         xUK1bW21wT//n5A3Zu+mER75MK7akDpKk/JJZmhYW/O42Fy/P7ICxCpwTymqeVc3Zovo
         Igt4VgQPsA7iYeQYS8PBlx9mA4/8S63J/kkEo=
Received: by 10.231.162.2 with SMTP id t2mr2348852ibx.57.1285264205066; Thu,
 23 Sep 2010 10:50:05 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 23 Sep 2010 10:50:05 -0700 (PDT)
In-Reply-To: <1285263993.31572.25.camel@Joe-Laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156890>

On Thu, Sep 23, 2010 at 17:46, Joe Perches <joe@perches.com> wrote:
> On Thu, 2010-09-23 at 17:29 +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarm=
ason wrote:
>> On Thu, Sep 23, 2010 at 17:17, Joe Perches <joe@perches.com> wrote:
>> > I know there's a test harness in git, but
>> > I don't know how to wire up the new options.
>> You'd add the tests to t9001-send-email.sh and --tocmd out to some
>> program you create. Is there anything in particular you need help
>> with?
>
> Just the doing. =C2=A0I was (am) being lazy.
>
>> > -if (!@to) {
>> > +if (!@to && $to_cmd eq "") {
>>
>> Why compare $to_cmd to "" instead of checking definedness?
>
> No real reason. =C2=A0Using define is the style used in the rest of
> the file and it should be changed.
>
>> > @@ -1238,6 +1242,23 @@ foreach my $t (@files) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0close F;
>> >
>> > + =C2=A0 =C2=A0 =C2=A0 if (defined $to_cmd) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 open(F, "$to_cm=
d \Q$t\E |")
>>
>> quotemeta() is for escaping regexes, not shell syntax. You probably
>> want IPC::Open2 or PC::Open3's functions which'll escape arguments f=
or
>> you.
>
> I just copied the style from the equivalent cc_cmd section below,
> so if it's necessary, it should be changed there too.
>
>> I.e. do you need to strip whitespace from the beginning of the strin=
g?
>
> I think so.

This all sounds reasonable, but I really need to go through
git-send-email.perl and fix all these bugs at some point...
