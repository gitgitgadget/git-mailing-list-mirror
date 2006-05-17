From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Patch] git-cvsimport: tiny fix
Date: Wed, 17 May 2006 12:12:55 -0700
Message-ID: <7vd5eccvns.fsf@assigned-by-dhcp.cox.net>
References: <20060510173703.GA10335@memak.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elrond <elrond+kernel.org@samba-tng.org>
X-From: git-owner@vger.kernel.org Wed May 17 21:13:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgRS7-0001DJ-UJ
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWEQTM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWEQTM4
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:12:56 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:37275 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750984AbWEQTM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 15:12:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517191256.DCXO18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 15:12:56 -0400
To: git@vger.kernel.org
In-Reply-To: <20060510173703.GA10335@memak.tu-darmstadt.de>
	(elrond+kernel.org@samba-tng.org's message of "Wed, 10 May 2006
	19:37:04 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20226>

Elrond <elrond+kernel.org@samba-tng.org> writes:

> git-cvsimport: Handle "Removed" from pserver
>
> Sometimes the pserver says "Removed" instead of
> "Remove-entry".
>
> Signed-off-by: Elrond <elrond+kernel.org@samba-tng.org>
> ---
> Hi,
>
> At least the above happened to me on a repository I tried
> to convert.
> Without the patch, it just die("Unknown: Removed ...")s.

Could somebody who actually works with CVS import Ack this?
Pretty please?
