From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Branching strategies
Date: Thu, 15 Sep 2011 04:07:03 -0700 (PDT)
Message-ID: <m3ty8errkd.fsf@localhost.localdomain>
References: <CAAZ43xaFzJWzPsqhP0QDRTP0Ea-dMpCpr1vDiujFFn94j+SRCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: robert mena <robert.mena@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 13:07:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R49ml-0001zW-UV
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 13:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933177Ab1IOLHI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Sep 2011 07:07:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57894 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075Ab1IOLHH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2011 07:07:07 -0400
Received: by eya28 with SMTP id 28so258078eya.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 04:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=Huv466TmFNRZRrErY3bOwUZKqFMck2E64hOEJ8rMsfs=;
        b=PGVytzIfKyhqK2cRIrwtLdp5AJmVTXVBuE+iio/lRrcY1jLloKXaK4bZc1pwFE0ARG
         zeLfPah3Q/805Xxvd28/CJ42R2a7Mg9U3JMVGVBE6agaItgP8GnGKGHOH+JeO8VKP6iG
         TQdpbNv0XB9tuCICV4Xm/5Vg/MhIPnoS0I24o=
Received: by 10.213.28.69 with SMTP id l5mr1090599ebc.70.1316084824128;
        Thu, 15 Sep 2011 04:07:04 -0700 (PDT)
Received: from localhost.localdomain (abwn193.neoplus.adsl.tpnet.pl. [83.8.237.193])
        by mx.google.com with ESMTPS id a8sm7978186eec.4.2011.09.15.04.07.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Sep 2011 04:07:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8FB8j5B026662;
	Thu, 15 Sep 2011 13:08:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8FB8YT2026658;
	Thu, 15 Sep 2011 13:08:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAAZ43xaFzJWzPsqhP0QDRTP0Ea-dMpCpr1vDiujFFn94j+SRCQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181458>

robert mena <robert.mena@gmail.com> writes:

> I have a project where I have to do a continuous integration, adding
> features/making changes on a daily basis.  Some changes are one liner=
s
> with no functionality just, for example, textual changes or a new
> button.   Some are actual features or bug fixes.
>=20
> So today my developers do their business and publish the changes in a
> beta site where the customer or the qa takes a look.  The problem is
> a standard one.  Sometimes features stay already developed (waiting
> for review) for a long time and other changes/features get approved
> first.
>=20
> Since some of those can touch the same files how can I make this a
> little bit better (manageable)?
>=20
> I am considering doing feature branches.   The customer requests to
> add feature A I open a bug tracking issue and create a branch 1276
> corresponding to the bug id.
>=20
> In my simply view I'd have a master/live branch and every time I need
> to create a new branch I do it from here.  When the developer is happ=
y
> he merges his branch with a beta branch where the Q&A/customer review
> is done.
>=20
> When this review gets an OK he merges his feature branch with the liv=
e
> one, redo the tests and publish.
>=20
> I'd really appreciate feedback for this specially for the weak points
> and known problems of my approach with alternatives :)

The "Version Control by Example" by Eric Sink, http://www.ericsink.com/=
vcbe/
contains chapter about workflows, including feature branch workflow.

Junio Hamano blog (the old version) included a few articles about
using feature-branch workflow too.

HTH.
--=20
Jakub Nar=EAbski
