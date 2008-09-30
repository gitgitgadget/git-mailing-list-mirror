From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git grep: Add "-Z/--null" option as in GNU's grep.
Date: Tue, 30 Sep 2008 16:16:19 -0700
Message-ID: <20080930231619.GR21310@spearce.org>
References: <1222816390-9141-1-git-send-email-killekulla@rdrz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Raphael Zimmerer <killekulla@rdrz.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 01:17:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkoTA-0002Q9-JZ
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 01:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbYI3XQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 19:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754227AbYI3XQU
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 19:16:20 -0400
Received: from george.spearce.org ([209.20.77.23]:60526 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbYI3XQU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 19:16:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 43B1B3835F; Tue, 30 Sep 2008 23:16:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1222816390-9141-1-git-send-email-killekulla@rdrz.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97167>

Raphael Zimmerer <killekulla@rdrz.de> wrote:
> Here's a trivial patch that adds "-Z" and "--null" options to "git
> grep" equal to GNU's grep.
> So things like 'git grep -l -Z "$FOO" | xargs -0 sed -i "s/$FOO/$BOO/"'
> are more comfortable.

Elsewhere in Git we call this "-z", like "git ls-tree -z", "git
log -z".  Should we match grep or git convention here?
 
>  Documentation/git-grep.txt |    6 ++++++
>  builtin-grep.c             |    7 +++++++
>  grep.c                     |   14 +++++++++++---
>  grep.h                     |    1 +

-- 
Shawn.
