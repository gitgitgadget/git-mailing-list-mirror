From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git alias and --help
Date: Fri, 28 Oct 2011 06:27:27 -0700 (PDT)
Message-ID: <m31utx5js7.fsf@localhost.localdomain>
References: <j8clg9$ldh$1@dough.gmane.org>
	<7vfwiexe6m.fsf@alter.siamese.dyndns.org>
	<7v8vo6xd4u.fsf@alter.siamese.dyndns.org>
	<buoty6t9937.fsf@dhlpc061.dev.necel.com>
	<7vvcr9wyje.fsf@alter.siamese.dyndns.org>
	<j8ds01$fc7$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Gelonida N <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 15:27:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJmT8-0006wc-2d
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 15:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755759Ab1J1N1a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 09:27:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53630 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab1J1N13 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 09:27:29 -0400
Received: by faan17 with SMTP id n17so3611036faa.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 06:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=TPiHV77TkMyXP5c8+h+Y5qmToinegh+1/rP+kA+Ox2k=;
        b=D64+UsEBYdENnigbyj4Al132hcR1WdTILXKp+ONx15MokG9Jm1ocLOFY5iuIpE4Vx6
         BBo09/hYopeBYX19xENRCV/R9ElFv5xq0CXkNACxg9cZYaaBP6nOay6o+FfHcH2YZhhg
         zlBMoAezEeQx5fQwYWK8+G2L3KSue3/qYwXME=
Received: by 10.223.1.7 with SMTP id 7mr6290385fad.30.1319808448391;
        Fri, 28 Oct 2011 06:27:28 -0700 (PDT)
Received: from localhost.localdomain (abvy192.neoplus.adsl.tpnet.pl. [83.8.222.192])
        by mx.google.com with ESMTPS id c13sm17440529fai.3.2011.10.28.06.27.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Oct 2011 06:27:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9SDQxc5032210;
	Fri, 28 Oct 2011 15:27:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9SDQn9R032206;
	Fri, 28 Oct 2011 15:26:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <j8ds01$fc7$1@dough.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184408>

Gelonida N <gelonida@gmail.com> writes:

[...]

> Another small detail:
>=20
> Let's assume I have following alias:
>=20
> log =3D log --name-status
>=20
>=20
> In this case I directly get the help text for git log
> if I typed 'git log --help' (or 'git help log').
> I don't even see, that my log is in reality aliased.

That is because it doesn't work: git does not allow for aliasing its
built-in commands.

--=20
Jakub Nar=EAbski
