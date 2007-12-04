From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-add--interactive works only in top level
Date: Tue, 04 Dec 2007 04:21:35 -0800 (PST)
Message-ID: <m3d4tmveep.fsf@roke.D-201>
References: <058EB5A2-1EFE-43B9-9886-7272A955CE51@mit.edu>
	<7vwsrv9fos.fsf@gitster.siamese.dyndns.org>
	<4BC1648E-3059-4373-B388-65AD739796D8@MIT.EDU>
	<7vmysr9dxg.fsf@gitster.siamese.dyndns.org>
	<9AADB5DF-15FA-4A5F-BF4B-509135E486B6@wincent.com>
	<Pine.LNX.4.64.0712041148310.27959@racer.site>
	<404A9328-65CF-479E-A109-0C8B09CA43D5@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Reid Barton <rwbarton@MIT.EDU>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 13:22:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzWmp-0000Ap-9K
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 13:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbXLDMVk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 07:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbXLDMVj
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 07:21:39 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:56715 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbXLDMVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2007 07:21:38 -0500
Received: by mu-out-0910.google.com with SMTP id i10so901051mue
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=pcU0CAmEyuFUwdgZxyC8kK1UmyPN7TYdUJztPnPWIXA=;
        b=GfV2SIuVyskPKJgNBQKhE8nFLhKK9NEqkW6dIpm7Rf7fSPBEUhCY/svqauQsi+/p5CSvHFnyWzKani0Myn05xH76Za8q/ZD57qi3n9rSKp3hEREk16m4CmWOozqNMGs4k2PlJ4pWTrImsEPFxp3yfgmHVyTNe0PyTM+PplmArek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=lkKlc0amcAibnGCZJuvO1jkYdHozyvvmh/zSi9d+Nbdh8xQzKEMaY+k/r3Gm9+Cw9oegMUdsIRBiOIqlFx/BdCDdAP0aHR/Cqjt6ywFFUTlysGjvsUAL2G2hnbf/5qleQWoxm7l+IKhGshiNUvYSMtWF4bTcMbVas93GZtD9LWE=
Received: by 10.78.168.1 with SMTP id q1mr7029889hue.1196770896267;
        Tue, 04 Dec 2007 04:21:36 -0800 (PST)
Received: from roke.D-201 ( [83.8.233.204])
        by mx.google.com with ESMTPS id e8sm81023muf.2007.12.04.04.21.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2007 04:21:35 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB4CLb21016507;
	Tue, 4 Dec 2007 13:21:37 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB4CLZcp016504;
	Tue, 4 Dec 2007 13:21:35 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <404A9328-65CF-479E-A109-0C8B09CA43D5@wincent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67040>

Wincent Colaiuta <win@wincent.com> writes:

> El 4/12/2007, a las 12:48, Johannes Schindelin escribi=C3=83=C2=B3:
>=20
> > You know, without patches you will not convince me ;-)
>=20
> A number of patches have already been submitted (by Nguy=C2=85n Tha =20
> Ng=C2=8Dc Duy, I believe); you know, the "Move all dashed form git =20
> commands to libexecdir" thread and its precursors. I was just arguing=
 =20
> in support of the rationale behind them.

I think creating separate libexecdir, and moving there _helpers_ first
(i.e. command which are neither plumbing, nor porcelain, but are
meant to be called _only_ by other commands) would be a good idea,
perhaps even pre 1.5.4.

By the way, if (when) dashed form of commands would get moved to
libexecdir, the INSTALL fragment below talking about removin wrapper
script would have to be changed. But does anyone use GNU Interactive
Tools anymore (IIRC the package name was changed to gitfm or sth.)

<quote src=3D"INSTALL">
 - git normally installs a helper script wrapper called "git", which
   conflicts with a similarly named "GNU interactive tools" program.

   Tough.  Either don't use the wrapper script, or delete the old GNU
   interactive tools.  None of the core git stuff needs the wrapper,
   it's just a convenient shorthand and while it is documented in some
   places, you can always replace "git commit" with "git-commit"
   instead.

   But let's face it, most of us don't have GNU interactive tools, and
   even if we had it, we wouldn't know what it does.  I don't think it
   has been actively developed since 1997, and people have moved over t=
o
   graphical file managers.
</quote>

--=20
Jakub Narebski
