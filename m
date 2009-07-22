From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Why is it important to learn git?
Date: Wed, 22 Jul 2009 14:47:05 -0700 (PDT)
Message-ID: <m3iqhkbdb9.fsf@localhost.localdomain>
References: <e1a5e9a00907212208t10a071d0oe59a39b357a1111a@mail.gmail.com>
	<200907220952.27385.trast@student.ethz.ch>
	<fabb9a1e0907221115x212c4b52q47cac29cf0336fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 23:47:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjee-0005Qf-BO
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbZGVVrJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 17:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753024AbZGVVrI
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:47:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:18659 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbZGVVrH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 17:47:07 -0400
Received: by fg-out-1718.google.com with SMTP id e21so147817fga.17
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=eRviXT8iZBFzvF8P7Z0KuS26E4WffvOkTDa9x39bC5k=;
        b=POzTSekI2ju/3lBDbWuqgAemP6CugjzR+nvvxPfLkbk3z5OYCg9TV0tGbccgmebW/f
         8Y1ukDFtzQ1RZD82STx2mUW6E3BiZWhfJDFeXomOG7jlCyE/vVBACKscdvm9EczLgpgi
         U+nKCYyiupFlGcXZNrCFFjtDnqqIWKXY1hRh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=MwbFAQQdQANp+9blHRrUwVUk/IWZLiWfhwoA9MiGrULLnvtHwn6j2/dZNIAlGgF9Vh
         mcow04HNHVp4gpGxbmh8A+iRNKq9YK+PoX1OzqvOABn5H5z9+uJK2cEoWSwcj4qkn06G
         AUdoIDysQpppU33rdlt4mDvgjMAVD+PD/oSGM=
Received: by 10.86.97.18 with SMTP id u18mr1187105fgb.66.1248299226333;
        Wed, 22 Jul 2009 14:47:06 -0700 (PDT)
Received: from localhost.localdomain (abvd136.neoplus.adsl.tpnet.pl [83.8.201.136])
        by mx.google.com with ESMTPS id 12sm17539542fgg.29.2009.07.22.14.47.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Jul 2009 14:47:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6MLl7F2002817;
	Wed, 22 Jul 2009 23:47:07 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6MLl61m002814;
	Wed, 22 Jul 2009 23:47:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <fabb9a1e0907221115x212c4b52q47cac29cf0336fc@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123786>

Sverre Rabbelier <srabbelier@gmail.com> writes:
> On Wed, Jul 22, 2009 at 07:52, Thomas Rast<trast@student.ethz.ch> wro=
te:

> > =A0Learning to make nice, reviewable, working, one-change-per-revis=
ion
> > =A0commits.
>=20
> I very much agree with those values, but also
>=20
>   Commit early, commit often
=20
I also find commit message convention: "short one-line description,
separated by empty line, then more detailed description" to be very
useful (git tools assume and expect this convention).  It helps
keeping changesets / commits small; if you can't write oneline summary
of commit, it is probably too large :-)

--=20
Jakub Narebski
Poland
ShadeHawk on #git
