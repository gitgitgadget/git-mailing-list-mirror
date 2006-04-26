From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make die() and error() prefix line with binary name if set
Date: Wed, 26 Apr 2006 01:32:37 -0700
Message-ID: <7vejzkrb2y.fsf@assigned-by-dhcp.cox.net>
References: <20060425101207.GC5482@bolero.cs.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 26 10:33:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYfSP-0001lf-DK
	for gcvg-git@gmane.org; Wed, 26 Apr 2006 10:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWDZIcj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Apr 2006 04:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWDZIcj
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Apr 2006 04:32:39 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:27571 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751057AbWDZIcj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Apr 2006 04:32:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060426083238.RSXY25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Apr 2006 04:32:38 -0400
To: Rocco Rutte <pdmef@gmx.net>
In-Reply-To: <20060425101207.GC5482@bolero.cs.tu-berlin.de> (Rocco Rutte's
	message of "Tue, 25 Apr 2006 12:12:08 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19192>

Rocco Rutte <pdmef@gmx.net> writes:

> Now, git_set_appname() can be used to set the name of the binary
> as first call in a binary's main() routine which will be used
> as prefix in die() and error(). If it was not called, no prefix
> will be printed.

I agree with the general direction, but...

> @@ -1960,6 +1960,8 @@ int main(int argc, char **argv)
>  	int read_stdin = 1;
>  	const char *whitespace_option = NULL;
>  +	git_set_appname("git-apply");
> +
>  	for (i = 1; i < argc; i++) {
>  		const char *arg = argv[i];
>  		char *end;

... what's wrong with your mailer?
