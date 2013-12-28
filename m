From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: german translation bug
Date: Sat, 28 Dec 2013 14:08:24 +0100
Message-ID: <87txdtazsn.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <1573480.3a5WD62Cc4@i5>
	<CAN0XMOJf=H__eFmbcBs-S50ASun94ASL9FiL1zM6eeTheYpxTg@mail.gmail.com>
	<1513689.dimJgKglhA@i5> <3869663.MXlVypzsjR@i5>
	<20131226165815.GR20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Wolfgang Rohdewald <wolfgang@rohdewald.de>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	git <git@vger.kernel.org>, Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 14:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwtjW-00078p-Ao
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 14:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab3L1NOs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Dec 2013 08:14:48 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:45408 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755332Ab3L1NOr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Dec 2013 08:14:47 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Dec 2013 08:14:46 EST
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 2D4AF4D652C;
	Sat, 28 Dec 2013 14:08:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qEvuQEy_w7pE; Sat, 28 Dec 2013 14:08:25 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (pD9EB29CB.dip0.t-ipconnect.de [217.235.41.203])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id EAE184D64BD;
	Sat, 28 Dec 2013 14:08:24 +0100 (CET)
In-Reply-To: <20131226165815.GR20443@google.com> (Jonathan Nieder's message of
	"Thu, 26 Dec 2013 08:58:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239784>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi,
>
> Wolfgang Rohdewald wrote:
>> Am Mittwoch, 25. Dezember 2013, 22:53:29 schrieb Wolfgang Rohdewald:
>
>>> I suppose I should open a KDE bug report?
>>
>> I meant a ubuntu bug report of course.
>
> Yes, please.  Feel free to cc me if doing so.
>
> In generally, I'm a bit uncomfortable lately at how Ubuntu's
> translation system works for Git.  They are trying to solve a real
> problem: old Ubuntu releases stick to old versions of git that do not
> have as complete translations as the latest version.  But their
> solution to this problem does not seem to work well and creates a lot
> of confusion.  Worse, it creates duplicated effort, as their custom
> translations don't seem to have been submitted upstream for review or
> inclusion.

Even worse, the German one under discussion uses an entirely different
vocabulary to describe git concepts:

  ubuntu (from OP):
    wr@s5:~/src/linux$ git status
    # Auf Zweig drm-intel-testing
    Nichts zum Einreichen, Arbeitsverzeichnis leer

  de.po current:
    msgid "nothing to commit, working directory clean\n"
    msgstr "nichts zu committen, Arbeitsverzeichnis unver=C3=A4ndert\n"

  de.po before the big vocabulary change:
     msgid "nothing to commit, working directory clean\n"
     msgstr "nichts einzutragen, Arbeitsverzeichnis sauber\n"

So their word for "commit (v.)" is "einreichen", whereas we had
"committen" and before that "eintragen".  As if there weren't enough
confusion around German terminology yet.

(FWIW I also think it's a terrible choice because it suggests a
transaction between multiple people, which to me sounds like it should
mean "push".)

--=20
Thomas Rast
tr@thomasrast.ch
