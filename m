From: Michal Vitecek <fuf@mageo.cz>
Subject: Re: [PATCH] Added a new placeholder '%cm' for full commit message
Date: Fri, 21 Sep 2007 13:06:46 +0200
Message-ID: <20070921110646.GA9072@mageo.cz>
References: <20070921101420.GD22869@mageo.cz> <Pine.LNX.4.64.0709211146090.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 13:06:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYgLW-0006ST-Ro
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 13:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757420AbXIULGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 07:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757414AbXIULGt
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 07:06:49 -0400
Received: from interactive-1.com ([193.85.232.82]:47646 "EHLO
	interactive-1.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503AbXIULGs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 07:06:48 -0400
Received: from interactive-1.com (localhost.localdomain [127.0.0.1])
	by interactive-1.com (Postfix) with ESMTP id 7079C23B2BB
	for <git@vger.kernel.org>; Fri, 21 Sep 2007 13:06:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709211146090.28395@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58843>

Johannes Schindelin wrote:
>On Fri, 21 Sep 2007, Michal Vitecek wrote:
>
>> I have added a new placeholder '%cm' for a full commit message.
>
>You mean the raw message, including the headers?  Why not use "%r" for 
>that?

 No, sorry for the incorrect term. I meant the whole commit message
 (subject + 2*\n + body).

>> I made it because I want to use my own pretty format which currently 
>> only allows '%s' for subject and '%b' for body. But '%b' is substituted 
>> with <undefined> if the body is "missing" which I obviously don't like 
>> :)
>
>Then you should fix %b not to show "<undefined>".

 I'll do it if it is okay. Shall I do the same for the other
 placeholders as well?

>And please adher to the tips in Documentation/SubmittingPatches.

 Will do, sorry about the attachment - still learning :)

    Thank you,
                Michal
-- 
		fuf		(fuf@mageo.cz)
