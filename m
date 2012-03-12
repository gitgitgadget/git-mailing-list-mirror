From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Mon, 12 Mar 2012 11:10:39 -0400
Message-ID: <4F5E11EF.501@xiplink.com>
References: <1kgpkt9.lt61vy108h530M%lists@haller-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 16:11:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S76u9-0002Kk-RG
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 16:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755856Ab2CLPKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 11:10:44 -0400
Received: from smtp182.dfw.emailsrvr.com ([67.192.241.182]:55531 "EHLO
	smtp182.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755724Ab2CLPKk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 11:10:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp8.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 145CD802E;
	Mon, 12 Mar 2012 11:10:40 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp8.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 6902B80B6;
	Mon, 12 Mar 2012 11:10:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <1kgpkt9.lt61vy108h530M%lists@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192881>

On 12-03-09 04:08 PM, Stefan Haller wrote:
> 
> But coming back to the subject of push.default: in our environment,
> "upstream" is the only default that is useful with the current behaviour
> of git.

I'm not at all surprised -- everyone works differently.  This is why the
default is configurable in the first place.

When it comes to what git should do by default, I think it's a bit pointless
to have environment-vs-environment discussions.  No matter how many people
join such a discussion on this list, it can only give us hints to which
default would best serve git's users.  Maybe the git survey can tell us what
workflows are most popular, but even that may not indicate the best default
behaviour.

The point I was trying to make in my previous message is that "upstream"
seems like the least dangerous default behaviour.  Yes, it does not match
everyone's workflow.  But it seems the least likely to shoot the feet off of
people who have yet to figure out their workflow at all.

		M.
