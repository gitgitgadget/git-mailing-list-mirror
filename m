From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Re: git remote doesn't show remotes from .git/remotes
Date: Fri, 7 Oct 2011 19:49:50 +0400
Message-ID: <20D55874-4329-4F8C-8EEE-0319B57F4A2B@jetbrains.com>
References: <26866FC7-4D4D-46D0-89DE-85AF459AC48C@jetbrains.com> <20111007150423.GA2076@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 07 17:50:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCCgR-00008u-Hv
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 17:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab1JGPty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 11:49:54 -0400
Received: from mail1.intellij.net ([46.137.178.215]:46182 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752467Ab1JGPty convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 11:49:54 -0400
Received: (qmail 25826 invoked by uid 89); 7 Oct 2011 15:49:52 -0000
Received: by simscan 1.1.0 ppid: 25759, pid: 25817, t: 0.0881s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 7 Oct 2011 15:49:52 -0000
In-Reply-To: <20111007150423.GA2076@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183081>


07.10.2011, =D7 19:04, Jeff King wrote

> I'm not sure how much we
> care, though. We haven't generated .git/remotes files in a long time,
> and this is the first notice of the bug after 3.5 years. Is this an o=
ld
> repo that has remotes, or are you wondering if you should use them in=
 a
> new repo?
>=20

No, I never came across any usages of .git/remotes.
I am writing a Git integration plugin for an IDE, and was studying docu=
mentation for git-remote where I saw this method to define remotes.=20
So I've just decided to report the lack of the 'git remote' output and =
make sure that I didn't miss anything. And also decide if I have to sup=
port them in the product - probably, not.

I agree that the bug is not worth fixing since nobody uses .git/remotes=
 anyway.

Thanks for the clarification.
