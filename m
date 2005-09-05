From: Junio C Hamano <junkio@cox.net>
Subject: Re: git/cogito suggestion: tags with descriptions
Date: Mon, 05 Sep 2005 12:01:40 -0700
Message-ID: <7vd5nn49uz.fsf@assigned-by-dhcp.cox.net>
References: <20050905184551.GA14720@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 21:03:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECMEg-0002Hr-3S
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 21:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVIETBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 15:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbVIETBm
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 15:01:42 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56259 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932404AbVIETBm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2005 15:01:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050905190141.KCWZ3588.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Sep 2005 15:01:41 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050905184551.GA14720@tumblerings.org> (Zack Brown's message of
	"Mon, 5 Sep 2005 11:45:51 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8112>

Zack Brown <zbrown@tumblerings.org> writes:

> It would be great if tags also allowed a brief description to go along with
> them, that would show up in cg-tag-ls. Then I could seek to a tag that's just
> an easy-to-type version number, and still have an idea of what's significant
> about that version because of the descriptive text.

Would 'git tag -a' work for you?

: siamese; git tag -a -m 'This is to just demonstrate.' test-for-brown
: siamese; git cat-file tag test-for-brown
object 0516de30e8bdd26086e2a3edd3375981fd0c34d6
type commit
tag test-for-brown
tagger Junio C Hamano <junkio@cox.net> 1125946805 -0700

This is to just demonstrate.
: siamese; 

BTW, when will the next issue of GIT traffic appear ;-)?
