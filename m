From: Johan Kiviniemi <johan@kiviniemi.name>
Subject: [ANNOUNCE] update-base-branch: Track arbitrary external content in 
	Git branch
Date: Tue, 21 Jul 2009 17:29:02 +0300
Message-ID: <bd9320b40907210729q32b3e031r54cc7474d1b5685d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 16:29:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTGLl-0001LM-4z
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 16:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754803AbZGUO3F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jul 2009 10:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754590AbZGUO3F
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 10:29:05 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:38994 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbZGUO3D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 10:29:03 -0400
Received: by bwz28 with SMTP id 28so2626464bwz.37
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 07:29:02 -0700 (PDT)
Received: by 10.239.135.78 with SMTP id c14mr569550hbc.102.1248186542259; Tue, 
	21 Jul 2009 07:29:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123658>

To reduce the pain with the merging of my config changes (for various
software) with upstream=E2=80=99s new defaults, I came up with a small =
program
to track the default config files in a Git branch.

With things set up, the update and the merge become a matter of:

% ./update-defaults (or whatever you=E2=80=99ll call your script)
% git merge defaults (or whatever you=E2=80=99ll call the defaults bran=
ch)

The program is generic, of course =E2=80=93 I=E2=80=99ve already found =
other uses for it[1].

The README:
http://github.com/ion1/update-base-branch#readme

How I use the program in real life =E2=80=93 examples of what the
update-defaults script mentioned above could look like:
http://github.com/ion1/update-base-branch/tree/master/examples#browser

Release tarball:
http://johan.kiviniemi.name/software/update-base-branch/

A demonstration: using the program to update the user config for the
Awesome window manager:
http://www.youtube.com/watch?v=3DRQ3CqJ4jM90&fmt=3D18

[1] If there is no public VCS repository for a piece of software and
you want to maintain/send patches, use update-base-branch to track the
contents of the latest released tarball and merge that branch with
your =E2=80=98master=E2=80=99.

--=20
J=CE=BFhan Kiviniemi
