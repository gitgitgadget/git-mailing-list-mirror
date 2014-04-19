From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC/PATCHv3 3/3] Git 2.0: git svn: Set default
 --prefix='origin/' if --prefix is not given
Date: Sat, 19 Apr 2014 08:32:10 +0000
Message-ID: <20140419083210.GA28771@dcvr.yhbt.net>
References: <1381015833-696-1-git-send-email-johan@herland.net>
 <1381496227-28700-1-git-send-email-johan@herland.net>
 <1381496227-28700-4-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tfnico@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Apr 19 10:32:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbQh8-0006S7-Ba
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 10:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbaDSIcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 04:32:14 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45219 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751049AbaDSIcL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2014 04:32:11 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id D95B320E52;
	Sat, 19 Apr 2014 08:32:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1381496227-28700-4-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246509>

Johan Herland <johan@herland.net> wrote:
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -86,14 +86,7 @@ COMMANDS
>  	(refs/remotes/$remote/*). Setting a prefix is also useful
>  	if you wish to track multiple projects that share a common
>  	repository.
> -+
> -NOTE: In Git v2.0, the default prefix will CHANGE from "" (no prefix)
> -to "origin/". This is done to put SVN-tracking refs at
> -"refs/remotes/origin/*" instead of "refs/remotes/*", and make them
> -more compatible with how Git's own remote-tracking refs are organized
> -(i.e. refs/remotes/$remote/*). You can enjoy the same benefits today,
> -by using the --prefix option.
> -
> +	By default, the prefix is set to 'origin/'.

We should maintain a description of <=1.9 behavior in the manpage.
Users on long-term-support systems are likely to continue using ancient
git installations for some time (5-10 years, even?), but may come across
the current documentation online.

Otherwise the patch looks fine and I can push it up for Junio for
2.0-rc1.
