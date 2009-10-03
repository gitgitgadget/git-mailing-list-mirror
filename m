From: =?UTF-8?q?Herv=C3=A9=20Cauwelier?= <herve@itaapy.com>
Subject: Patches for libgit2
Date: Sat,  3 Oct 2009 20:09:55 +0200
Message-ID: <1254593401-18801-1-git-send-email-herve@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 03 20:13:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mu96b-0004eY-AE
	for gcvg-git-2@lo.gmane.org; Sat, 03 Oct 2009 20:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755722AbZJCSJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Oct 2009 14:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755396AbZJCSJS
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Oct 2009 14:09:18 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:54057 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331AbZJCSJS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2009 14:09:18 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 3D4784B00D7
	for <git@vger.kernel.org>; Sat,  3 Oct 2009 20:08:36 +0200 (CEST)
Received: from localhost.localdomain (mon75-11-82-242-92-33.fbx.proxad.net [82.242.92.33])
	by smtp2-g21.free.fr (Postfix) with ESMTP id 145214B014D
	for <git@vger.kernel.org>; Sat,  3 Oct 2009 20:08:34 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129488>


Hi,

Please find patches for libgit2. They allowed me to read the history of=
 a
repository with only 75 patches but hacked by an history shortening.

Commits were both in a 5 GB pack file and loose objects. So I had to ad=
d
support for pack files. Hopefully, reading idx files was already there =
so I
followed the same model.

Patches can also be cloned at "git://git.hforge.org/libgit2.git".

There is a Python wrapper on the next side, forking from the existing
libgit2-python [1]. They bring the same functionnalities but the patche=
s are
not slick yet.

[1] http://code.istique.net/gitweb/?p=3Dlibgit2-python.git;a=3Dsummary

One thing that would miss is unit tests, but I lack experience on testi=
ng C
code, and it would require having a small but exhaustive pack file with
different types of object, including ofs and ref deltas. Help on this p=
art is
welcome.

Next step would be decoding raw objects to commits, trees, blobs and ta=
gs.
There is already the start of a commit structure. I'll be starting from=
 that.

Regards,

Herv=C3=A9
