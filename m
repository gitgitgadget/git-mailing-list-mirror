From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH maint 0/10] Re: [PATCH v2] Fix various typos and grammaros
Date: Thu, 11 Apr 2013 23:48:38 -0700
Message-ID: <20130412064837.GA5710@elie.Belkin>
References: <CAPig+cSXC6cA8gc1T=byqeQF_gUYKpHTjpTt54Xog=jtfdgMwA@mail.gmail.com>
 <85f4e2b8e40efb234a7fc0d0ce0d40562690d001.1365719690.git.stefano.lattarini@gmail.com>
 <7v4nfch90r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefano Lattarini <stefano.lattarini@gmail.com>,
	sunshine@sunshineco.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 12 08:49:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQXnG-0005Fi-U3
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 08:49:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575Ab3DLGs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 02:48:59 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:43414 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab3DLGsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 02:48:52 -0400
Received: by mail-pd0-f174.google.com with SMTP id p12so1253970pdj.33
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 23:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=a0qp2GYSwfYlgpUjbb6s43rqus0iZDNlj32DvnkKi0Q=;
        b=0sz5lpY5yPEipO0+CoMF3dJrcboF1Icf+jqnC4XBX9Gb1XDizzrLjAaV4UQbUW8k8v
         ze4VQ1qSgdyw54FxVifjRzHeTFTDcFR/1Rg0WdvH+TAfphJz1rIvt0hxjFnvENpZbm35
         z+IWDWGfW9P1O8iykg6tNzQG6Hxu+OeroaEFqiSVkfNHU9fVW4QQKBDvLmg5xiI+ZhYw
         Ss2JDvy2NhBLBfwp3FVfUmJOxHBFNs+PEAU7m0b3M2avifeNldTj3Nuz5LHYC8vPkGSR
         TGQ1mpsdhNrs6CteHXgr1BLmZvu9R21equsMgcdQnIgKjPh9BuQ20eZKcjZrtWc4+qy9
         e7rw==
X-Received: by 10.68.253.196 with SMTP id ac4mr13085106pbd.57.1365749331962;
        Thu, 11 Apr 2013 23:48:51 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id cp1sm7286538pbc.42.2013.04.11.23.48.48
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 23:48:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4nfch90r.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220958>

Hi,

Junio C Hamano wrote:

> How much of this stuff have interact with real changes that are in
> flight, with various doneness cooking in different integration
> branches?

All except the t3511-cherry-pick-x.sh change apply cleanly to
"maint" and merge without trouble with master and pu.

Here is a split-up version.  I haven't looked closely at the patch,
even to sanity check it --- one of the main points of splitting it
this way is to make it easier to review with reference to code
borrowed from other projects.

I left out the change to compat/nedmalloc/Readme.txt, since it is
changing a historical record, and to
contrib/mw-to-git/t/t9360-mw-to-git-clone.sh, because it seems
realistic to allow the nyan cat to demonstrate poor punctuation
skills.

Some of these patches need more work if they are to be applied.  For
example, git-gui is maintained separately and should not be patched
from the toplevel.

Hope that helps,
Jonathan

Stefano Lattarini (10):
  doc: various spelling fixes
  git-remote-mediawiki: spelling fixes
  contrib/subtree: fix spelling of "accidentally"
  obstack: fix spelling of "similar"
  compat/regex: fix spelling and grammar in comments
  compat/nedmalloc: fix spelling in comments
  precompose-utf8: fix spelling of "want" in error message
  kwset: fix spelling in comments
  git-gui: fix spelling in comments
  Correct common spelling mistakes in comments and tests

 Documentation/git-credential.txt                   |  2 +-
 Documentation/git-remote-ext.txt                   |  2 +-
 Documentation/git-svn.txt                          |  4 ++--
 Documentation/git-tools.txt                        |  2 +-
 Documentation/revisions.txt                        |  2 +-
 Documentation/technical/api-argv-array.txt         |  2 +-
 Documentation/technical/api-credentials.txt        |  2 +-
 Documentation/technical/api-ref-iteration.txt      |  2 +-
 builtin/apply.c                                    |  6 +++---
 commit.c                                           |  2 +-
 commit.h                                           |  2 +-
 compat/nedmalloc/malloc.c.h                        |  6 +++---
 compat/obstack.h                                   |  2 +-
 compat/precompose_utf8.c                           |  2 +-
 compat/regex/regcomp.c                             |  4 ++--
 compat/regex/regex.c                               |  2 +-
 compat/regex/regex_internal.c                      |  6 +++---
 contrib/mw-to-git/git-remote-mediawiki.perl        |  6 +++---
 contrib/mw-to-git/t/README                         |  6 +++---
 contrib/mw-to-git/t/install-wiki/LocalSettings.php |  2 +-
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh        | 14 +++++++-------
 contrib/subtree/t/t7900-subtree.sh                 |  2 +-
 diff.c                                             |  2 +-
 git-add--interactive.perl                          |  2 +-
 git-cvsserver.perl                                 |  4 ++--
 git-gui/lib/blame.tcl                              |  2 +-
 git-gui/lib/index.tcl                              |  2 +-
 git-gui/lib/spellcheck.tcl                         |  4 ++--
 git-quiltimport.sh                                 |  2 +-
 gitweb/INSTALL                                     |  2 +-
 gitweb/gitweb.perl                                 |  6 +++---
 kwset.c                                            |  4 ++--
 perl/Git.pm                                        |  2 +-
 perl/Git/I18N.pm                                   |  2 +-
 perl/private-Error.pm                              |  2 +-
 po/README                                          |  6 +++---
 sequencer.c                                        |  2 +-
 t/t1006-cat-file.sh                                |  2 +-
 t/t3701-add-interactive.sh                         |  2 +-
 t/t4014-format-patch.sh                            |  6 +++---
 t/t4124-apply-ws-rule.sh                           |  2 +-
 t/t6030-bisect-porcelain.sh                        |  2 +-
 t/t7601-merge-pull-config.sh                       |  2 +-
 t/t7610-mergetool.sh                               |  2 +-
 t/t9001-send-email.sh                              |  4 ++--
 transport-helper.c                                 |  2 +-
 transport.h                                        |  2 +-
 xdiff/xdiffi.c                                     |  2 +-
 xdiff/xhistogram.c                                 |  2 +-
 49 files changed, 77 insertions(+), 77 deletions(-)
