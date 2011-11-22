From: Pascal Obry <pascal@obry.net>
Subject: How to deal with mixed tree?
Date: Tue, 22 Nov 2011 12:21:40 +0100
Message-ID: <CA+9ZNic-9U0nP1NGL0shUijnxdhaoEHwyxWM8rOzR2B6Qjq6zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 12:21:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSoQ7-0004ES-Qc
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 12:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758405Ab1KVLVl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Nov 2011 06:21:41 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54132 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758066Ab1KVLVl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2011 06:21:41 -0500
Received: by yenq3 with SMTP id q3so74036yen.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 03:21:40 -0800 (PST)
Received: by 10.50.17.199 with SMTP id q7mr19820034igd.20.1321960900211; Tue,
 22 Nov 2011 03:21:40 -0800 (PST)
Received: by 10.231.158.66 with HTTP; Tue, 22 Nov 2011 03:21:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185788>

A project P1 is under Git.

A project P2 is under Subversion.

P2 in fact replace a sub-directory (say SD) in P1. The project P2 is a
replacement (extension) of the code in P1.

How to deal with this?

If you clone P1, remove SD in P1 to replace it by P2:

   $ git diff

   -> will display all the changes in SD, is there a way to avoid that?

   $ git merge (between branches) will try to merge changes in SD

I'd like to really tell Git to ignore SD as if it was not there. Any so=
lution?

Thanks,
Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 T=
eam-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|=A0 =A0 =A0 =A0 =A0 =A0 =A0 http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
