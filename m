From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Fri, 08 Sep 2006 01:39:22 -0700
Message-ID: <7vzmdaiwg5.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	<20060908010112.6962.qmail@science.horizon.com>
	<9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
	<edra0v$42a$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 10:39:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLbtF-0000Jl-14
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 10:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWIHIjF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 04:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbWIHIjF
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 04:39:05 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53174 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751061AbWIHIjB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 04:39:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060908083901.WYIW27846.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Fri, 8 Sep 2006 04:39:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Kket1V0031kojtg0000000
	Fri, 08 Sep 2006 04:38:53 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edra0v$42a$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	08 Sep 2006 10:36:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26686>

Jakub Narebski <jnareb@gmail.com> writes:

> [*1*] From Documentation/repository-layout.txt or
> http://www.kernel.org/pub/software/scm/git/docs/repository-layout.html
>
> You can be using `objects/info/alternates` mechanism, or
> `$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanism to 'borrow'
> objects from other object stores.  A repository with this kind
> of incomplete object store is not suitable to be published for
> use with dumb transports but otherwise is OK as long as
> `objects/info/alternates` points at the right object stores
> it borrows from.

Ah, you spotted an obsolete documentation again ;-).
