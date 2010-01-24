From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: set GIT_DIR and GIT_WORK_TREE after setup
Date: Sat, 23 Jan 2010 16:03:05 -0800
Message-ID: <20100124000305.GK12679@spearce.org>
References: <20100123232215.GI12679@spearce.org> <1264291140-16595-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 01:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYpwl-0003T0-MR
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 01:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753236Ab0AXADL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 19:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153Ab0AXADL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 19:03:11 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:58435 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057Ab0AXADK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 19:03:10 -0500
Received: by iwn16 with SMTP id 16so1142578iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 16:03:08 -0800 (PST)
Received: by 10.231.162.9 with SMTP id t9mr7707871ibx.5.1264291388029;
        Sat, 23 Jan 2010 16:03:08 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm3160791iwn.6.2010.01.23.16.03.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 16:03:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1264291140-16595-1-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137880>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> Rather than juggling with the env var GIT_DIR around the invocation of
> gitk, set it and GIT_WORK_TREE after finishing setup, ensuring that any
> external tool works with the setup we're running with.
> 
> This also allows us to remove a couple of conditionals when running gitk
> or git gui in a submodule, as we know that the variables are present and
> have to be unset and reset before and after the invocation.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  git-gui.sh |   43 ++++++++++++++++++++-----------------------
>  1 files changed, 20 insertions(+), 23 deletions(-)

Thanks, applied.

-- 
Shawn.
