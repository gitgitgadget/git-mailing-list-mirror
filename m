From: Stefan =?utf-8?b?TsOkd2U=?= <stefan.naewe+git@gmail.com>
Subject: Re: Tagging stable releases
Date: Wed, 15 Apr 2009 16:15:51 +0000 (UTC)
Message-ID: <loom.20090415T161255-114@post.gmane.org>
References: <23045562.post@talk.nabble.com> <49E59BC9.5060906@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 15 18:18:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu7oS-0001Jc-Fy
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 18:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754251AbZDOQQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 12:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754771AbZDOQQH
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 12:16:07 -0400
Received: from main.gmane.org ([80.91.229.2]:50961 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754288AbZDOQQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 12:16:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lu7mN-0007Bv-IG
	for git@vger.kernel.org; Wed, 15 Apr 2009 16:16:03 +0000
Received: from dyndsl-095-033-077-254.ewe-ip-backbone.de ([95.33.77.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 16:16:03 +0000
Received: from stefan.naewe+git by dyndsl-095-033-077-254.ewe-ip-backbone.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Apr 2009 16:16:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 95.33.77.254 (Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.0.8) Gecko/2009032711 Ubuntu/8.10 (intrepid) Firefox/3.0.8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116621>

Andreas Ericsson <ae <at> op5.se> writes:

> 
> At $dayjob, we have an update hook preventing tags without the "-beta$X"
> suffix from being pushed unless it points to an already tagged commit,
> so our workflow goes like this:
> 1 hack hack hack
> 2 beta-tag
> 3 buildbot builds beta package and sends it off to qa
> 4 qa responds with "ok to release"
> 5 we stable-tag the exact same version we shipped to qa
> 6 buildbot builds stable tag and copies it to "to-be-released" directory
> 7 release-manager pushes the release-button once changelogs and stuff
>   are in place

You've been talking about using git at your $dayjob quite often.
Any chance to share some of your 'infrastructure' (like hooks, e.g.) ?

Thanks

Stefan
