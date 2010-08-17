From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: Lost in Space
Date: Tue, 17 Aug 2010 19:42:06 -0300
Message-ID: <AANLkTimqfCAy6N2w_DPvu5KBe6_8L2zrS91R43LP53J4@mail.gmail.com>
References: <AANLkTikiVQCMKjftWfrKbK-K+Gv45CTunxjULGc1==Zb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@suse.cz>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 00:42:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlUra-0001L5-9t
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 00:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479Ab0HQWm2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 18:42:28 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46646 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab0HQWm1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 18:42:27 -0400
Received: by gwj17 with SMTP id 17so1835085gwj.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 15:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bjaiHp6JMXYPMk2oHLv+SMxOl3+NNtVWYPN5L2PgPYY=;
        b=oZWV5+bBqnZ/9RTbxLxeQDpgNAWXwxW15Os+Ta6lcUOwDjtF4aJezJR8NkBXRLa5iR
         aBCmdeZZWQIbfVccUMgLbODITFYyDX0qHYAYCoJOpLemcLo3TyUnEHaexyZtetGes26E
         82zdVKC2n2XZwD1cH7GiFAEGJOurAJZ+6h7wE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hwnJaCcH3gWpV84pS718heZWngmM3tcijZ42kMWrr4ah/f5BO3nIGggWOsOANqHMYC
         m+HFMaS3VCSeCdNBeKuZnsrPcJKVBU1Y1IkAqk542l9IqEt+ijHOlyjbpBLY0oGBoAAB
         dE9rTATX2MlVPc9XRwxUZN5l0QTWsV6lzPoBc=
Received: by 10.231.157.195 with SMTP id c3mr8210939ibx.155.1282084946225;
 Tue, 17 Aug 2010 15:42:26 -0700 (PDT)
Received: by 10.231.130.210 with HTTP; Tue, 17 Aug 2010 15:42:06 -0700 (PDT)
In-Reply-To: <AANLkTikiVQCMKjftWfrKbK-K+Gv45CTunxjULGc1==Zb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153784>

Hi,

2010/8/7 Jonathan Nieder <jrnieder@gmail.com>
>
> When searching commits for a string that never occurs, the results
> page looks something like this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0projects / foo.git / search =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \o/
> =C2=A0 =C2=A0 =C2=A0 =C2=A0summary | ... | tree =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0[commit] search: [ kfjdkas ] [ ]re
> =C2=A0 =C2=A0 =C2=A0 =C2=A0first =E2=8B=85 prev =E2=8B=85 next
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Merge branch 'maint'
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Foo: a demonstration project
>
> Without a list of hits to compare it to, the header describing the
> commit named by the hash parameter (usually HEAD) may itself look
> like a hit. =C2=A0Add some text (=E2=80=9CNo match.=E2=80=9D) to repl=
ace the empty
> list of hits and avoid this confusion.
>
> While at it, remove some nearby dead code, left behind from a
> simplification a few years ago (v1.5.4-rc0~276^2~4, 2007-11-01).
>
> Noticed-by: Erick Mattos <erick.mattos@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Acked-by: Jakub Narebski <jnareb@gmail.com>
> ---
> changes relative to v2[1]:
> =C2=A0- better newline placement in the produced HTML.
>
> Erick Mattos wrote:
>
> > What's up to:
> >
> > http://thread.gmane.org/gmane.comp.version-control.git/151402/focus=
=3D151414
>
> Hopefully third time=E2=80=99s the charm. =C2=A0Test reports welcome =
as always.

Nice to see this one in not ignored anymore!

But what about http://thread.gmane.org/gmane.comp.version-control.git/1=
51440/
 ?!?

I am personally not bothered by being ignored but ignoring the fact
that without this little patch there is a test which is testing
nothing and a necessary check which is not being tested is certainly
not good at all.

Two lines can not be so hard to be accepted without a huge hammer and
so much unpleasant yelling!

Please let's close this issue.

Regards to all
