From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3 0/3] Multiple worktrees vs. submodules fixes
Date: Tue, 9 Dec 2014 07:04:35 +0200
Message-ID: <20141209050435.GA9140@wheezy.local>
References: <1418100283-8995-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 06:10:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyD4I-0002Dx-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 06:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbaLIFEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 00:04:41 -0500
Received: from p3plsmtpa12-03.prod.phx3.secureserver.net ([68.178.252.232]:59873
	"EHLO p3plsmtpa12-03.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750713AbaLIFEl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Dec 2014 00:04:41 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-03.prod.phx3.secureserver.net with 
	id RH4W1p0065B68XE01H4dzT; Mon, 08 Dec 2014 22:04:40 -0700
Content-Disposition: inline
In-Reply-To: <1418100283-8995-1-git-send-email-max@max630.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261111>

On Tue, Dec 09, 2014 at 06:44:40AM +0200, Max Kirillov wrote:
> After discussions I came to basically same as v1.
> 
> * Resubmitting the 2 patches which have not been taken to worktrees reroll -
>   they fix visible issue. Mostly unchanged except small cleanup in test.
> * Added GIT_COMMON_DIR to local_repo_env. While it is obviously a right
>   thing, I wasn't able to observe any change in behavior.
> 
> Max Kirillov (3):
>   submodule refactor: use git_path_submodule() in add_submodule_odb()
>   path: implement common_dir handling in git_path_submodule()
>   Add GIT_COMMON_DIR to local_repo_env
> 
>  cache.h                          |  1 +
>  environment.c                    |  1 +
>  path.c                           | 24 ++++++++++++++++++++----
>  setup.c                          | 17 ++++++++++++-----
>  submodule.c                      | 28 ++++++++++------------------
>  t/t7410-submodule-checkout-to.sh | 10 ++++++++++
>  6 files changed, 54 insertions(+), 27 deletions(-)
> 
> -- 
> 2.2.0.50.gb2b6831
>

Should be applied on top of
http://thread.gmane.org/gmane.comp.version-control.git/260387
with _all_ patches included, currently it's df56607dff

-- 
Max
