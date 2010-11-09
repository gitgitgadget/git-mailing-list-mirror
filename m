From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 9 Nov 2010 23:25:24 +0100
Message-ID: <AANLkTikbA0qYKZ8BtDgKA8KXKu3d_JtUGVF9d6HFUgJC@mail.gmail.com>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org> <AANLkTi=F6768YZdR4H-vcnHgknV=roHG249dzbNRJVXR@mail.gmail.com>
 <AANLkTinwdFvR4AV9nR=9sVuMYYZHMn4C7RQ0wneX6Ys+@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 23:25:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFwdU-0001N2-Dz
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 23:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754910Ab0KIWZr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 17:25:47 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37274 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab0KIWZr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 17:25:47 -0500
Received: by fxm16 with SMTP id 16so5431855fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=cvGCtoM5EbRgXRO1jSVgZqFIyZkty06eDpwsckCPEho=;
        b=Q+7tzJ6T1GcGm17JzcQScRU3IubGYrF7xmcrCb1H0py5Rfl31rHCQR0zq2PMzUFaFb
         XA4lSWeZN3WleZJSdlzDOHOaB7vpxjOnyET5cJKLJCtG0SHlY3jyMzYAj6WxiwiRpZkU
         KYWK03aoOwaicvhMcxuIKC4sEwKVCcEAXbdMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=HJolndCeD/TKnpFO2/02yPyzroxA8APvsHfKeMBeg54eTrXkUD2uuhKpMdEB/wokIN
         7jI8ZyoZwO++0VPN4OSfqlh11QlBZ3wBlRNw5rSgI0kvjLGQuNY60fistaKOA5CJsB1j
         B6bKiTwA2hW2JJHY4r8YnmMZpvT1CLwFD6KhM=
Received: by 10.223.53.68 with SMTP id l4mr396601fag.44.1289341544921; Tue, 09
 Nov 2010 14:25:44 -0800 (PST)
Received: by 10.223.96.66 with HTTP; Tue, 9 Nov 2010 14:25:24 -0800 (PST)
In-Reply-To: <AANLkTinwdFvR4AV9nR=9sVuMYYZHMn4C7RQ0wneX6Ys+@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161104>

On Tue, Nov 9, 2010 at 11:21 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Nov 9, 2010 at 23:17, Erik Faye-Lund <kusmabite@gmail.com> wr=
ote:
>> On Tue, Nov 9, 2010 at 8:53 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> * ab/i18n (2010-10-07) 161 commits
>>> =A0- po/de.po: complete German translation
>>> =A0- po/sv.po: add Swedish translation
>>> =A0- gettextize: git-bisect bisect_next_check "You need to" message
>> <...>
>>> =A0- tests: use test_cmp instead of piping to diff(1)
>>> =A0- t7004-tag.sh: re-arrange git tag comment for clarity
>>>
>>> Will merge to 'next' to see what happens; it is getting ridiculousl=
y
>>> painful to keep re-resolving the conflicts with other topics in fli=
ght,
>>> even with the help with rerere.
>>
>> Hmmm, this is a bit more annoying IMO - this currently breaks in
>> msysgit, due to lack of gettext and NO_GETTEXT not working properly.
>> =C6var is aware of this
>> (AANLkTiny+NmXew6UxjNMO+o75=3DCxxWm9iVRMRxs0LyTJ@mail.gmail.com), bu=
t
>> haven't fixed it yet. I do have the patches needed to get a gettext =
in
>> msysgit, so it's not a very big deal to me. But are you sure that th=
is
>> makes this series ready for 'next'?
>
> I hear ya. I'm hoping to get around to fixing all this stuff before i=
t
> lands in "next".
>

Good to hear :)

> Also going to look at your gettext patches to see if there's anything
> there that needs
> to be made part of the series.
>

My "gettext-patches" are patches for msysgit (the development
environment used to build Git for Windows) to build and install
gettext. They're not patches against git.git, so I doubt they are
useful to outside of msysgit.git.
