From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: [RFC] Making format-patch output better when blank line is missing?
Date: Sat, 17 Jan 2009 13:35:45 +0100
Message-ID: <20090117123545.GA22842@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 13:37:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOAQK-0002Cq-81
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 13:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652AbZAQMfs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 07:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756127AbZAQMfs
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 07:35:48 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:2296
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756011AbZAQMfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 07:35:47 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 28FE2801BF6C
	for <git@vger.kernel.org>; Sat, 17 Jan 2009 13:35:46 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LOAOv-00063v-8S
	  for git@vger.kernel.org; Sat, 17 Jan 2009 13:35:45 +0100
Content-Disposition: inline
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106046>

Hello,

I'm using git-format-patch to send commit diff emails, and it was
recently brought to my atention that if a commit message consists
entirely in a paragraph with no blank lines (particluarly, no blank lin=
e
after the first line, which is not a summary but just the first line of
the paragraph), git-format-patch will place all the commit message in
the Subject, which is inconvenient to read.

Do you think it would be good to have format-patch do something like
this in this case?:

    Subject: [PATCH] This commit introduces a new function bla() that [=
=2E..]

    [...] makes it possible to apply the frobniz operation to objects
    that don't bla bla bla bla.

(I realize that, with this, the applying logic would have to learn abou=
t
it. Hm.)

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
- I love you, Shirley, I'm not ashamed to say.
- If you love me, then you'll want me to be happy. Even if I'm not with=
 you.
- I don't love you that much.
                -- Denny Crane and Shirley Schmidt
