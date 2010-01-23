From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] git-gui: Add a special diff popup menu for
	submodules
Date: Sat, 23 Jan 2010 14:57:55 -0800
Message-ID: <20100123225755.GF12679@spearce.org>
References: <4B3F7AE2.10007@web.de> <4B3F7B49.2030100@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:58:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYovh-0004MO-Qk
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:58:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab0AWW6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401Ab0AWW6E
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:58:04 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:52250 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab0AWW6A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:58:00 -0500
Received: by iwn16 with SMTP id 16so1121058iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 14:57:59 -0800 (PST)
Received: by 10.231.145.20 with SMTP id b20mr1285202ibv.78.1264287478759;
        Sat, 23 Jan 2010 14:57:58 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm3105415iwn.14.2010.01.23.14.57.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 14:57:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B3F7B49.2030100@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137875>

Jens Lehmann <Jens.Lehmann@web.de> wrote:
> To make it easier for users to deal with submodules, a special diff popup
> menu has been added for submodules. The "Show Less Context" and "Show More
> Context" entries have been removed, as they don't make any sense for a
> submodule summary. Four new entries are added to the top of the popup menu
> to gain access to more detailed information about the changes in a
> submodule than the plain summary does offer. These are:
> - "Visualize These Changes In The Submodule"
>   starts gitk showing the selected commit range
> - "Visualize These Changes In The Submodule"
>   starts gitk showing the whole submodule history of the current branch
> - "Visualize All Branch History In The Submodule"
>   starts gitk --all in the submodule
> - "Start git gui In The Submodule"
>   guess what :-)
> 
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>  git-gui/git-gui.sh |  127 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 files changed, 110 insertions(+), 17 deletions(-)

Thanks, applied.

-- 
Shawn.
