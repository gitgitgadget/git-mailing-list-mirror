From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: handle really long error messages in
	updateindex.
Date: Sat, 23 Jan 2010 14:23:01 -0800
Message-ID: <20100123222301.GA12679@spearce.org>
References: <87bphqui9t.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jan 23 23:23:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYoNv-00081T-07
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 23:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab0AWWXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 17:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752057Ab0AWWXL
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 17:23:11 -0500
Received: from mail-iw0-f186.google.com ([209.85.223.186]:58629 "EHLO
	mail-iw0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab0AWWXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 17:23:09 -0500
Received: by iwn16 with SMTP id 16so1109734iwn.33
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 14:23:04 -0800 (PST)
Received: by 10.231.157.131 with SMTP id b3mr1418403ibx.19.1264285384576;
        Sat, 23 Jan 2010 14:23:04 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm3078099iwn.14.2010.01.23.14.23.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 14:23:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87bphqui9t.fsf@users.sourceforge.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137868>

Pat Thoyts <patthoyts@users.sourceforge.net> wrote:
>  As reported to msysGit (bug #340) it is possible to get some very long
>  error messages when updating the index. The use of a label to display
>  this prevents scrolling the output. This patch replaces the label with
>  a scrollable text widget configured to look like a label.
> 
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
>  lib/index.tcl |   34 ++++++++++++++++++----------------
>  1 files changed, 18 insertions(+), 16 deletions(-)

Thanks, applied.

-- 
Shawn.
