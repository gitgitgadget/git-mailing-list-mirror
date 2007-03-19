From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH]: remove extra-verbosity from git-clone (http)
Date: Mon, 19 Mar 2007 16:04:36 -0700
Message-ID: <20070319230436.GB12555@sequoia.sous-sol.org>
References: <58d389c20702150910x24ec218bjdb9cb49ee03fd1df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fernando Herrera <fherrera@onirica.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 00:08:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTQy7-00063h-Oj
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 00:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965405AbXCSXIp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 19:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965407AbXCSXIo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 19:08:44 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:33546 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965405AbXCSXIo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 19:08:44 -0400
Received: from sous-sol.org (localhost.localdomain [127.0.0.1])
	by sous-sol.org (8.13.8/8.13.7) with ESMTP id l2JN4a57016786;
	Mon, 19 Mar 2007 16:04:36 -0700
Received: (from chrisw@localhost)
	by sous-sol.org (8.13.8/8.13.7/Submit) id l2JN4a6U016785;
	Mon, 19 Mar 2007 16:04:36 -0700
Content-Disposition: inline
In-Reply-To: <58d389c20702150910x24ec218bjdb9cb49ee03fd1df@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
X-Spam-Status: No, score=-2.3 required=5.0 tests=AWL,BAYES_00,HOT_NASTY,
	UNPARSEABLE_RELAY autolearn=ham version=3.1.4
X-Spam-Checker-Version: SpamAssassin 3.1.4 (2006-07-25) on 
	sequoia.sous-sol.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42679>

* Fernando Herrera (fherrera@onirica.com) wrote:
> the attached patch removes the extra verbosity when cloning a http
> repository. I noticed this after some git upgrade in fedora. Please,
> consider applying it, getting tons of "got XXX", "walk XXX" lines by
> default is a little bit annoying.
> 
> Salu2
> 
> PS: Thanks for this so great piece os software!
> 
> --- git-clone.sh.orig	2007-02-15 19:03:51.000000000 +0200
> +++ git-clone.sh	2007-02-15 19:04:06.000000000 +0200
> @@ -59,7 +59,7 @@
>  		else
>  			tname=$name
>  		fi
> -		git-http-fetch -v -a -w "$tname" "$name" "$1/" || exit 1
> +		git-http-fetch -a -w "$tname" "$name" "$1/" || exit 1
>  	done <"$clone_tmp/refs"
>  	rm -fr "$clone_tmp"
>  	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||

Was there any problem with this patch from Fernando?  I don't care much
either way (I simply never use http fetch myself ;-).  Just doing some
old bugzilla cleanup and noticed this still was neither picked up nor
replied to.  So, in case it just fell through the cracks...

thanks,
-chris
