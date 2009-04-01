From: Kris Shannon <kris@shannon.id.au>
Subject: Re: On git 1.6 (novice's opinion)
Date: Wed, 1 Apr 2009 13:32:21 +1100
Message-ID: <e51f4f550903311932x118e1378yc1b25e5d9c97d50d@mail.gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 04:34:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoqHX-0002Cd-2I
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 04:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbZDACcZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 22:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbZDACcZ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 22:32:25 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:36894 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466AbZDACcY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 22:32:24 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2744818ywb.1
        for <git@vger.kernel.org>; Tue, 31 Mar 2009 19:32:21 -0700 (PDT)
Received: by 10.231.16.199 with SMTP id p7mr1546205iba.40.1238553141659; Tue, 
	31 Mar 2009 19:32:21 -0700 (PDT)
In-Reply-To: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115336>

2009/3/27 Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>:
> 2) Keyword substitution. I know it's controverse (dealing with binary=
 files),
> but I'd like to have some automatic version numbering keyword at leas=
t:
> Initial idea is that every commit with a change increments the number=
 by one,
> and when merging numbers a and b, the resulting number is max(a, b) +=
 1.

Check out gitattributes(5) - the ident attribute:

When the attribute ident is set for a path, git replaces $Id$ in the bl=
ob
object=C2=A0with $Id:, followed by the 40-character hexadecimal blob ob=
ject name,
followed by a dollar sign $ upon checkout. Any byte sequence that begin=
s
with $Id: and ends with $ in the worktree file is replaced with $Id$ up=
on
check-in.

That means the Id is file specific, not commit specific - just like the=
 $Id$
expansion for CVS and SCCS is about the file (as there is no real conce=
pt
of a commit in CVS and SCCS)
