From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH 1/5] gitweb: Add a comment explaining the meaning of $/
Date: Thu, 05 Dec 2013 10:16:14 +0100
Message-ID: <1386234974.2186.1.camel@localhost.localdomain>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	 <1386164583-14109-2-git-send-email-krzesimir@endocode.com>
	 <CANQwDwdiNHFCChVdkKxkEa+HOKzzhgfzy4d6iZB6ejSfva3Z3A@mail.gmail.com>
	 <1386171977.2173.23.camel@localhost.localdomain>
	 <CACPiFCJON33dz64qSZDnrCo8hbVpbxk7k65xmW1oBiZ4Muzcbg@mail.gmail.com>
	 <xmqqwqjkjr7e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 10:17:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoV3L-0008J5-JK
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 10:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755027Ab3LEJQi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 04:16:38 -0500
Received: from mail-bk0-f49.google.com ([209.85.214.49]:39586 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab3LEJQR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 04:16:17 -0500
Received: by mail-bk0-f49.google.com with SMTP id my13so7000621bkb.36
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 01:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=suZegPCYS7JcG0O4kv2t/FZfvXx3RaEis4myxWGshks=;
        b=C6IYSCRkiMYBwaALhWzVzCktuFgjaHn2t+AZPzXCC22i9OWOnP8gbP8LM+/1NeX7Iz
         GDknRTmFcQrsY59AqbjbU4+Lf9hwOKEjWgcnBM89hoFBlU1gDCgBiCFRJLAXr1op5lzD
         WVGrfiEZpiiGcf1bvf1mkGvPdoqR6Fth2oFMHyloWoKg4mIQWNv3+7e2kXAYbZuYlP/O
         yQFKD5RNfgC1vcVaZUG8rZyvw+B5yuafDgHYsP6Wd7hPvd79Hz4h78wyQf/MCdzH4p42
         ravusfNoQnh4c8fjJwxl7etMafAHh6gXuoEnSVasiN5wnTtPb4+OvePZNIcPZbFmxrE6
         Q+Uw==
X-Gm-Message-State: ALoCoQnl9YGvUUBHCobTpSBG1uY4Z+rLeGtuOKRufiQ2+QJu38zQ8h8atK22J/IMS1bXb30yr1Be
X-Received: by 10.204.117.196 with SMTP id s4mr7718514bkq.40.1386234976264;
        Thu, 05 Dec 2013 01:16:16 -0800 (PST)
Received: from [192.168.178.31] (p57922DC5.dip0.t-ipconnect.de. [87.146.45.197])
        by mx.google.com with ESMTPSA id z6sm84318556bkn.8.2013.12.05.01.16.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 01:16:15 -0800 (PST)
In-Reply-To: <xmqqwqjkjr7e.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238848>

On Wed, 2013-12-04 at 12:28 -0800, Junio C Hamano wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
>=20
> > On Wed, Dec 4, 2013 at 10:46 AM, Krzesimir Nowak <krzesimir@endocod=
e.com> wrote:
> >> On Wed, 2013-12-04 at 16:11 +0100, Jakub Nar=C4=99bski wrote:
> >>> On Wed, Dec 4, 2013 at 2:42 PM, Krzesimir Nowak <krzesimir@endoco=
de.com> wrote:
> >>>
> >>> > So future reader will know what does it mean without running "p=
erldoc
> >>> > perlvar".
> >>>
> >>> Hmmm... shouldn't future reader know it anyway?  It is not that c=
ryptic.
> >>> I'd say it is idiomatic Perl.
> >>
> >> It's plainly obscure. And I think it is not that often used -
> >
> > It's classic Perl.
> >
> > Perhaps you'd want to "use English;" and call it
> > $INPUT_RECORD_SEPARATOR in a patch titled "Make things readable to
> > non-Perl natives".
>=20
> Hmm, but do we want to see "use English" there in the first place?

Nevermind, I'm going to drop that patch.

--=20
Krzesimir Nowak
Software Developer
Endocode AG

krzesimir@endocode.com

------
Endocode AG, Johannisstra=C3=9Fe 20, 10117 Berlin
info@endocode.com | www.endocode.com

Vorstandsvorsitzender: Mirko Boehm
Vorst=C3=A4nde: Dr. Karl Beecher, Chris K=C3=BChl, Sebastian Sucker
Aufsichtsratsvorsitzende: Jennifer Beecher

Registergericht: Amtsgericht Charlottenburg - HRB 150748 B
