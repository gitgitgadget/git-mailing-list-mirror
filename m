From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 0/6] Fetch UI, minor improvements/fixes
Date: Wed, 27 Aug 2008 21:48:02 +0200
Message-ID: <200808272148.02345.robin.rosenberg.lists@dewire.com>
References: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:51:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYR2u-0003xn-8w
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbYH0TuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbYH0TuH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:50:07 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:45950 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYH0TuG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:50:06 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id 36B783A310; Wed, 27 Aug 2008 21:50:05 +0200 (CEST)
Received: from smtp3-1-sn3.vrr.skanova.net (smtp3-1-sn3.vrr.skanova.net [81.228.9.101])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 067693A302; Wed, 27 Aug 2008 21:50:05 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-1-sn3.vrr.skanova.net (Postfix) with ESMTP id 886A237E4A;
	Wed, 27 Aug 2008 21:50:04 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1219862506-11075-1-git-send-email-marek.zawirski@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93933>

onsdagen den 27 augusti 2008 20.41.40 skrev Marek Zawirski:
> Simple fetch UI - made smiliar as push UI: no surprise, the same
> components are used, code is analogous.
> 
> We can later decide to switch to some more complex result displaying
> component, like common Transport View as suggested by Shawn. Anyway,
> now we have working UI for push and fetch, and other signifficant
> changes were introduced in both jgit and egit in the mean 
> isn't that right time to release next version?

Indeed, this is the missing piece for a coherent version.  I'll have yet to
review the stuff, but I have great confidence in your work.
> 
> OT(?): The only strange thing I observe now is how "refresh" resources
> works in egit (master), but maybe I'll open new issues for that.

We might have bugs there.... Or actually, I *know* we have bugs including
lockups. But I can consider bumping the version anyway by next weekend, since
automatic refresh can be disabled. That'll leave us some time for things to cook.

-- robin
