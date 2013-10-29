From: DimanNe <dimanne@ya.ru>
Subject: =?utf-8?B?UmU6IGdpdCBzdm4gYWxyZWFkeSBzZXQg4oCmIHdhbnRlZCB0byBzZXQgdG86?=
Date: Tue, 29 Oct 2013 18:14:51 +0400
Message-ID: <87941383056091@web26h.yandex.ru>
References: <1771383029875@web26g.yandex.ru> <87iowgiloj.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Oct 29 15:23:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbACM-0002yu-N3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 15:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017Ab3J2OXG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Oct 2013 10:23:06 -0400
Received: from forward1h.mail.yandex.net ([84.201.187.146]:36405 "EHLO
	forward1h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934Ab3J2OXE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 10:23:04 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Oct 2013 10:23:04 EDT
Received: from web26h.yandex.ru (web26h.yandex.ru [84.201.187.160])
	by forward1h.mail.yandex.net (Yandex) with ESMTP id B74639E1A28;
	Tue, 29 Oct 2013 18:14:52 +0400 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web26h.yandex.ru (Yandex) with ESMTP id 354018C05CE;
	Tue, 29 Oct 2013 18:14:52 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1383056092; bh=kp4CTuX1h7DRP+5juL2ZSMkxbeUWI87pSZ+RMDWH21A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QFEszgVMl5fBe6iP6PpAzJB9U9cCMsk0Z+SWQ7rmk0PH8RTbKxAhbn2c9y77RShUy
	 CVPvG9TiayhClfz8yg6Rz4N2ctfi3sJOs6QbYtO+rX4/C1oaSVmMyd9OcLgV3bmH8J
	 4DMiTq69elqeMzRaMYh7EVIBAsoqfYBY6+34kkFs=
Received: from dhcp172-103-red.yandex.net (dhcp172-103-red.yandex.net [95.108.172.103]) by web26h.yandex.ru with HTTP;
	Tue, 29 Oct 2013 18:14:51 +0400
Envelope-From: Dimanne@yandex.ru
In-Reply-To: <87iowgiloj.fsf@linux-k42r.v.cablecom.net>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236927>

> What does your config look like now?

[core]
        repositoryformatversion =3D 0
        filemode =3D true
        bare =3D false
        logallrefupdates =3D true

[svn-remote "svn"]
        url =3D https://some_host/trunk/
        fetch =3D :refs/remotes/git-svn

[merge]
        renameLimit =3D 50000

[svn-remote "stable-2012-09-13"]
        url =3D https://some_host/branches/stable-2012-09-13/
        fetch =3D :refs/remotes/stable-2012-09-13



29.10.2013, 11:25, "Thomas Rast" <tr@thomasrast.ch>:
> DimanNe <dimanne@ya.ru> writes:
>
>> =9AI am trying to clone/fetch svn branch with git-svn:
>>
>> =9Agit config --add svn-remote.stable-2012-03-29.url https://some_ho=
st/branch
>> =9Agit config --add svn-remote.stable-2012-03-29.fetch :refs/remotes=
/stable-2012-03-29
>> =9Agit svn fetch stable-2012-03-29
>>
>> =9Awhich gives me this error message:
>>
>> =9Asvn-remote.stable-2012-03-29.url already set:
>> =9Ahttps://some_host/branch/ wanted to set to: https://some_host/
>>
>> =9AI know that I probably can fix this by re-fetching all svn-repo f=
rom
>> =9Ascratch, but it will take months or even years (due to size of re=
po).
>
> What does your config look like now?
>
> You should have only one svn-remote with one url, but it can have
> multiple .fetch entries. =9ATo fetch all branches, you can also just
> configure its .branches.
>
> --
> Thomas Rast
> tr@thomasrast.ch
