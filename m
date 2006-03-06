From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Sun, 05 Mar 2006 22:28:15 -0800
Message-ID: <7vk6b8axz4.fsf@assigned-by-dhcp.cox.net>
References: <20060305111334.GB23448@c165.ib.student.liu.se>
	<440B751F.5000801@michonline.com>
	<46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com>
	<20060306024353.GA23001@mythryan2.michonline.com>
	<440BC92E.4060306@gmail.com> <440BCB67.4070406@michonline.com>
	<20060306055036.GB26820@spearce.org> <440BD4F4.3060906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 07:28:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG9Cf-0000TN-5r
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 07:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWCFG2S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 01:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCFG2S
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 01:28:18 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61826 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751338AbWCFG2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 01:28:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060306062532.VSON17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Mar 2006 01:25:32 -0500
To: gitzilla@gmail.com
In-Reply-To: <440BD4F4.3060906@gmail.com> (A. Large Angry's message of "Sun,
	05 Mar 2006 22:21:40 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17279>

> Is there any reason that git-{annotate,blame} can't take more than one
> filename, ever?

I do not see it would be much useful -- the output does not
have a sign to show file boundary.
