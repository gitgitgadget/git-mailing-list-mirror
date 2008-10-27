From: vanicat@debian.org (=?utf-8?Q?R=C3=A9mi?= Vanicat)
Subject: Re: Can't merge
Date: Mon, 27 Oct 2008 20:14:20 +0100
Message-ID: <87zlkp7svn.dlv@maison.homelinux.org>
References: <20081027165247.141110@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: html-kurs@gmx.de
X-From: git-owner@vger.kernel.org Mon Oct 27 20:17:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuXaS-0004E9-Cs
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 20:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbYJ0TP7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2008 15:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbYJ0TP7
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 15:15:59 -0400
Received: from fb2.tech.numericable.fr ([82.216.111.50]:41041 "EHLO
	fb2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYJ0TP6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2008 15:15:58 -0400
Received: from smtp3.tech.numericable.fr (unknown [10.0.0.48])
	by fb2.tech.numericable.fr (Postfix) with ESMTP id B0F8E19D2E0
	for <git@vger.kernel.org>; Mon, 27 Oct 2008 20:15:56 +0100 (CET)
Received: from maison.homelinux.org (ip-210.net-89-3-222.rev.numericable.fr [89.3.222.210])
	by smtp3.tech.numericable.fr (Postfix) with ESMTP id 85F043E524;
	Mon, 27 Oct 2008 20:14:24 +0100 (CET)
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <vanicat@debian.org>)
	id 1KuXXg-0002nk-Nd; Mon, 27 Oct 2008 20:14:22 +0100
In-Reply-To: <20081027165247.141110@gmx.net> (html-kurs@gmx.de's message of
	"Mon, 27 Oct 2008 17:52:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: vanicat@debian.org
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,NO_RELAYS
	autolearn=ham version=3.2.5
X-SA-Exim-Version: 4.2.1 (built Wed, 25 Jun 2008 17:14:11 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99251>

html-kurs@gmx.de writes:

> Hi,
>
> I've run in trouble when trying to merge a branch:
> I've got a branch "foo".
> I checkout master.
>> git diff foo=20
> shows many diffs.
> But=20
>> git merge foo
> says:
> Already up-to-date.
>
> I'm using version 1.6.0.2
>
> Any idea what I'm doing wrong?

When git say "Already up-to-date" it tell you that all change introduce=
d
in the foo branch are in master. But there could be change in master
that are not in foo, making foo and master different. You could try=20

> gitk foo..master
to see commit that are in master but not in foo and that could introduc=
e
the difference between the foo and master branch.


--=20
R=C3=A9mi Vanicat
