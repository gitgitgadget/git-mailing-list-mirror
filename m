From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2] git-svn: use SVN::Ra::get_dir2 when possible
Date: Fri, 31 Oct 2014 19:08:06 +0000
Message-ID: <20141031190805.GA17314@dcvr.yhbt.net>
References: <20141031101530.GA29248@dcvr.yhbt.net>
 <20141031103403.GA6190@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, sam@vilain.net,
	stevenrwalter@gmail.com, waste.manager@gmx.de, amyrick@apple.com,
	Hin-Tak Leung <htl10@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 20:08:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkHYT-0003qH-FT
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 20:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849AbaJaTII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 15:08:08 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47625 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbaJaTIH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 15:08:07 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC631F838;
	Fri, 31 Oct 2014 19:08:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141031103403.GA6190@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <normalperson@yhbt.net> wrote:
> This avoids the following failure with normal "get_dir" on newer
> versions of SVN (tested with SVN 1.8.8-1ubuntu3.1):
> 
>   Incorrect parameters given: Could not convert '%ld' into a number

Filed a bug in Debian since I hit it in sid, too:
http://bugs.debian.org/767530

Thanks all.
