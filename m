From: Clark Williams <clark.williams@gmail.com>
Subject: Odd problem in repository
Date: Tue, 24 Apr 2007 12:24:02 -0500
Message-ID: <462E3D32.60804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 19:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgOkS-0007gs-VK
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbXDXRYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422778AbXDXRYM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:24:12 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:9237 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422768AbXDXRYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 13:24:10 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2282142wxd
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 10:24:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=MlwmRDrPeS7T6PSKN5qC/oQKKXEbuGgM06zR86sWVZ69mazvlWyDW5gCgDwX1Ul7jT/ilYlf26RWlzU1sXcGTFcXORcMQKwGnhJYevaMClPkiqIjYGcT04bn4TP/kc804LCjYY/asKARp7Bf4EBduszVwzVrOcHMlKTD4IDH7ys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=tFfI1HpLAb8xMtd6+p6ErspNWQ5Qiv7yrOn8piRzNzT9wiNvr3aFNEC/11t//i9JJuZTNPEgVvO/dR5Xkw/gp57RUyE6d5IOMzkdI1EnYg9p6H6ecSCBGfg2Tmyzsp2dZB/SLVfmpiQ8sDilTt8ePExbuJQTLiwM9w/lwZveDG8=
Received: by 10.70.89.19 with SMTP id m19mr12795571wxb.1177435448800;
        Tue, 24 Apr 2007 10:24:08 -0700 (PDT)
Received: from ?172.16.16.120? ( [66.187.231.200])
        by mx.google.com with ESMTP id h18sm16573047wxd.2007.04.24.10.24.06;
        Tue, 24 Apr 2007 10:24:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45474>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello git-list,

We're experimenting with using git for the mock source repository on
fedoraproject.org. The CVS repository was converted over and I
successfully cloned a repository and went merrily on my way.

One of my collaborators cloned the repository the other day and found
that it didn't have any branches in it. I cloned a temp copy of it and
found that the files that normally would be in refs/heads to identify
the branches had somehow been moved to the directory
refs/remotes/origin. In my local repository (which was cloned
immediately after the CVS import), if I list what's in refs/heads, I get
this:

$ ls -F refs/heads
master  mock  mock-0-6-branch  mock-0.7  origin

on the whacky cloned copy, I get this:
$ ls -F refs/heads
master

and if I look in refs/remotes/origin:
$ ls -F refs/remotes/origin
HEAD  master  mock  mock-0-6-branch  mock-0.7  origin

Can anyone come up with a way that I could have mangled the repository
with a push? I mean, I have no idea how that remotes/origin directory
got created; I don't even have an interactive login on
git.fedoraproject.org.

If anyone wants to see the repository, you can clone it from:

git://git.fedoraprojects.org/git/hosted/mock

I'm not sure if it makes sense to try and repair this or just start
anew. Any advice would be appreciated.

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD4DBQFGLj0xqA4JVb61b9cRAhWYAJ49SDX6EnRxkFkJGjq5TUjhHjP2kwCWOJfK
obOqRJwU0vOq/aZDsM3glw==
=XwQr
-----END PGP SIGNATURE-----
