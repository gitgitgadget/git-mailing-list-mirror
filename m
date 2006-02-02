From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/9] http-fetch fixes
Date: Wed, 01 Feb 2006 19:02:23 -0800
Message-ID: <7vzmlaxy2o.fsf@assigned-by-dhcp.cox.net>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
	<20060201153052.GA16461@informatik.uni-freiburg.de>
	<slrndu1m14.2i8.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 04:02:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Ujs-000332-Un
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 04:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422887AbWBBDC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 22:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423066AbWBBDCZ
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 22:02:25 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:41167 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1422887AbWBBDCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 22:02:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202025957.MQVN26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 21:59:57 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrndu1m14.2i8.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Wed, 1 Feb 2006 15:47:48 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15479>

Mark Wooding <mdw@distorted.org.uk> writes:

> Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> wrote:
>
>> With these patches applied, I get now a Segfault, while cloning
>> u-boot.
> ...
> Maybe the right thing to do is to go with Nick's separate-status-
> structures patch as an actual mainline fix, with my patches for
> http-fetch.c's other bugs as a belt-and-braces.

Thanks.

I briefly looked at the series; the following may be ready to be
applied:

[PATCH 2/9] http-fetch: Fix object list corruption in fill_activ...
[PATCH 5/9] http-fetch: Fix message reporting rename of object file
[PATCH 6/9] http: Turn on verbose Curl messages if GIT_CURL_VERB...
[PATCH 7/9] http-fetch: Tidy control flow in process_alternate_r...

For now however I'll wait and see for a while, in case you can
reproduce the breakage Uwe found and add fixes to your set.
