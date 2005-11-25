From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: git-send-mail in sh
Date: Fri, 25 Nov 2005 11:12:09 +0100
Message-ID: <20051125101209.GA8868@puritan.petwork>
References: <4386DD45.6030308@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Nov 25 11:15:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfaZz-0007rV-2W
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 11:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbVKYKMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 05:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVKYKMM
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 05:12:12 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:62683 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751426AbVKYKMK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2005 05:12:10 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051125101209.YXGT26888.mxfep01.bredband.com@puritan.petwork>
          for <git@vger.kernel.org>; Fri, 25 Nov 2005 11:12:09 +0100
Received: by puritan.petwork (Postfix, from userid 1000)
	id 7CC59ADFE5; Fri, 25 Nov 2005 11:12:09 +0100 (CET)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4386DD45.6030308@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12731>

Andreas Ericsson wrote:

> Finally giving up on git-send-email (I won't install the 6 perl-modules 
> it requires and I don't know perl enough to remove the need for them), I 
> hacked up a replacement in sh. It's more aptly named as well. ;)

> It's better than the perl version because;
> 1. It doesn't have any requirements other than normal unix-commands and 
> "mail" being in the path.
> 2. It can generate the patches on the fly, using git-format-patch.

Great!

> It's worse than the perl version because;
> 1. It doesn't thread the patch-series (which I personally prefer anyway 
> since it's easier to follow a thread on a particular patch that way).

Not so great.  Why is it so much more difficult to have one more level
of nesting?  It's annoying, but it's a lot less annoying than having 19
separate threads that are all, in fact, related to each other.

> 2. The patches sent within the same second arrive in random order.

Perhaps adding a 'sleep 1' would help?  (The delay may be unacceptable
to some people, though.)

        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
