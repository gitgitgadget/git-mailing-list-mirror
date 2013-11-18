From: Tim Chase <git@tim.thechases.com>
Subject: Re: Git -> fossil bridging?
Date: Sun, 17 Nov 2013 18:26:50 -0600
Message-ID: <20131117182650.1ba89a8b@bigbox.christie.dr>
References: <20131117150010.675971d3@bigbox.christie.dr>
	<575D57DB-026F-484E-8068-E7965395E902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Kyle J. McKay" <mackyle@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 18 01:25:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViCer-0003o4-Go
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 01:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004Ab3KRAZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 19:25:23 -0500
Received: from boston.accountservergroup.com ([50.22.11.22]:34200 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751546Ab3KRAZV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Nov 2013 19:25:21 -0500
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:34358 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1ViCeX-0000cj-1K; Sun, 17 Nov 2013 18:25:21 -0600
In-Reply-To: <575D57DB-026F-484E-8068-E7965395E902@gmail.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: authenticated_id: tim@thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237964>

On 2013-11-17 14:43, Kyle J. McKay wrote:
> Sounds like you want to write a 'git-remote-fossil' helper so you
> can do something like:
> 
>    git clone fossil::http://sqlite.org/src

Pretty much.  Or at least something akin to git-svn where one would do

  git fossil clone http://some.fossil.url/path/to/repo.fossil
  # hack hack
  git commit
  # possibly some git-branch, git-merge, git-rebase, git-cherry-pick
  # lather, rinse, repeat
  git fossil push # or git fossil dcommit

I've not played with the git+hg or git+bzr bridges to see if they'd
have a more useful interface that would better map to fossil.  If so,
imagine that's what I typed above ;-)

-tkc
