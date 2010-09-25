From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCHv2 09/16] t4026 (color): add missing &&
Date: Sat, 25 Sep 2010 00:56:24 -0700 (PDT)
Message-ID: <m3d3s2gsub.fsf@localhost.localdomain>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
	<1285366976-22216-10-git-send-email-newren@gmail.com>
	<AANLkTi=SyN6H7RAuDW2zPekMdxwWkY+__v4df2Lj_Z3O@mail.gmail.com>
	<20100925040227.GA21416@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 25 09:56:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzPch-0002TD-3o
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 09:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab0IYH42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 03:56:28 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62441 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957Ab0IYH41 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 03:56:27 -0400
Received: by bwz11 with SMTP id 11so2425865bwz.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 00:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=zXVQdC0XfSJOa4HaDqVuH/mQwGdEe6Wd/R3LW+qeuGU=;
        b=EslxZ5RSHwCAoxp2sDirCNLpsdG+X5kjLuwqQJaaeZPbJh8gBgbFuWEbTZeQcklPbB
         wUc0RvmCI/E3dQXlxawetFgLdm6aj3Te8/BIUolxLQ/3Ta9mu9xWAHVP6vcuN6zPSguf
         pmq/58b8kVd7dx+qbS6CbEW3zkLQk7bo84R2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=pl0nkNw7/Pf88Mwamv6PGiSyTKCHsv7SiPzKlO4Fx5xCOuKsW+wSqP4ttDF5hUYq/S
         T/Pcl4hPe00F8RlyWS09Bbq9cMgwUJGpiOgwDSd4fbfwu4k8xdSPlWk1LSIoGlw0uCZ7
         SETJaiQJqrW8Th77yMO0kUdoYs7jQFfXJOZ4c=
Received: by 10.204.50.194 with SMTP id a2mr2808037bkg.183.1285401385431;
        Sat, 25 Sep 2010 00:56:25 -0700 (PDT)
Received: from localhost.localdomain (abwt167.neoplus.adsl.tpnet.pl [83.8.243.167])
        by mx.google.com with ESMTPS id 24sm2284302bkr.7.2010.09.25.00.56.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 00:56:24 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8P7tvlO010662;
	Sat, 25 Sep 2010 09:56:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8P7tftW010658;
	Sat, 25 Sep 2010 09:55:41 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100925040227.GA21416@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157130>

Jeff King <peff@peff.net> writes:

> On Fri, Sep 24, 2010 at 10:55:08PM +0000, =C6var Arnfj=F6r=F0 Bjarmas=
on wrote:
>=20
> > On Fri, Sep 24, 2010 at 22:22, Elijah Newren <newren@gmail.com> wro=
te:
> > > FIXME: Is it intended that this git config --unset fail? =A0I had=
 to add a
> > > test_might_fail as well.
> >=20
> > Presumably this is to work around the user having diff.color in his
> > config or something? Should we be leaking like that?
>=20
> No, it was to clean up from previous tests, which set diff.color.new,=
 to
> make sure we had a clean environment.  So it should have been might_f=
ail
> (but it predated might_fail, which is why it wasn't).

Shouldn't modern test script use 'test_when_finished <script>' for
cleanup instead?
=20
> But look at 8b124135, which came later. It changed the color() and
> invalid_color() helpers to no longer use diff.color.new, so that clea=
nup
> is now obsolete. So that line can simply be removed now.

Well, there is that.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
