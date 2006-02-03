From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/9] http-fetch fixes
Date: Fri, 03 Feb 2006 12:42:58 -0800
Message-ID: <7v64nwdvhp.fsf@assigned-by-dhcp.cox.net>
References: <20060201112822.5042.41256.stgit@metalzone.distorted.org.uk>
	<20060201153052.GA16461@informatik.uni-freiburg.de>
	<slrndu1m14.2i8.mdw@metalzone.distorted.org.uk>
	<7vzmlaxy2o.fsf@assigned-by-dhcp.cox.net>
	<slrndu7enh.2i8.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 21:43:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F57lq-00033Q-8Z
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422921AbWBCUnD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422931AbWBCUnD
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:43:03 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38548 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1422921AbWBCUnA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 15:43:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203204042.TFUV17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 15:40:42 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrndu7enh.2i8.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Fri, 3 Feb 2006 20:20:01 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15552>

Mark Wooding <mdw@distorted.org.uk> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> I briefly looked at the series; the following may be ready to be
>> applied:
>>
>> [PATCH 2/9] http-fetch: Fix object list corruption in fill_activ...
>> [PATCH 5/9] http-fetch: Fix message reporting rename of object file
>> [PATCH 6/9] http: Turn on verbose Curl messages if GIT_CURL_VERB...
>> [PATCH 7/9] http-fetch: Tidy control flow in process_alternate_r...
>>
>> For now however I'll wait and see for a while, in case you can
>> reproduce the breakage Uwe found and add fixes to your set.
>
> I've not had any more trouble with this since, but I'm still worried
> that the http fetcher is rather fragile. :-(
>
> What was wrong with 3/9, by the way?  (It's the abort_active_slot patch
> -- which does fix a real bug.)

I saw Nick raised an alternative and you responded but I did not
see Nick agreeing or disagreeing to it, and I haven't spent
enough time on that to convince myself which way to go.  That is
why.

Maybe this weekend.
