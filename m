From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Add read_cache_from() and discard_cache()
Date: Tue, 04 Jul 2006 10:41:58 -0700
Message-ID: <7vodw5gtcp.fsf@assigned-by-dhcp.cox.net>
References: <20060630002756.GD22618@steel.home>
	<Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0606301643150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v3bdmk2zj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607011657460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64ihdupr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607021043550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virmepfhx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607041617290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 19:42:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxouY-0004Sj-FP
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 19:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWGDRmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 13:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWGDRmA
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 13:42:00 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:4739 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932243AbWGDRl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 13:41:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704174158.LEAG554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 13:41:58 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607041617290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 4 Jul 2006 16:18:49 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23303>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Ummm. After reading my original mail again: bad tobacco that was. Of 
> course, I meant discard_cache(), not get_merge_bases(). Setting 
> index_file_timestamp in get_merge_bases() would be wrong.

I was well aware you were talking about discard_cache().  I
think these two clean-ups are good to have there.
