From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (fixed)] rebase: Allow merge strategies to be used when rebasing
Date: Wed, 21 Jun 2006 04:01:35 -0700
Message-ID: <7v4pye22nk.fsf@assigned-by-dhcp.cox.net>
References: <20060621100138.GA15748@localdomain>
	<11508842824018-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 13:01:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft0So-00007C-RP
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 13:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWFULBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 07:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWFULBh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 07:01:37 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:53946 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751496AbWFULBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 07:01:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621110135.CBHY12581.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 07:01:35 -0400
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22257>

Eric Wong <normalperson@yhbt.net> writes:

> 1 - is fixed for --onto usage.

More importantly, it used to rebase "side edits further" commit
incorrectly in the test sequence -- the commit should only touch
"newfile", but it touched "renamed" as well.  Your updated patch
fixes this problem.
