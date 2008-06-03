From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 23:34:29 +0200
Message-ID: <200806032334.29769.jnareb@gmail.com>
References: <412634.67173.qm@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>, git@vger.kernel.org
To: ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Tue Jun 03 23:35:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3eA9-0002AP-Ih
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 23:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbYFCVed convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 17:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752283AbYFCVec
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 17:34:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:44732 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbYFCVec (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 17:34:32 -0400
Received: by nf-out-0910.google.com with SMTP id d3so679941nfc.21
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=8ojJQPFvkGU8ySV+vUvJYEfFZHOgxc37Kk9SYbAjp/4=;
        b=oWA716NN+T3JwPQu69El1UMI2iwdtoVHm/FC5lCX7zDEBybsyaD0u4Xs9zpH7Xn9EboXvd5jpJVjT1VabzGI4alI6skUpwRpwEhIWrH941/sJ6rI6FxRTeMcKk2JXykp1r/DG8uOfSV3+qUOtG1DpzPeEUS0uDJDttpoHFSKMMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TxWev7hDsgAKuCG74tDXs3fekJtl9UjkqIQWhNPRYP+LoBZ1IQMxg1RfEG2N2qHAoWAnCLEp12nrcj1jyqt/OR8lUKOFeaLHnRUrfCS3I59/fAM/m6e9bveRsOvAq9PevqjwxyZ2GHH41C8kSmjlrFNIlI8fLt2prd5DJReDYxI=
Received: by 10.210.124.15 with SMTP id w15mr108855ebc.106.1212528870937;
        Tue, 03 Jun 2008 14:34:30 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id 31sm3636863nfu.9.2008.06.03.14.34.28
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 14:34:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <412634.67173.qm@web31803.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83715>

Dnia wtorek 3. czerwca 2008 23:27, Luben Tuikov napisa=B3:
> --- On Tue, 6/3/08, Jakub Narebski <jnareb@gmail.com> wrote:

> > > > > +           my $parent_commit =3D
> > <$dd> || '';
> >=20
> > By the way, here you would probably want=20
> >=20
> > +           my $parent_commit =3D <$dd> ||
> > '--root';
> >=20
> > (if it works).
>=20
> AFAIR, I did experiment with the "--root" parameter.  Not sure why,
> but my command line ended up without it, and thus git_blame2()
> ended up without it.
>=20
> If you feel that it is, at this time having had changes commited sinc=
e my
> original commit, more correct to include it, then please go ahead.

I'm sorry, I havent thought this through.  This _cannot_ work.  You can
use '--root' as 'hp' parameter to force creation commitdiff, but not as
'hp' parameter to blame.

Sorry for the confusion.
--=20
Jakub Narebski
Poland
