From: Martin L Resnick <mresnick@bbn.com>
Subject: I can never finish a push
Date: Fri, 23 Dec 2011 08:11:15 -0500
Message-ID: <4EF47DF3.9080809@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 14:39:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re5Lm-0003D7-CB
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 14:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757187Ab1LWNjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 08:39:47 -0500
Received: from smtp.bbn.com ([128.33.0.80]:49172 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754132Ab1LWNjr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 08:39:47 -0500
X-Greylist: delayed 1710 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Dec 2011 08:39:47 EST
Received: from [128.89.254.25] (port=33282)
	by smtp.bbn.com with esmtps (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.74 (FreeBSD))
	(envelope-from <mresnick@bbn.com>)
	id 1Re4u3-000HlS-OL
	for git@vger.kernel.org; Fri, 23 Dec 2011 08:11:15 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110922 Lightning/1.0b2 Thunderbird/3.1.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187627>

I'm working remotely over a VERY slow line.

When I do a push it starts out fine
but after the 15 seconds it takes to push
it fails with non-fast-forward merge.

So I pull (no merge needed, its fast-forward)
and try push again. Fails again.

I can keep this up for hours on end;
pushing, pulling, pushing, pulling.
Apparently there is fast and furious development
on the branch I'm on that during my 15 seconds
of pushing someone else on-site pushes and adds
new commits before mine can finish.

Is there anyway to lock the repository while
my push is going on ?

Please don't ask why I have a slow line
or why the volume of changes that I am pushing.
Suffice it to say its military work.
