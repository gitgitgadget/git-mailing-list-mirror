From: Krzesimir Nowak <krzesimir@endocode.com>
Subject: Re: [PATCH 4/5] gitweb: Add a feature for adding more branch refs
Date: Tue, 10 Dec 2013 17:04:33 +0100
Message-ID: <1386691473.2143.1.camel@localhost.localdomain>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	 <1386164583-14109-5-git-send-email-krzesimir@endocode.com>
	 <CANQwDwe+a2P0Jxqw0k7sHWv3exdb4k+NU3jL3ogR-rcetd82TQ@mail.gmail.com>
	 <1386237635.2186.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?UTF-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 17:04:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqPni-0006Ad-Vf
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 17:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655Ab3LJQEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Dec 2013 11:04:42 -0500
Received: from mail-ee0-f44.google.com ([74.125.83.44]:43638 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970Ab3LJQEk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 11:04:40 -0500
Received: by mail-ee0-f44.google.com with SMTP id b57so2339725eek.3
        for <git@vger.kernel.org>; Tue, 10 Dec 2013 08:04:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=mce4LSmrIt7MdJb57PXAVs5mOckHY9Wehwu1A1UTemY=;
        b=jnP5VtOdbQT2KQmIyk08+zc/0NNkmDCFnJNdsKolEMaBOJxjHkQya/oDd1iZR8zGBS
         YGCHf3eF9wAkE9xQT0+k2fRrcxzyY6uwMGkP6b3bDvNhqyaQFAKKcckdq1iMR6OOKqRp
         UhFT8xXwuPbVb5P8CqWG1WQbHLkWd+TCdsjzytwsVoB7185HnHM0bJhJm6cwdNVMQD2G
         s5m+wPOPeqXY4BbugNsOtn1BlPMgfvGqOB8JzIu3IpvgyWvlRBXPnuXSWWW8BCsEWUOk
         EC+t1lvhHdcA4GjgHG2NdYVi6XDJyntu8OcsuZMfevxMyeqloHiypjbPuj/0fTj19lmK
         oT3Q==
X-Gm-Message-State: ALoCoQn3yCURyxBeK/hIE/+7/EjQ6UrVUMQMFRer6ZwErMPDWPDLrKx5Up8r0ux3gWGYh8pZ8jQr
X-Received: by 10.15.63.77 with SMTP id l53mr9815964eex.89.1386691475911;
        Tue, 10 Dec 2013 08:04:35 -0800 (PST)
Received: from [192.168.1.100] (95-91-240-245-dynip.superkabel.de. [95.91.240.245])
        by mx.google.com with ESMTPSA id 44sm42759870eek.5.2013.12.10.08.04.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Dec 2013 08:04:34 -0800 (PST)
In-Reply-To: <1386237635.2186.22.camel@localhost.localdomain>
X-Mailer: Evolution 3.8.5 (3.8.5-2.fc19) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239139>

On Thu, 2013-12-05 at 11:00 +0100, Krzesimir Nowak wrote:
> On Wed, 2013-12-04 at 19:06 +0100, Jakub Nar=C4=99bski wrote:
> > On Wed, Dec 4, 2013 at 2:43 PM, Krzesimir Nowak <krzesimir@endocode=
=2Ecom> wrote:
> > > ++
> > > +It is an error to specify a ref that does not pass "git check-re=
f-format"
> > > +scrutiny. Duplicated values are filtered.
> > > +
> >=20
> > Hmmm... 'snapshot' feature ignores invalid values, but in this case
> > formerly valid compression schemes might get invalid via tightening
> > %known_snapshot_formats, and we don't want existing config getting
> > suddenly invalid.
> >=20
>=20
> So, should I just ignore the invalid refs or treat them as errors?

Ping, I'd like to know the answer for this question before I roll out
another set of patches - there seem to be no agreement over it. Thanks!

Cheers,
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
