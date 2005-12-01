From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC/PATCH 1/3] git-find-git: a new helper.
Date: Thu, 1 Dec 2005 15:35:24 +0100
Message-ID: <200512011535.25022.Josef.Weidendorfer@gmx.de>
References: <7vmzjuzphl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 15:38:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhpX1-0003BV-Bq
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 15:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVLAOf2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 09:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVLAOf2
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 09:35:28 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:61074 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S932244AbVLAOf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 09:35:27 -0500
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id 89C5D27E5;
	Thu,  1 Dec 2005 15:35:26 +0100 (MET)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
In-Reply-To: <7vmzjuzphl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13060>

On Thursday 24 November 2005 04:36, you wrote:
>     GIT_DIR_PREFIX is a string to be prepended to cwd relative
>     paths to make them repository relative.
> 
>     GIT_DIR_UPLEVEL is a string (e.g. "../") for the command to
>     use to cd to the top-level of repository.

Hi,

can we revive this idea?
I thought about how to make work

 $top/Documentation> git-mv ../file .

and also detection of trying to move to the outside.
Requirements IMHO:
(1) helper which is also useful from PERL
(2) git-mv checks against version controlled files via git-ls-files.
Thus, I need to run git-ls-files from the toplevel, to be able to
see $top/file. 
(3) translation of cwd relative into toplevel relative paths.

Or is there already a way to do this with current git?

Josef
