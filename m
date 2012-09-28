From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: What's cooking in git.git (Sep 2012, #09; Thu, 27)
Date: Fri, 28 Sep 2012 09:57:34 -0400
Message-ID: <5065ACCE.3060302@xiplink.com>
References: <7v3922om03.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 16:08:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THbDM-0004wJ-8x
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 16:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403Ab2I1OGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 10:06:37 -0400
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:54377 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756714Ab2I1OGg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 10:06:36 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2012 10:06:36 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp25.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id C9EE4300B1A
	for <git@vger.kernel.org>; Fri, 28 Sep 2012 09:58:22 -0400 (EDT)
X-Virus-Scanned: OK
Received: from smtp130.ord.emailsrvr.com (smtp130.ord.emailsrvr.com [173.203.6.130])
	by smtp25.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTPS id B030C300B20
	for <git@vger.kernel.org>; Fri, 28 Sep 2012 09:58:22 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp29.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 3EEC61080BE;
	Fri, 28 Sep 2012 09:57:35 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp29.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id F29F4108093;
	Fri, 28 Sep 2012 09:57:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7v3922om03.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206581>

On 12-09-27 11:38 PM, Junio C Hamano wrote:
>
> * mb/remote-default-nn-origin (2012-07-11) 6 commits
>   - Teach get_default_remote to respect remote.default.
>   - Test that plain "git fetch" uses remote.default when on a detached HEAD.
>   - Teach clone to set remote.default.
>   - Teach "git remote" about remote.default.
>   - Teach remote.c about the remote.default configuration setting.
>   - Rename remote.c's default_remote_name static variables.
>
>   When the user does not specify what remote to interact with, we
>   often attempt to use 'origin'.  This can now be customized via a
>   configuration variable.
>
>   Expecting a reroll.
>
>   "The first remote becomes the default" bit is better done as a
>   separate step.

Unfortunately my days have been too full to progress this.  I'm still 
planning to get to it when there's an opportunity.  The next iteration 
would add the settings required to enable the migration plan that Junio 
outlined here:
	http://article.gmane.org/gmane.comp.version-control.git/201332

In the meantime, anyone else who feels like taking this up is more than 
welcome.  The relevant threads are:
	http://thread.gmane.org/gmane.comp.version-control.git/200145
	http://thread.gmane.org/gmane.comp.version-control.git/201065
	http://thread.gmane.org/gmane.comp.version-control.git/201306

		M.
