From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [Q] updates to gitk, git-gui and git-svn for 2.8?
Date: Tue, 15 Mar 2016 07:18:39 +0000
Message-ID: <20160315071839.GB24036@dcvr.yhbt.net>
References: <xmqqd1qwaopd.fsf@gitster.mtv.corp.google.com>
 <20160315015726.GA25295@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Victor Leschuk <vleschuk@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	k_satoda Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 08:19:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afjFu-0003Mo-En
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 08:19:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934150AbcCOHSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 03:18:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36973 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934037AbcCOHSj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 03:18:39 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 581251F725;
	Tue, 15 Mar 2016 07:18:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160315015726.GA25295@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288838>

<dropping Pat and Paul from the Cc:>

Eric Wong <normalperson@yhbt.net> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > If there are pending updates for the upcoming release, please let me
> > know and tell me what to pull.
> 
> The following changes since commit db6696f653b917509dac1ac13b922e12773a84ff:
> 
>   Merge branch 'mg/wt-status-mismarked-i18n' (2016-03-14 10:46:17 -0700)
> 
> are available in the git repository at:
> 
>   git://bogomips.org/git-svn.git master
> 
> for you to fetch changes up to d9868087879a8103ff1f174905ed358791065482:

Or not, Torsten's test change doesn't seem baked, yet:

	http://mid.gmane.org/56E79C54.8000606@web.de

Anyways, we'll let that cook a while and the other two patches
can be had at:

The following changes since commit db6696f653b917509dac1ac13b922e12773a84ff:

  Merge branch 'mg/wt-status-mismarked-i18n' (2016-03-14 10:46:17 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git svn-glob

for you to fetch changes up to 62335bbbc747c96636b5ce9917b156304c732eaf:

  git-svn: shorten glob error message (2016-03-15 01:35:39 +0000)

----------------------------------------------------------------
Eric Wong (1):
      git-svn: shorten glob error message

Victor Leschuk (1):
      git-svn: loosen config globs limitations

 Documentation/git-svn.txt                  |  12 ++
 perl/Git/SVN/GlobSpec.pm                   |  18 ++-
 t/t9108-git-svn-glob.sh                    |   9 +-
 t/t9109-git-svn-multi-glob.sh              |   9 +-
 t/t9168-git-svn-partially-globbed-names.sh | 223 +++++++++++++++++++++++++++++
 5 files changed, 258 insertions(+), 13 deletions(-)
 create mode 100755 t/t9168-git-svn-partially-globbed-names.sh
