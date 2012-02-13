From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Bulgarian translation of git
Date: Mon, 13 Feb 2012 23:43:45 +0800
Message-ID: <CANYiYbHkbUvL-d4M0iOyE5F-6rM=swk_knGEFTr9HGBK6T9UDg@mail.gmail.com>
References: <75009f1d7c4aba4d62bb226ab122932c@192.168.122.10>
	<CANYiYbGr3zN-kJwq_MCnttNZP6Cc0aj-fsZjd4V=4z+BA5TvUw@mail.gmail.com>
	<7vy5s7idxb.fsf@alter.siamese.dyndns.org>
	<20120213133957.GA4838@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	=?KOI8-R?B?QWxleGFuZGVyIFNob3BvdiAo4czFy9PBzsTf0iD7z9DP1yk=?= 
	<lists@kambanaria.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 16:43:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwy4E-00068C-W6
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 16:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935Ab2BMPnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 10:43:46 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60357 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007Ab2BMPnp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 10:43:45 -0500
Received: by ghrr11 with SMTP id r11so2386899ghr.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 07:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QPpB4vsHrrilcdyTZScqeRzAijaaFxBLSgeWPftkYks=;
        b=htEBo3izUhtd+D8/22bDmwixgS4RKXQ/rZiwgAjikVRmkEQSYRDbHQSgO8PuFSpkFA
         A2/T0lSazTRsyF1PVdtOxv6LuRYKNg6AeTsENFD9mFKkzOORHoWe+SQ8iGSwEligYMDR
         MQjK05YASoRhj3+q++WK9J68jl+95AvqRx41w=
Received: by 10.236.182.232 with SMTP id o68mr20420955yhm.58.1329147825290;
 Mon, 13 Feb 2012 07:43:45 -0800 (PST)
Received: by 10.236.153.195 with HTTP; Mon, 13 Feb 2012 07:43:45 -0800 (PST)
In-Reply-To: <20120213133957.GA4838@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190633>

2012/2/13 Jonathan Nieder <jrnieder@gmail.com>:
> I wonder if there's a simple to ask the gettext tools to make a po
> template including strings from both 'maint' and 'master'. =A0(Hackis=
h way
> demonstrated below.)
>
> Hopefully that would make it easier for translators to keep both
> tracks well maintained at the same time. =A0If a problem in the
> translation of a string shared by 'master' and 'maint' is only notice=
d
> while working on 'master', there would be no need to go through the
> "switch branches; make the change; switch back; merge" dance.
>
> What do you think?

Translators on a new language may not like this. Translating the obsole=
te
messages in pot file is boring and waste of time.

> =A0po/git.pot: $(LOCALIZED_C)
> - =A0 =A0 =A0 $(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) =
$(LOCALIZED_C)
> + =A0 =A0 =A0 cp $@ $@+

=46ailed if po/git.pot does not exist. touch one first?

> + =A0 =A0 =A0 $(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XG=
ETTEXT_FLAGS_C) $(LOCALIZED_C)
> =A0 =A0 =A0 =A0$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(X=
GETTEXT_FLAGS_SH) \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$(LOCALIZED_SH)
> =A0 =A0 =A0 =A0mv $@+ $@

--=20
Jiang Xin
