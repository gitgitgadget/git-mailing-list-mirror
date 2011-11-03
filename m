From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: How to make "git push/pull" work in non-clone repo?
Date: Thu, 3 Nov 2011 19:09:20 +0300
Message-ID: <F802D297-95A0-4B1E-894D-9681E0EEF3AD@jetbrains.com>
References: <CANiMyiFfiLnK8-q7vTZ9VAtkW8ip2NQfpR4iaU2oSnnonVDuUA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Hong-Ming Su <halleyinvent@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 16:09:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLyvF-0008AK-Qm
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 16:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933611Ab1KCPJh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 11:09:37 -0400
Received: from mail1.intellij.net ([46.137.178.215]:43724 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075Ab1KCPJg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 11:09:36 -0400
Received: (qmail 3464 invoked by uid 89); 3 Nov 2011 15:09:34 -0000
Received: by simscan 1.1.0 ppid: 3333, pid: 3432, t: 0.1100s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 3 Nov 2011 15:09:34 -0000
In-Reply-To: <CANiMyiFfiLnK8-q7vTZ9VAtkW8ip2NQfpR4iaU2oSnnonVDuUA@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184721>



03.11.2011, =D7 17:59, Hong-Ming Su:

> I create a repo X with git init. After several commit in X, I clone a
> bare repo Y from X.
> I try to continue work in X, and push to/pull from Y. The command git
> push and git pull fails. I see the error message but I do not know
> which git command can fix that problem.
> Then I clone Z from Y. git push/pull works in Z.
> How to make "git push/pull" the same in X as in Z?
>=20


By cloning Y from X you made X to be a parent of Y while you need vice =
versa.
To fix this add Y as a remote to X and set up tracking for you master b=
ranch.

By the way, in such cases you'd better write commands you've executed, =
and the error report you've got.
" I see the error message but I do not know which git command can fix t=
hat problem" - this is zero of useful information.

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
