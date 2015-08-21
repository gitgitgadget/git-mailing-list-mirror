From: =?koi8-r?B?48HQy8/XIOHMxcvTxco=?= <jiba88@ya.ru>
Subject: Re: No dialog box appears
Date: Fri, 21 Aug 2015 08:08:54 +0300
Message-ID: <2366991440133734@web7g.yandex.ru>
References: <4096511439969624@web22g.yandex.ru> <be6333650abce8a04c753112e4fa0c27@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 21 07:19:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSejv-0003RS-82
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 07:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbbHUFTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 01:19:38 -0400
Received: from forward18p.cmail.yandex.net ([77.88.31.38]:47479 "EHLO
	forward18p.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751058AbbHUFTh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Aug 2015 01:19:37 -0400
X-Greylist: delayed 633 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Aug 2015 01:19:37 EDT
Received: from web7g.yandex.ru (web7g.yandex.ru [95.108.252.107])
	by forward18p.cmail.yandex.net (Yandex) with ESMTP id 88E5920FDE;
	Fri, 21 Aug 2015 08:08:55 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web7g.yandex.ru (Yandex) with ESMTP id D622027A1224;
	Fri, 21 Aug 2015 08:08:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1440133735; bh=K993tsq3iZkAgYgj2iYbG70DFlqhoNN68U77XQ5RmH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jNxuBoRxgDranyMxQ8wA0EKDEH8GPBlVhXghF5FvyKTQ/mYRA1YQUd6IVygYVTXfM
	 Wd1ZgqbKa/WpstmUB6O0SvYendTISsooGiqjrm1fUxJKRL8W0OGHOMT86AE7GnGwmu
	 0BpTfJcXJtKmTq61Hae1cLPNi4ovWLr110W3NXr4=
Received: by web7g.yandex.ru with HTTP;
	Fri, 21 Aug 2015 08:08:54 +0300
Envelope-From: jiba88@yandex.ru
In-Reply-To: <be6333650abce8a04c753112e4fa0c27@www.dscho.org>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276277>

Yes. You're right. It is about Git for Windows installer. Thanks for th=
e answer. My problem was solved by creating a variable HOME in the para=
meters of the medium and refers to ssh.

19.08.2015, 16:17, "Johannes Schindelin" <johannes.schindelin@gmx.de>:
> Hi Aleksey,
>
> On 2015-08-19 09:33, =E3=C1=D0=CB=CF=D7 =E1=CC=C5=CB=D3=C5=CA wrote:
>
>> =9AWhen installing the Git is not a dialog box appears with a choice=
 ssh.
>> =9AWhat could be the reason?
>
> I assume that you are referring to the Git for Windows installer (ple=
ase state such details in the future). And I assume you were wondering =
why you could not choose putty as your ssh program. If that is the case=
, I think you might need to add connections to your putty first, otherw=
ise the installer will not even present the choice to you.
>
> But maybe you want to move this to the issue tracker at https://githu=
b.com/git-for-windows/git/issues?
>
> Ciao,
> Johannes

--=20
Shincho itte kudasai. Anime miteru hito!
