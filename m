From: Junio C Hamano <junkio@cox.net>
Subject: Re: Items not covered by repository-layout.txt
Date: Mon, 10 Jul 2006 14:29:42 -0700
Message-ID: <7v1wstb12x.fsf@assigned-by-dhcp.cox.net>
References: <e8ue98$o7t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jnareb@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 10 23:29:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G03K6-0005pm-VU
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 23:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965236AbWGJV3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 17:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWGJV3o
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 17:29:44 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:5301 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965236AbWGJV3n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 17:29:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710212942.LPNA19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 17:29:42 -0400
To: git@vger.kernel.org
In-Reply-To: <e8ue98$o7t$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	10 Jul 2006 22:46:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23655>

Jakub Narebski <jnareb@gmail.com> writes:

> I have noticed few files in .git/ directory which currently are not covered
> (and neither is their format) by Documentation/repository-layout.txt
>
> * COMMIT_EDITMSG (temporary file, when I decided during writing commit
>   message that I should change something before commit)
> * FETCH_HEAD (format?)
> * HEAD, ORIG_HEAD and probably some other *_HEAD
> * .tmp-vtag (I'm not sure what have left that, probably git-verify-tag
>   broken due to lack of signing PGP keys)
> * description file
>
> I know they are fairly obvious, but having everything that one could fing in
> his/her git-core managed .git repository would be nice... 

Yup, please make it so.
