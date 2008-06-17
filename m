From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH 21/20] Make isBetterDeltaReuseLoader() static in PackWriter
Date: Wed, 18 Jun 2008 00:07:00 +0200
Message-ID: <200806180007.01061.robin.rosenberg.lists@dewire.com>
References: <1213566349-25395-20-git-send-email-marek.zawirski@gmail.com> <1213738134-6221-1-git-send-email-marek.zawirski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 00:11:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8jOq-00064c-5p
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 00:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757549AbYFQWKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 18:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758173AbYFQWKl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 18:10:41 -0400
Received: from av8-2-sn3.vrr.skanova.net ([81.228.9.184]:39612 "EHLO
	av8-2-sn3.vrr.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756389AbYFQWKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 18:10:40 -0400
Received: by av8-2-sn3.vrr.skanova.net (Postfix, from userid 502)
	id D076F394F1; Wed, 18 Jun 2008 00:10:38 +0200 (CEST)
Received: from smtp3-2-sn3.vrr.skanova.net (smtp3-2-sn3.vrr.skanova.net [81.228.9.102])
	by av8-2-sn3.vrr.skanova.net (Postfix) with ESMTP
	id 947A0394F3; Wed, 18 Jun 2008 00:10:38 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp3-2-sn3.vrr.skanova.net (Postfix) with ESMTP id 2D3D637E4A;
	Wed, 18 Jun 2008 00:10:38 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1213738134-6221-1-git-send-email-marek.zawirski@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85332>

tisdagen den 17 juni 2008 23.28.54 skrev Marek Zawirski:
> Implementation was already static, it's just a fix for clarity and
> potential speed-up.
> 
> Reported-by: Shawn O. Pearce <spearce@spearce.org>
> Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
> ---
> It could be squashed with patch 19/20. I can clean up this mess, adding 
> also Shawn's patch - just let me know what is preferred way (squash
> commits, commits on top?).

If the code is already merged then patch on top, else squashing or rebase,
unless you feel there is a reason not to. We can pretend it was right from
the start :)  I see no educational value in having a separate patch in this case.

-- robin
