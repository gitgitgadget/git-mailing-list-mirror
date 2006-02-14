From: Junio C Hamano <junkio@cox.net>
Subject: Re: Quick question
Date: Mon, 13 Feb 2006 16:40:39 -0800
Message-ID: <7vy80eydq0.fsf@assigned-by-dhcp.cox.net>
References: <43F0B577.4070608@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 01:40:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8oFH-0001Qj-UB
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 01:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWBNAkl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 19:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWBNAkl
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 19:40:41 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:50622 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030336AbWBNAkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 19:40:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214004045.RTSA25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Feb 2006 19:40:45 -0500
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
In-Reply-To: <43F0B577.4070608@gorzow.mm.pl> (Radoslaw Szkodzinski's message
	of "Mon, 13 Feb 2006 17:36:07 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16093>

Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> writes:

> How to display ignored files of the whole project using only core git?
>
> I've tried:
>
> git-ls-files -o -i -X .git/info/exclude
>
> and it only showed me the excluded files in the current directory...

With the git.git repository itself, I tried:

$ cat /var/tmp/i
*.c
$ git ls-files -i -X /var/tmp/i | head -n 6
apply.c
arm/sha1.c
blob.c
cat-file.c
check-ref-format.c
checkout-index.c

So I am not sure what you mean.  You wanted to "display ignored
files of the whole project", right?  I am getting arm/sha1.c
here in my output, so I do not understand the issue here...
