From: "W. Trevor King" <wking@tremily.us>
Subject: =?UTF-8?q?=5BPATCH=20v4=200/3=5D=20User=20manual=20updates?=
Date: Tue, 19 Feb 2013 05:04:59 -0500
Message-ID: <cover.1361267945.git.wking@tremily.us>
References: <20130219093429.GA4024@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 11:05:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7k55-0004nH-6E
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 11:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758590Ab3BSKFM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Feb 2013 05:05:12 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:43175 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758297Ab3BSKFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 05:05:10 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MIG00APCPCLJ430@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 19 Feb 2013 04:05:10 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 2CF978ABA03; Tue,
 19 Feb 2013 05:05:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1361268309; bh=2rOsljXyV080amJ7ZwnACEFGF2IhzqDrTCsPYDazmGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JM9APQi/8b1tvtM2YSQKRv6EbuRajt6eQOyQ7aFag5uH56z0UIcFT5++qKjJSrU6q
 C8Od5PnhCpafoio14zn5adWVMgvKUeuVwTdK6DIKwNcVlmgmukNa65QQYZodaevD41
 vn3LHHcFFVYV9M6FNtluTGEFT5uxYTpDSfLbIKKk=
X-Mailer: git-send-email 1.7.12.4
In-reply-to: <20130219093429.GA4024@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216593>

=46rom: "W. Trevor King" <wking@tremily.us>

Changes since v3 (v3 numbering):

* 1: user-manual: Use 'remote add' to setup push URLs
  - Dropped (graduated into 'maint', e9b4908)
* 2: user-manual: Reorganize the reroll sections, adding 'git rebase -i=
'
  - Added some comments giving example uses of 'commit --amend'.  This
    should make the section less lonely.
  - Fix s/preferred/needed/
  - Call interactive rebase commands "instructions" and "steps"
  - Reworded interactive rebase return-to-shell description following
    Junio's suggestions.
* 3: user-manual: Give 'git push -f' as an alternative to +master
  - Dropped (graduated into 'maint', d1471e0)
* 4: user-manual: Mention 'git remote add' for remote branch config
  - Dropped (graduated into 'maint', 47adb8a)
* 5: user-manual: Standardize backtick quoting
  - Temporarily dropped (not rebased onto maint, due to conflicts with
    2de9b71 (Documentation: the name of the system is 'Git', not
    'git', 2013-01-21))
* 6: user-manual: Use 'git config --global user.*' for setup
  - Dropped (graduated into 'maint', 632cc3e)
* 7: user-manual: Use request-pull to generate "please pull" text
  - Reworded request-pull introduction based on Junio's suggestions.
* 8: user-manual: Flesh out uncommitted changes and submodule updates
  - Adopt Junio's =E2=80=9Cdid not commit=E2=80=9D =E2=86=92 =E2=80=9Ch=
ave uncommitted changes=E2=80=9D
    rephrasing.
* 9: user-manual: Use -o latest.tar.gz to create a gzipped tarball
  - Dropped (graduated into 'maint', 7ed1690)

W. Trevor King (3):
  user-manual: Reorganize the reroll sections, adding 'git rebase -i'
  user-manual: Use request-pull to generate "please pull" text
  user-manual: Flesh out uncommitted changes and submodule updates

 Documentation/user-manual.txt | 133 ++++++++++++++++++++++++----------=
--------
 1 file changed, 77 insertions(+), 56 deletions(-)

--=20
1.8.1.336.g94702dd
