From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails from git-format-patch-script
Date: Sun, 31 Jul 2005 19:54:39 -0400
Message-ID: <20050731235439.GI32263@mythryan2.michonline.com>
References: <11227978451100@foobar.com> <Pine.LNX.4.58.0507311223240.16181@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 01:56:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzNev-0006n9-2m
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 01:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262166AbVGaXzY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 19:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262165AbVGaXzY
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 19:55:24 -0400
Received: from mail.autoweb.net ([198.172.237.26]:38276 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262162AbVGaXyn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 19:54:43 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DzNdg-0008JA-J2; Sun, 31 Jul 2005 19:54:40 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DzNnU-000357-00; Sun, 31 Jul 2005 20:04:48 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DzNdf-0000nl-Vg; Sun, 31 Jul 2005 19:54:39 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507311223240.16181@wgmdd8.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 31, 2005 at 12:25:13PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> wouldn't it be a good idea to make $from and $to required parameters? At
> least you could infer a sensible default of $from from GIT_* environment
> variables, no? I am not quite comfortable with a hard coded sender in a
> script possibly deployed into a multi-user environment.

The sender isn't hardcoded.

If it isn't sent on the command line, the return value from git-var -l
is used to set a default, which is then confirmed by the ReadLine
interface.

Some of the comments were leftover from Greg's original, before I
remembered to remove them - it should be better now if you take another
look.  (See my, soon to be sent, set of additional changes.)

-- 

Ryan Anderson
  sometimes Pug Majere
