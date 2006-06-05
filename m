From: Junio C Hamano <junkio@cox.net>
Subject: Re: Using pickaxe to track changed symbol CR4_FEATURES_ADDR
Date: Mon, 05 Jun 2006 13:03:34 -0700
Message-ID: <7v8xob4bft.fsf@assigned-by-dhcp.cox.net>
References: <20060605102627.GB24346@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 22:03:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnLIZ-0002Pc-31
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 22:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWFEUDg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 16:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWFEUDg
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 16:03:36 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1767 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751384AbWFEUDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 16:03:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605200335.SKSO14446.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 16:03:35 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21335>

Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

> I am looking for the symbol CR4_FEATURES_ADDR which must be gone in one
> of the last kernel revision. Now how I do use pickaxe to track any
> changes that involve my missing symbol? Or is there a better way to
> track that change down?

None of the major recent versions seem to have the symbol.

	: gitster; git grep -e CR4_FEATURES_ADDR \
        	v2.6.12-rc2 v2.6.12 v2.6.13 v2.6.14 v2.6.15 \
        	v2.6.16

and I did not get any google hits for "CR4_FEATURES_ADDR".  Are
you spelling it right?
