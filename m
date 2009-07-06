From: Stefan Bucur <stefan.bucur@gmail.com>
Subject: Re: Wrong file diff for merge conflict
Date: Mon, 6 Jul 2009 17:44:56 +0300
Message-ID: <8cdebd3f0907060744l75a11160v8b01e6923cc5c70e@mail.gmail.com>
References: <loom.20090704T072854-229@post.gmane.org> <alpine.LFD.2.01.0907051113240.3210@localhost.localdomain> 
	<8cdebd3f0907051523q73494603ka8a50b19b1238a@mail.gmail.com> 
	<alpine.LFD.2.01.0907051726020.3210@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 06 16:45:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNpRg-0007DT-QR
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 16:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbZGFOpQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2009 10:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755462AbZGFOpP
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 10:45:15 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:38868 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456AbZGFOpN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2009 10:45:13 -0400
Received: by bwz25 with SMTP id 25so1330261bwz.37
        for <git@vger.kernel.org>; Mon, 06 Jul 2009 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7UCMzaRND/2qPNTq73QDwVY1tBLgW2bnTozxL79Wvk8=;
        b=vbsHgXUrF1T4uvGKtD/5RznRJE6TlQ8I7wjDEDy3K+lvOh7SOWaTxIRcPOVetoo8Sj
         Q/Xlr9Xpw8FJQL5jxmFUd9ayxco/eW7sMysU4NzF1JvYqFUhN+TNdhZP85N42eEAtmsx
         lpnskuKieX+ybv9DTRTaHMrVh9Av6SVSUNh+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=J1DFv7RseQb4xL8wb4zJhUDRfrGi5pUBNJtyeEHGFxDgzaXnwnZp3UzLdk7mHA75A0
         NijFXuCEAaPJ+hb/g5a0EoAZQi6AtEfhoWxjNsfezM3d1dp/mY+8YwzExV7zvAfy0+Vr
         9OVcfqNF6tdR7/4AwPfxdGDwST6Lz5MYOtT7M=
Received: by 10.223.120.197 with SMTP id e5mr2076440far.25.1246891516284; Mon, 
	06 Jul 2009 07:45:16 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.01.0907051726020.3210@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122790>

On Mon, Jul 6, 2009 at 3:33 AM, Linus
Torvalds<torvalds@linux-foundation.org> wrote:
[...]
>
> The fact is, a traditional rcs three-way merge (which is pretty much =
what
> you get with git, ignoring the fact that we have other tools in addit=
ion
> to it, and ignoring things like criss-cross merges etc) just doesn't =
work
> the way you seem to think it should work. You simply don't get the
> original of one side by picking one side of the conflict markers. It =
will
> have merged the stuff that it thought merged cleanly, and not have an=
y
> conflict markers at all for those parts.
>
> Of course, "what it thought merged cleanly" may not be what you want =
it to
> be. Sometimes you get a clean merge for things that you'd have wanted=
 to
> conflict. And sometimes you get conflicts for stuff that you'd think =
is
> just silly and shouldn't have.
>
> There are no perfect file merge algorithms that I know of. Lots of pe=
ople
> hate the diff3/merge behavior - it's by no means perfect. But so far,=
 I've
> never seen anybody successfully advocate anything better either.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linus
>

Indeed it seems I had a wrong image of how a conflict file should
look. In the light of what you've told me now, everything makes sense
:) Thank you very much for taking your time to explain these things!

Cheers,
Stefan Bucur
