From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: List environmental variables which were missing
Date: Sat, 11 Aug 2007 18:38:52 -0700
Message-ID: <7v643llefn.fsf@assigned-by-dhcp.cox.net>
References: <1186871917846-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 03:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK2Px-0001wW-FA
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 03:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756240AbXHLBiy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 21:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756059AbXHLBiy
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 21:38:54 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54858 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810AbXHLBix (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 21:38:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812013853.JGZT325.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 21:38:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id apes1X00V1kojtg0000000; Sat, 11 Aug 2007 21:38:53 -0400
In-Reply-To: <1186871917846-git-send-email-jnareb@gmail.com> (Jakub Narebski's
	message of "Sun, 12 Aug 2007 00:38:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55656>

Jakub Narebski <jnareb@gmail.com> writes:

> Add to list environmental variables in "Environment variables" section
> of git(7)...

These are "environment variables", not "environmental".  You
have the same typo in gitweb/INSTALL, I think.

>  other
>  ~~~~~
> +'GIT_CONFIG'::
> +'GIT_CONFIG_LOCAL'::
> +	Specifies config file.
> +	See gitlink:git-config[1]

I think this should probably be listed next to GIT_DIR and
friends.

Isn't "Specifies config file" way too vague to be any useful?

If you do not describe them enough on this page, saying "there
are other environment variables that affect the operation of
git; see git-config[1] for details" without listing them is just
as useful (or, just as useless).  At least doing so would need
much less maintenance.

> +'GIT_PROXY_COMMAND'::
> +'GIT_SSL_NO_VERIFY'::
> +'GIT_SSL_CERT'::
> +'GIT_SSL_KEY'::
> +'GIT_SSL_CAINFO'::
> +'GIT_SSL_CAPATH'::
> +'GIT_HTTP_MAX_REQUESTS'::
> +'GIT_HTTP_LOW_SPEED_LIMIT'::
> +'GIT_HTTP_LOW_SPEED_TIME'::
> +'GIT_CURL_FTP_NO_EPSV'::
> +	Overrides appropriate configuration variable.
> +	See gitlink:git-config[1]

I wonder if it is worth it to add them in this form (the same
"usefulness vs maintenance hassle" comment applies to the
vagueness of "appropriate variable").

Everything other than GIT_PROXY_COMMAND is for http fetch, isn't
it?  At least you could say something like:

	Used to override http.* configuration variables (see
	gitlink:git-config[1])
