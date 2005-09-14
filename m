From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 12:19:50 -0700
Message-ID: <7vmzmfh2y1.fsf@assigned-by-dhcp.cox.net>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
	<7v3bo7jxdn.fsf@assigned-by-dhcp.cox.net>
	<59a6e5830509141208282166c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 21:22:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFcnT-0006ld-DM
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 21:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbVINTTx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbVINTTx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 15:19:53 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28152 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932755AbVINTTw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 15:19:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914191952.DINT2438.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 15:19:52 -0400
To: wsc9tt@gmail.com
In-Reply-To: <59a6e5830509141208282166c8@mail.gmail.com> (Wayne Scott's
	message of "Wed, 14 Sep 2005 14:08:05 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8556>

Could you revert one or both of these commits and try the same
test on the 64-bit box you saw problems with please?

Commit: 90a734dc7f37a7bd1f3beec4d33acad559360f6c
Author: Yasushi SHOJI <yashi@atmark-techno.com>
Date:   Sun Aug 21 16:14:16 2005 +0900

    [PATCH] possible memory leak in diff.c::diff_free_filepair()

Commit: 068eac91ce04b9aca163acb1927c3878c45d1a07
Author: Yasushi SHOJI <yashi@atmark-techno.com>
Date:   Sat Aug 13 19:58:56 2005 +0900

    [PATCH] plug memory leak in diff.c::diff_free_filepair()
