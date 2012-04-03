From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Updated tags on repo are not updated when pull
Date: Tue, 03 Apr 2012 09:45:41 -0400
Message-ID: <4F7AFF05.1030702@xiplink.com>
References: <27353249354D994D8E42D75D75FBA614896543@OASBEVEXM01.oaifield.onasgn.com>,<CAJsNXTk8R0yjad0T9605v-CMMdCA+C0v3Rqt65h_k6MK88UD9g@mail.gmail.com>,<27353249354D994D8E42D75D75FBA6148965A9@OASBEVEXM01.oaifield.onasgn.com> <27353249354D994D8E42D75D75FBA6148967BE@OASBEVEXM01.oaifield.onasgn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Sebastien Tardif <sebastien_tardif@oxfordcorp.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 15:46:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF43z-0007eV-Em
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 15:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab2DCNqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 09:46:18 -0400
Received: from smtp122.dfw.emailsrvr.com ([67.192.241.122]:55292 "EHLO
	smtp122.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab2DCNqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 09:46:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp2.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 5A91178600
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 09:46:17 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp154.ord.emailsrvr.com (smtp154.ord.emailsrvr.com [173.203.6.154])
	by smtp2.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTPS id D3A3278601
	for <git@vger.kernel.org>; Tue,  3 Apr 2012 09:46:16 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp21.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 08B2480163;
	Tue,  3 Apr 2012 09:45:42 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp21.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id B20E18011B;
	Tue,  3 Apr 2012 09:45:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120310 Thunderbird/11.0
In-Reply-To: <27353249354D994D8E42D75D75FBA6148967BE@OASBEVEXM01.oaifield.onasgn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194622>

On 12-04-03 08:00 AM, Sebastien Tardif wrote:
> Like almost everything else, if a local repo is not updated, many
> things like HEAD and branch may not point to the latest thing.

You need to wrap your head around the concept that git keeps your local 
repository's branches separate from any remote repositories'.  Even if 
my local repository has a branch "foo" and the remote also has a branch 
"foo", git stores these in separate namespaces.

> I agree that using branch is somehow a workaround, but it's still
> wrong that the tag is not updated by default when doing pull.  Even if
> I find a long documentation about this behavior, it will still be
> wrong.

Well, that's debatable and depends on how you're using git.  Other 
people's processes *want* the tags to remain unchanged.

> Let just admit git is still new, this use case is not original at
> all, it just show some outstanding issue with Git.

And indeed has been discussed at length.  The latest proposal was about 
letting tags have local and remote namespaces and to have "git fetch" 
automatically move remote tags, just like remote branches:

http://thread.gmane.org/gmane.comp.version-control.git/165799/focus=166118

		M.
