From: Junio C Hamano <junkio@cox.net>
Subject: Re: simple use case scenario for --read-tree and --write-tree with --prefix option
Date: Mon, 19 Jun 2006 00:52:03 -0700
Message-ID: <7vpsh5a8gs.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590606190028t65c76c74t6a90d1dcec411598@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 09:52:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsEYP-0005hB-I7
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 09:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWFSHwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 03:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWFSHwG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 03:52:06 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:9622 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932242AbWFSHwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 03:52:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060619075204.EFQS19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Jun 2006 03:52:04 -0400
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
In-Reply-To: <cc723f590606190028t65c76c74t6a90d1dcec411598@mail.gmail.com>
	(Aneesh Kumar's message of "Mon, 19 Jun 2006 12:58:00 +0530")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22118>

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> I searched the archives but didn't find anything. If i understand
> correctly the sub project idea is using the gitlink object type. So
> what is read-tree and write-tree with --prefix option supposed to
> achieve.

The --prefix option to read-tree was very useful when I did a
hand merge of gitweb for example.  I am reasonably sure clever
people will find other uses as well.
