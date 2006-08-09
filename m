From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Update git-init-db(1) and documentation of core.sharedRepository
Date: Tue, 08 Aug 2006 17:47:18 -0700
Message-ID: <7vejvqu44p.fsf@assigned-by-dhcp.cox.net>
References: <20060809002623.GB10115@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 02:47:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAcEG-00081l-3s
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 02:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbWHIArU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 20:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWHIArU
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 20:47:20 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:10716 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030375AbWHIArT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Aug 2006 20:47:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809004719.TEDH29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Aug 2006 20:47:19 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060809002623.GB10115@diku.dk> (Jonas Fonseca's message of
	"Wed, 9 Aug 2006 02:26:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25106>

Jonas Fonseca <fonseca@diku.dk> writes:

> Combine option descriptions in git-init-db(1). Reflect the changes to
> additionally allow all users to read the created git repository.

Thanks.

> I noticed that the git-init-db(1) --template description says: "The
> default template directory is `/usr/share/git-core/templates`", which
> makes me wonder if we should substitute these hard-coded paths when
> installing the man pages ...

While it would be nicer, I do not think it is worth it.  After
all it says "The default..." -- if a particular installation is
not using the default location, I expect that the users are
clever enough to adjust the reading of it.
