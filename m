From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Fri, 17 Feb 2006 22:49:48 -0800
Message-ID: <7vzmkpupo3.fsf@assigned-by-dhcp.cox.net>
References: <20060217142836.13137.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 07:50:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FALum-00075j-EZ
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 07:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWBRGtx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 01:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWBRGtx
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 01:49:53 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:3279 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750879AbWBRGtx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 01:49:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218064817.VOU6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 01:48:17 -0500
To: linux@horizon.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16386>

linux@horizon.com writes:

> Er... what does this do, again?  I couldn't find the list
> discussion, and I can get this exact effect in vanilla 1.2.1
> with "git rebase master~1 topic".
>...
> OTOH, I can imagine wanting
>...
>               A   B---C topic
>              /   /
>         D---E---F---G master

Yup.  The example was a bad one, but the above, and in general

         X---A'--B'--C' topic

         D---E---F---G master

on an arbitrary X was what I wanted to do.
