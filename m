From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Let's bump the minimum Perl version to 5.8
Date: Fri, 24 Sep 2010 19:10:04 +0000
Message-ID: <AANLkTimOpyvO+GZsKJPPWktVJTR1khLD2izyCKqNXwvA@mail.gmail.com>
References: <AANLkTikp0mkFHYCdgqThfoFr3VkVECDmW6qE3+DSSHaq@mail.gmail.com>
	<AANLkTinRcGa3r_=D87G-4-qqdsFL9CKnawD=DCnRQ+7v@mail.gmail.com>
	<AANLkTim8aPoOkzzf4c0JHbBDVa4zJY2xM3v9fXQ-px=V@mail.gmail.com>
	<4C9CAEB7.1030606@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arntsen <tor@spacetec.no>, Tait <git.git@t41t.com>,
	git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Sep 24 21:10:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzDew-0005D6-Ew
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 21:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728Ab0IXTKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 15:10:07 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33451 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab0IXTKF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 15:10:05 -0400
Received: by gxk9 with SMTP id 9so1067542gxk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3fY2GjSq6Ti0hZE/ZU4eePv4Kj3qS8DLilh88rKfrhI=;
        b=C5eN4o//6p5b8KKXjikazPeNB833Z0Wbxl9smqDPFip5T++K0AxPJtEhruexX+b+aC
         muXqdhWgb0fFdw3ZRBf1kCV3WhUVza4NR+ZbB5HaRaZqCwUUX2CQe8m2Qfo92Oetn5fJ
         wCzsmabl+/M0xSNj6oLJrkIznAfnOzQKvN7Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Gziy3v+fE7AteT1LLbVV0uvoPFpoknRYeDx0NhadJo4pOSc/Odi3uGpcGTq1ivhIPP
         fCKAoKzVqFohO3NyXcN6czU9LNx4oHYAfO/MVL4AkAYzFYp1mJ4qsjl2q5Mh1Im49glE
         aItN63l3dtZHs5EzAncX4YtilSWJqIEn2A/+Y=
Received: by 10.151.144.17 with SMTP id w17mr5073403ybn.196.1285355404464;
 Fri, 24 Sep 2010 12:10:04 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 24 Sep 2010 12:10:04 -0700 (PDT)
In-Reply-To: <4C9CAEB7.1030606@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157039>

On Fri, Sep 24, 2010 at 13:59, Andreas Ericsson <ae@op5.se> wrote:
> On 09/24/2010 03:32 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Fri, Sep 24, 2010 at 13:08, Tor Arntsen<tor@spacetec.no> =C2=A0wr=
ote:
>>> On Fri, Sep 24, 2010 at 14:56, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on<avarab@gmail.com> =C2=A0wrote:
>>>
>>>> However, I'd like to shift the discussion a bit: Do we want to sup=
port
>>>> the 5.6 line *at all* anymore? I don't think so. As you point out
>>>> yourself you can just compile 5.8 or later on these machines.
>>>
>>> 5.8 as minimum is probably for the best. It's not that just you can
>>> compile a newer version (5.8), more importantly, Perl 5.8 is availa=
ble
>>> as a package from those semi-official 3party repositories for most
>>> systems (at least the *nix systems I have access to)
>>
>> Do those repositories also have 5.10 and 5.12?
>>
>
> Fedora 13 ships with Perl 5.10.0. IIRC, Fedora 12 (or possibly 11)
> shipped with Perl 5.8. Let's not ask for more angry users than we
> can handle. Since the current code seems to work fine with 5.8 and
> later, I think that's a safe minimum to require for full git
> functionality.

I didn't mean to suggest we bump to 5.10 now. I just thought I'd ask
for the record in case we have this discussion again 3-4 years from
now.

> Especially considering it was 3 years since we decided on 5.6, which
> was by then 7 years old.

Do you happen to have a link to that discussion? I can't find it.
