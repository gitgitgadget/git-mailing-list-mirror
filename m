From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Add read_cache_from() and discard_cache()
Date: Mon, 03 Jul 2006 14:04:10 -0700
Message-ID: <7virmepfhx.fsf@assigned-by-dhcp.cox.net>
References: <20060630002756.GD22618@steel.home>
	<Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0606301643150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v3bdmk2zj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607011657460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64ihdupr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607021043550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 23:04:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxVaa-0002Cg-B3
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 23:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWGCVEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 17:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWGCVEM
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 17:04:12 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:30136 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932122AbWGCVEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 17:04:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703210411.BMNB19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 17:04:11 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23209>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay. After reading the comment, I am quite certain we can just set the 
> index_file_timestamp to 0.

Thanks.

> So, I still think that these two lines should be in the cleanup part of 
> get_merge_bases().

I think that is sane -- please make it so.

> BTW personally, I prefer the one-function approach, i.e. a flag which says 
> if it is okay not to clean up.

Yup. Agreed.
