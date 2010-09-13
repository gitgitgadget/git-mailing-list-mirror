From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] Add Swedish translation.
Date: Mon, 13 Sep 2010 15:45:01 +0000
Message-ID: <AANLkTikRGhcHOfR3hioz_oNOs+Yu0nGvGWq22iRws3Ed@mail.gmail.com>
References: <20100912202111.B11522FC00@perkele>
	<AANLkTikg1vD33f6Rj4UEzsbrUemta6NbRWWH22h2Y0-B@mail.gmail.com>
	<alpine.DEB.2.00.1009130810580.31516@ds9.cixit.se>
	<AANLkTinhmBHQzkdEY88Oa-XsZQ4VAUz0Tci+gOt=fXmE@mail.gmail.com>
	<alpine.DEB.2.00.1009131437310.16248@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Sep 13 17:45:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvBDT-0001RQ-Rq
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 17:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab0IMPpE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 11:45:04 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:61410 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611Ab0IMPpC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 11:45:02 -0400
Received: by pxi10 with SMTP id 10so2185476pxi.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 08:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RQ3GIHF+7PkrxJ1hab3F3WBrja+czuCnIjOZp4KRz8U=;
        b=CmJre24Ec3To4c9dliFiP6DG5e2tbS7nIuLMIQ9td/VfwZvaL9tPFGEhvhRR1K6o8i
         +CcImfHi2KhnDuv6eVLfSa8+2UzOq7JLLtvWr+RXiKhB++ZFkiq5iMwFwcnRtCDFLkaJ
         OBNOdsIk4xtl8sDCsD9MRyG5TjDvFkDydtYWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xDiubDXIEKR1THsMYvLi9ww3LpMVBM71wvG/lWBCQeOggY5hZzhpg+Yw2K+g7hBoFv
         xalQg6Fyp6GxyVA3TMF3o5wM4h7zh5INTkgp35zHZA+a9l9mTD8yFpNcgJsgY9zEmjdH
         gCuGue/fDHaLAoW1IE8sz+TM3zfOi+jU5W3E0=
Received: by 10.142.252.17 with SMTP id z17mr55093wfh.143.1284392701658; Mon,
 13 Sep 2010 08:45:01 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 13 Sep 2010 08:45:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1009131437310.16248@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156099>

On Mon, Sep 13, 2010 at 13:45, Peter Krefting <peter@softwolves.pp.se> =
wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
>> What commands did you use? I different things on GNU gettext 0.18.1
>> using the commands documented in po/README, e.g.:
>
> I have 0.17, so there may be changes since then.
>
>> =C2=A0 @@ -12,0 +13 @@ msgstr ""
>> =C2=A0 +"Language: sv\n"
>
> gtranslator (at least in the version I'm using) kills that line for m=
e.
>
>> =C2=A0 @@ -16 +17 @@ msgstr ""
>> =C2=A0 -"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);"
>> =C2=A0 +"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
>
> another gtranslator oddity (it removes the trailing \n). That one doe=
sn't
> matter, though.
>
>> And the line wrapping is different after a msgmerge:
>
> I didn't run msgmerge on the output from gtranslator. If I do that, I=
 get
> your wrapped version.

I see. Emacs's po-mode is maintained as part of gettext.git, so they
probably make sure it has the same line wrapping rules, while
gtranslator uses something different.

>> Having comments before the <msgstr ""> also means it can't be update=
d with
>> the example snippet in po/README.
>
> Huh? I've never had problems with that in any project I work on. And =
some of
> the editors (notably KBabel) even inserts these comments by itself.

I just mean that if we start doing that I'd have to update the na=C3=AF=
ve
munger in po/README's "Initializing a .po file" section. It's not a
problem for the format itself.

Anyway, we might want to have these to be consistent with the rest of
git, which usually adds copyright comments at the top.

>> But redundant to `git log sv.po | grep ^Date | head -n1`.
>
> No. That gives you when the translation was *committed*, not when the=
 string
> set it used as a base for translation was created.

True, but the PO Date header doesn't tell you what commit the
translation is based on, just when the translator did msginit. So it's
not very useful either.

The best indicator in any case of what needs to be updated is msgmerge
on git.git HEAD.

>> And since it's autogenerated it'll cause merge conflicts across diff=
erent
>> git branches eventually.
>
> PO files don't merge properly between branches anyway (one might be a=
ble to
> set up a custom merge driver that runs msgmerge between the files, bu=
t I've
> never been able to get that to work), so they are best avoided. Gener=
ally,
> you only want to update PO files on the mainline version(s), and igno=
re them
> on merge.

Yeah, but they'll merge a lot easier if we don't have autogenerated
comments in them, and the patch churn will be a lot smaller and more
readable.

I don't think there's any significant advantage to keeping these
comments *in git.git*. At least I can't see a difference when doing
msgmerge, or some feature we miss from reading the gettext manual.

Of course they're very useful for editing, but that's easily handled
by some make target.

>> Ditto redundant to `git log sv.po | grep ^Author`. =C2=A0.
>
> No Language-Team. But, sure. You would have to delete them every time=
 since
> any sane PO file editor will add them back automatically on each edit=
=2E

Hopefully they'll apply my patch so po-mode.el will stop doing that:
https://savannah.gnu.org/bugs/?30835

>> Yes they're useful while translating. But as documented in po/README=
's
>> "Updating a .po file" you can use them while doing that without subm=
itting
>> them to git.git.
>
> Sure. But then again you would have to remember to delete them manual=
ly.
> Everything that requires an extra step of manual commands will make t=
he
> hurdle to create translations higher.

If we keep these limited header and no comment policies I'll probably
just in the future create some script to rewrite the incoming *.po
file, drop it in po/util/* and rewrite submitted PO files without
bothering translators.

>> It's not using the "<subsystem>: <message> <no-full-stop>"
>> convention. All the existing commits in ab/i18n use that convention,
>> and I'd prefer to keep it that way.
>
> Well, I don't really care either way.

I'll just --amend it :)

> Expect an updated version after I go through the review comments I go=
t (I've
> also posted the translation to the TP-SV list for review there).

Yippie. Looking forward to it. And thanks again for translating Git.

The reason I nitpicked your commit was that po/README and interactions
with translators are something we're still working out. So maybe we
want to completely change how we do it.

Threads like these will hopefully help us to arrive at some sane
policy.
