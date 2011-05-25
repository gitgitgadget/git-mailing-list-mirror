From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 18:38:58 +0200
Message-ID: <201105251838.59548.jnareb@gmail.com>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com> <m3boyqzy3f.fsf@localhost.localdomain> <20110525151115.GB8795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elazar Leibovich <elazarl@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 18:39:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPH6y-00052N-3i
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 18:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979Ab1EYQjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 12:39:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65426 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757902Ab1EYQjA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 12:39:00 -0400
Received: by wya21 with SMTP id 21so5919489wya.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=6A0IWFfpbJtAtrNMaDDQhpnQVZgkErRiqte5KYr2z6g=;
        b=LMQubOTIvXcsPUdXTE+okPzU59u+3g/HcH+T0QayTVapll+hJTzg9HbqH2o1urh2pj
         7atjLXDwBO0KhB5PVlFiax6CWuMcGUs7dIeageRRoAX4gdjnj1trX7/ed/yVVE/EcTMY
         5snB5rRDjtydng1GP7Z1e4wjMItBATYQx7VqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OgnJR869VtYiX6p3pgMOKvhtMZM8HAub2SIfHJzQLvffGLRDlW5HqS5FtyPx5FVEti
         u6UPMcSLDkt20HEIYuj44mKZTvpFDHygc5+gAYc6/mwFGnjllTBP8FTMJfWHooHx6lE7
         onQ2pM+po0Ark7PofulJ3h834VrWgavUykoxA=
Received: by 10.216.145.195 with SMTP id p45mr4577684wej.61.1306341539580;
        Wed, 25 May 2011 09:38:59 -0700 (PDT)
Received: from [192.168.1.13] (abvv43.neoplus.adsl.tpnet.pl [83.8.219.43])
        by mx.google.com with ESMTPS id m72sm391934weq.4.2011.05.25.09.38.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 09:38:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110525151115.GB8795@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174427>

Dnia =C5=9Broda 25. maja 2011 17:11, Jeff King napisa=C5=82:
> On Wed, May 25, 2011 at 06:53:31AM -0700, Jakub Narebski wrote:
>=20
> > > Which is a shame, because we already have all of the code for "--=
and",
> > > "--or", and "--not" in git-grep. It is just a syntactic conflict.=
 I
> > > think you could get away with "--grep-and", "--grep-or", and
> > > "--grep-not". They are obviously less nice to type, but there wou=
ld be
> > > not conflict.
> >=20
> > Hmmm... perhaps short -! could be alias for --grep-not (it is the o=
nly
> > that needs to be changed to avoid conflict, as there are no --or an=
d
> > --and for rev-list).
>=20
> Ick. I really hate using shell metacharacters that need quoting
> (especially "!", which even gets expanded inside double-quotes). But =
as
> long as it's an alias, I guess people who care can use --grep-not.

Yeah, I know.  Nevertheless '!' is natural to mean 'not',=20
and `-\!` is still shorter than `--grep-not`.
=20
--=20
Jakub Narebski
Poland
