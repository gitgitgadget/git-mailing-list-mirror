From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH v2] gitweb: Add an option for adding more branch refs
Date: Thu, 28 Nov 2013 12:49:17 +0100
Message-ID: <1385639357.2075.3.camel@localhost.localdomain>
References: <1385566221-7977-1-git-send-email-krzesimir@endocode.com>
	 <CAPig+cT=P3ZC9j-WwQjr7gu6RrNgLrXsPkiVmdy5OGYfu8mPqA@mail.gmail.com>
	 <CAPig+cR3hoWmDPJyWP6HbpuDvRwgdNj5VwX8A20DCfRBK5OuSQ@mail.gmail.com>
	 <xmqqob55sgww.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 12:49:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vm061-0004uO-15
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 12:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758697Ab3K1LtV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 06:49:21 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]:62623 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306Ab3K1LtU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 06:49:20 -0500
Received: by mail-bk0-f54.google.com with SMTP id v16so3816173bkz.27
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 03:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=F2YZvBkbnc2Vy+pdCy6UpTu6GGGiyO3uJp1pFaeZGTI=;
        b=ZqcxVs88Fu/r6yiw8Z02eBTWGf+5GLi3CTTCH7r0PqgSYsmXVBY7p65cJH2o5sUhUI
         ncTLK3WHmrZJ2ANcOQ8jM+TABJvIoOzjmp3wGfoeyv8KUfVyeY9+BRLmGS7Gf48nddM5
         QLbusJi+ziXU+gKHMawFPPXf7TYIEOpFUKaHcN0KODi8gsY2kfSnrlQfT9GKtSagO4Dx
         QbICLb9GW1hxSrbBjyr14NF1wTrVUDejzTuts8OIazaLBxSS1tGAGJM/2ozweApLmVuu
         L2juQ/BfRP4+WNW6PukJTaf51/tqOAYkLLicJbTEKJ9PDvd/r05dMx1Pmkk2pUcwleSt
         +tlQ==
X-Gm-Message-State: ALoCoQll4d6ixj84nArbLA5ULf1BOsTUdnG4NNjeBuzT6TWzEdIGLLLTqRqozU8ZTTnlKS/tzx+u
X-Received: by 10.205.35.5 with SMTP id su5mr25193bkb.131.1385639359375;
        Thu, 28 Nov 2013 03:49:19 -0800 (PST)
Received: from [192.168.1.100] (95-91-241-33-dynip.superkabel.de. [95.91.241.33])
        by mx.google.com with ESMTPSA id no2sm59431673bkb.15.2013.11.28.03.49.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 28 Nov 2013 03:49:18 -0800 (PST)
In-Reply-To: <xmqqob55sgww.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238493>

On Wed, 2013-11-27 at 12:55 -0800, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>=20
> > On Wed, Nov 27, 2013 at 3:34 PM, Eric Sunshine <sunshine@sunshineco=
=2Ecom> wrote:
> >> On Wed, Nov 27, 2013 at 10:30 AM, Krzesimir Nowak
> >> <krzesimir@endocode.com> wrote:
> >>> Overriding an @additional_branch_refs configuration variable with
> >>> value ('wip') will make gitweb to show branches that appear in
> >>> refs/heads and refs/wip (refs/heads is hardcoded).
>=20
> "branches" are by definition what are in refs/heads/ hierarchy, so=20
>=20
>   Allow @additional_branch_refs configuration variable to tell
>   gitweb to show refs from additional hierarchies in addition to
>   branches in the list-of-branches view.
>=20
> would be more appropriate and sufficient.

Thanks.

>=20
> >> Mentioning $ref in the error message would help the user resolve t=
he
> >> problem more quickly.
> >>
> >>> +               die_error(500, '"heads" specified in @additional_=
branch_refs') if ($ref eq 'heads');
> >>
> >> Rephrasing this as
> >>
> >>     "heads" disallowed in @additional_branch_refs
> >>
> >> would better explain the problem to a user who has only made a cur=
sory
> >> read of the documentation.
> >
> > The program could easily filter out the redundant 'heads', so does
> > this really deserve a diagnostic?
>=20
> True.

Ok, I'm deduping both heads and other refs as well. Now we send 500 onl=
y
if the ref is simply invalid.

>=20
> I was primarily worried about metacharacters in the specified
> strings getting in the way of regexp matches the new code allows on
> them, but that has been resolved with the use of \Q..\E; if that
> automatic deduping is done, I do not immediately see any remaining
> issues in the latest round of the patch.
>=20

New patch in "[PATCH v3] gitweb: Add an option for adding more branch
refs". Thanks for reviews!

> Thanks.

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
