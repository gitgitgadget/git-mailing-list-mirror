From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCHv4 4/5] git-gui: set GIT_DIR and GIT_WORK_TREE after
	setup
Date: Sat, 23 Jan 2010 15:22:15 -0800
Message-ID: <20100123232215.GI12679@spearce.org>
References: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com> <1264241018-6616-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 00:22:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYpJH-0001He-HM
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 00:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab0AWXWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 18:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277Ab0AWXWT
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 18:22:19 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:37366 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab0AWXWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 18:22:18 -0500
Received: by iwn16 with SMTP id 16so1129247iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 15:22:18 -0800 (PST)
Received: by 10.231.152.75 with SMTP id f11mr1112151ibw.50.1264288937762;
        Sat, 23 Jan 2010 15:22:17 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 23sm3265315iwn.11.2010.01.23.15.22.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 15:22:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1264241018-6616-5-git-send-email-giuseppe.bilotta@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137877>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:
> Rather than juggling $GIT_DIR around the invocation of gitk, set it
> (and $GIT_WORK_TREE) after finishing setup, ensuring that any external
> tool works with the setup we're running with.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  git-gui/git-gui.sh |   15 +++------------
>  1 files changed, 3 insertions(+), 12 deletions(-)

This patch has merge conflicts with changes from Jens Lehmann
related to starting gitk inside of a submodule.  Since I merged
his menu code first, I would appreciate it if you could rebase this
one patch on top of my latest master:

  git://git.spearce.org/git-gui.git master


The other 4 patches in this series are already applied, thanks.

-- 
Shawn.
