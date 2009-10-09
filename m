From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: can't create a branch on remote
Date: Fri, 09 Oct 2009 15:08:42 -0700 (PDT)
Message-ID: <m363aogqz9.fsf@localhost.localdomain>
References: <17cb70ee0910091435l4c4d1736hf4d403a2fe6331a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Auguste Mome <augustmome@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 00:11:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwNgM-00064J-Ji
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 00:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbZJIWJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 18:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756209AbZJIWJV
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 18:09:21 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:44233 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756135AbZJIWJU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Oct 2009 18:09:20 -0400
Received: by fxm27 with SMTP id 27so6797163fxm.17
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=VZ9Hhxw3lF9p80LTmfVHN22G74iRo8UILWhkfiEMj90=;
        b=aKxQFcr7hdrQkPljKWGgIdwdcEsPSflC1TFDFv0+gMGRh9nIyOixK9PDMJztU1V1LI
         jmId8JGVX0a8Dltx1jSYyOO4YpSl6oVMPzs854oWPyYVl5oQmwLgOKUO8XABx4TcaJsg
         UHRo+3sYglhX8zGwJBwKQArenVP9Spab41Z0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=w/WHkMx4J+/3U3WU1IAAjiyRWwcqhE8fNGdZ8c7QVPs+5Z1hkAipS+8PgfoG1Dx3bT
         /GV/nEiPeW36UeRXAgHzBDV810pzpuS4N6qZGdH9lrCc+Wfm8XjZduPbe9nDrh8/Jyqs
         cv3AD/30vqy88TsV8T8HbjwfCKuP7Kntil3zU=
Received: by 10.86.227.1 with SMTP id z1mr2918431fgg.56.1255126123199;
        Fri, 09 Oct 2009 15:08:43 -0700 (PDT)
Received: from localhost.localdomain (abwc235.neoplus.adsl.tpnet.pl [83.8.226.235])
        by mx.google.com with ESMTPS id 4sm751712fgg.13.2009.10.09.15.08.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 15:08:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n99M8hBm011437;
	Sat, 10 Oct 2009 00:08:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n99M8hjs011434;
	Sat, 10 Oct 2009 00:08:43 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <17cb70ee0910091435l4c4d1736hf4d403a2fe6331a2@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129850>

Auguste Mome <augustmome@gmail.com> writes:

> Hi,
> I have two repositories=A0 /home/user/linux and /home/user/dev/linux,
> same user on same machine.
> Here is how I create a local branch at v2.6.21.7 in /home/user/dev/li=
nux,
> #pwd
> /home/user/dev/linux
> # git remote add l2621
> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.21.y.g=
it
> # git fetch l2621
> # git branch mylocal26217=A0 v2.6.21.7
>=20
> Now I would like to do the same from the other repository /home/user/=
linux:
> # pwd
> /home/user/linux
> # git remote add other /home/guerin/dev/git/linux-2.6
> # git fetch other
> # git push /home/user/dev/git/linux-2.6
> =A0=A0=A0 v2.6.21.7:refs/heads/new_feature_name26217
> Total 0 (delta 0), reused 0 (delta 0)
> error: Trying to write non-commit object

  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> 170684ef0557d4b711a86595d31dcbebcb9d4ba2 to branch
> refs/heads/new_feature_name26217
> To /home/user/dev/git/linux-2.6
> =A0! [remote rejected] v2.6.21.7 -> new_feature_name26217 (failed to =
write)
> error: failed to push some refs to '/home/user/dev/git/linux-2.6'
>=20
> Maybe something to configure to authorize the creation of branch?

You can't push tag to branch. =20


I'm not sure if what you are trying to do makes sense at all, but the
commit pointed by v2.6.21.7 is v2.6.21.7^{}

--=20
Jakub Narebski
Poland
ShadeHawk on #git
