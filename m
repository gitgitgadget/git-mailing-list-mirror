From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Announcing Git for Windows 2.6.4
Date: Tue, 15 Dec 2015 11:16:07 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512151116020.6483@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=X-UNKNOWN
To: git-for-windows@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 15 11:16:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8meb-0004QE-DS
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 11:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbbLOKQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 05:16:14 -0500
Received: from mout.gmx.net ([212.227.15.15]:59424 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964798AbbLOKQM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 05:16:12 -0500
Received: from virtualbox ([37.24.143.140]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LvE2c-1aGnLH3Jdy-010MY2; Tue, 15 Dec 2015 11:16:09
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:4Rtj4U3NWROxWyg79/QoPsbE8/HbR1B/6I7/7HIeB49CmsLZXjY
 iQQM4wlOn6r8FpBdMN8YflVYFLjrkt4pKeaMHWFy6e7KnhQPq3z0kutFghjNaO7NkkVtMoe
 DHJ+Ahxx/v0lYTjhpZ2zsEo6rtAtDdrWPb5FoRt5mCGNLvRtA453zXadXksx3s0N7SBobzf
 vzRHesdSSWFUnqDFDBquQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mDLCkOV/sho=:XD9Sv1DVojox+O2lsTT48w
 xw6pLik0sW6lyny5nQM7+iA54o0C8mztj3DDmhDG4K/PkarshHzBwgHTw7YW2ECzD1spD8guh
 bLTMsSi8J3DhBRlI0PIBsqFGt9fb2ngwzlZgugp4HyOgurRNLIQtj0uF4dcvwSGZ90vCTQcah
 9GfdkJGUANmMXYJfnIbl4AfqMyZ+QLg0Wq1L3EJkXM8DePgvVjMf6wIimjJoRowc2SojFqR2m
 9XoGvNJhRuZfrfZtTgjN09tDjkB0eCUC6KuhvEkY487vaTemx7ezdV24lBx9FwLN6Q8GNrz6H
 JgyrY/XQYI6pXfeDOKnFN/KC2R+EObW0F4n//h3Dca8AXqkbqZR9ResbQG8Pq8Qg1gubzMvay
 OOFOEdge5RVMH6zFRGfjVvw0oIRCkJJnp7mXOGk30jrRkNw/4Rw+byWV4rMMgqkGHdMarUWiu
 yPVJbhqJrU37yg652xMDaVu/1IqXtatAdmyHL621TGMTwUXeanl81SiRFIeYFJnYCdRXWm4Eq
 1+RKKxYQJOugianqYiM85iskIHNvFVl46nIv9G1JrhFb5g1gMAHhbQfztnDUvh4gpag+BrDqx
 p5M85ZyJDcUdjmcS1OlXoODfT+KpgGll+BC1d3ZqNbGE6Po2FYV0gpbUTXqvQW+w8AIJwzq38
 nHWPik8XelBKQR5ADKPdEU3sf5xVNLw6co8dEl797zTGQwo4U8eM4BJwUqnZE/eMOPQlCA98Y
 YbRPHsx253/TijDBTYAOFF7lnhP6kcLhJJ33N2kGFfqaJt2OQ6OgoRYVqJFxvEAEy4Ds+ecm 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282471>

Dear Git users,

It is my pleasure to announce that Git for Windows 2.6.4 is available from:

	https://git-for-windows.github.io/

Changes since Git for Windows v2.6.3 (November 10th 2015)

New Features

  ??? Comes with Git v2.6.4.
  ??? Also available as .tar.bz2 packages (you need an MSys2/
    Cygwin-compatible unpacker to recreate the symbolic links
    correctly).

Bug Fixes

  ??? Git for Windows v2.6.3's installer failed to elevate privileges
    automatically (reported three times, making it a charm), and as a
    consequence Git for Windows 2.6.3 was frequently installed per-user
    by mistake
  ??? The bug where SHELL_PATH had spaces and that was reported multiple
    times has been fixed.
  ??? An additional work-around from upstream Git for SHELL_PATH
    containing spaces (fixing problems with interactive rebase's exec
    command has been applied.

Filename | SHA-256
-------- | -------
Git-2.6.4-64-bit.exe | 2deab47a0e4a212576f6822db532269d8a69ec47345f946da655e04b2437ae44
Git-2.6.4-32-bit.exe | c2c27746010f3b09949fb8435ac8a8d1496aeb6fb26fc6ac787ed09686cffcaa
PortableGit-2.6.4-64-bit.7z.exe | 42190f01e78c68e0b4485cd31f8296af392bcaf82a7291f21918f4412e90db8c
PortableGit-2.6.4-32-bit.7z.exe | 5b0fcea5262db1a7676b5cd21df717cd02f1835a270d7f94d1537028462e61df
Git-2.6.4-64-bit.tar.bz2 | d2d143fe5b9a6517ebec5afcb3183a809f3b7ceda9abf2c1c76203accf65e877
Git-2.6.4-32-bit.tar.bz2 | 71296bef22154077f8f5acda61b791fbbecce872f4d2c550b61ca82f58eb8c90

Ciao,
Johannes
