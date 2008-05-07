From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Documentation/config.txt: Add git-gui options
Date: Wed, 7 May 2008 19:09:48 -0400
Message-ID: <20080507230948.GT29038@spearce.org>
References: <1210102745-7415-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Thu May 08 01:10:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtsmZ-0004hJ-2v
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 01:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbYEGXJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 19:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755995AbYEGXJx
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 19:09:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39931 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754976AbYEGXJv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 19:09:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JtslX-00021x-RJ; Wed, 07 May 2008 19:09:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2154820FBAE; Wed,  7 May 2008 19:09:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1210102745-7415-1-git-send-email-hendeby@isy.liu.se>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81492>

Gustaf Hendeby <hendeby@isy.liu.se> wrote:
> The 'git gui' has a number of options that can be specified using the
> options dialog. Sometimes it is convenient to be able to specify these
> from the command line, therefor document these options.
> 
> Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>

Acked-by: Shawn O. Pearce <speace@spearce.org>

>  Documentation/config.txt |   31 +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
...
> +gui.spellingdictionary::
> +	Specify the dictionary used for spell checking commit messages in
> +	the linkgit:git-gui[1]. When set to "none" spelling is turned off,
> +	making linkgit:git-gui[1] to start on systems with aspell previous
> +	to version 0.6.
> +

For what it is worth, this is already fixed in git-gui.git master,
which we should be shipping with 1.5.6 when it comes out.  I just
keep getting distracted by other tasks and forget to ask Junio to
pull my tree.

-- 
Shawn.
