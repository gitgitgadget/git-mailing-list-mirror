From: Junio C Hamano <junkio@cox.net>
Subject: Re: dumb transports not being welcomed..
Date: Wed, 14 Sep 2005 09:14:21 -0700
Message-ID: <7vk6hjpqxu.fsf@assigned-by-dhcp.cox.net>
References: <7vek7s1xsh.fsf@assigned-by-dhcp.cox.net>
	<20050913211444.GA27029@mars.ravnborg.org>
	<7vacig1wrb.fsf@assigned-by-dhcp.cox.net>
	<7vpsrcwrc1.fsf@assigned-by-dhcp.cox.net>
	<20050914104539.GP15165MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 18:16:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFZu0-0006vl-78
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 18:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVINQOZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 12:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVINQOZ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 12:14:25 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:48382 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030229AbVINQOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 12:14:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914161421.EGWW7185.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 12:14:21 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050914104539.GP15165MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Wed, 14 Sep 2005 12:45:39 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8536>

Sven Verdoolaege <skimo@kotnet.org> writes:

> It doesn't help that update-server-info crashes if you run
> it for the first time on an old repo.
> Maybe it should create the appropriate directory structure on the fly,
> but the patch below at least checks whether new rev-cache could
> be created.

True; thanks for the patch.  However, since nobody seems to use
rev-cache, it _might_ make sense to just yank it out.  If it
turns out to be useful later we could always resurrect it.
