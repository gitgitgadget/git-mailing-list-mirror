From: Jeremy Morton <jeremy@configit.com>
Subject: git push default behaviour?
Date: Thu, 8 Mar 2012 10:01:46 +0000
Message-ID: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 11:02:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5aAU-0008VW-BY
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 11:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab2CHKBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 05:01:48 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53621 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751949Ab2CHKBs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 05:01:48 -0500
Received: by lahj13 with SMTP id j13so301417lah.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 02:01:46 -0800 (PST)
Received: by 10.152.127.136 with SMTP id ng8mr4046734lab.16.1331200906116;
 Thu, 08 Mar 2012 02:01:46 -0800 (PST)
Received: by 10.112.23.225 with HTTP; Thu, 8 Mar 2012 02:01:46 -0800 (PST)
X-Gm-Message-State: ALoCoQmg4Pha4R8iwp0ddmD5EFKbQU67h0uwC1QcBLu1aMhB+D8PjhVbrgpEZ6P2Xp7j9HXEZUO3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192547>

Hi everyone,

I've noticed that the default behaviour of 'git push' is to push to
*all* branches that have a remote branch set up.=A0 In order to push
just to one branch, you must specify 'git push repo branchname'.

This seems rather unintuative to me, and in the case of a '--force',
almost certainly not what you want.=A0 You're usually working on one
branch and just want to push that one, and it's usually the branch
you're currently on. And in the case of a '--force', in addition by
pushing all branches to remote, you are going to undo any changes on
other branches made since you updated them on your local repo.

Wouldn't it be better for git's default push behaviour (at least with
the '--force' option) to be just to push to the current branch in the
current repo?=A0 To push to all branches you could have an
'--allbranches' option.

Best regards,
Jeremy Morton (Jez)
