From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [Q] updates to gitk, git-gui and git-svn for 2.8?
Date: Tue, 15 Mar 2016 01:57:26 +0000
Message-ID: <20160315015726.GA25295@dcvr.yhbt.net>
References: <xmqqd1qwaopd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org, Victor Leschuk <vleschuk@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 02:57:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afeEo-0005Nd-EZ
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 02:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933209AbcCOB52 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2016 21:57:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59008 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932768AbcCOB52 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 21:57:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84237633808;
	Tue, 15 Mar 2016 01:57:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqd1qwaopd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288827>

Junio C Hamano <gitster@pobox.com> wrote:
> If there are pending updates for the upcoming release, please let me
> know and tell me what to pull.
>=20
> Thanks.

The following changes since commit db6696f653b917509dac1ac13b922e12773a=
84ff:

  Merge branch 'mg/wt-status-mismarked-i18n' (2016-03-14 10:46:17 -0700=
)

are available in the git repository at:

  git://bogomips.org/git-svn.git master

for you to fetch changes up to d9868087879a8103ff1f174905ed358791065482=
:

  t9115: Skip pathnameencoding=3Dcp932 under HFS (2016-03-15 01:35:48 +=
0000)

----------------------------------------------------------------
Eric Wong (1):
      git-svn: shorten glob error message

Torsten B=C3=B6gershausen (1):
      t9115: Skip pathnameencoding=3Dcp932 under HFS

Victor Leschuk (1):
      git-svn: loosen config globs limitations

 Documentation/git-svn.txt                  |  12 ++
 perl/Git/SVN/GlobSpec.pm                   |  18 ++-
 t/t9108-git-svn-glob.sh                    |   9 +-
 t/t9109-git-svn-multi-glob.sh              |   9 +-
 t/t9115-git-svn-dcommit-funky-renames.sh   |   6 +-
 t/t9168-git-svn-partially-globbed-names.sh | 223 +++++++++++++++++++++=
++++++++
 6 files changed, 262 insertions(+), 15 deletions(-)
 create mode 100755 t/t9168-git-svn-partially-globbed-names.sh
